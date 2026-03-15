local ESX = ESX or exports['es_extended']:getSharedObject()
local ResourceName = GetCurrentResourceName()
local function E(name) return ("%s:%s"):format(ResourceName, name) end

local function getIdentifier(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer and xPlayer.identifier or nil
end

local function fetchAll(sql, params)
    return exports.oxmysql:fetchSync(sql, params or {})
end

local function execute(sql, params)
    return exports.oxmysql:executeSync(sql, params or {})
end

local function insert(sql, params)
    return exports.oxmysql:insertSync(sql, params or {})
end

local function getSocietyAccount(society)
    local acct
    TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
        acct = account
    end)
    return acct
end

local function sendDiscordLog(kind, payload)
    local cfg = (kind == "SendBill") and Config.SendBill or Config.PayBill
    if cfg and cfg.enable and type(cfg.trigger) == "string" then
        TriggerEvent(cfg.trigger, cfg.type or kind, payload)
    end
end

ESX.RegisterServerCallback(E("getMyBills"), function(src, cb)
    local identifier = getIdentifier(src)
    if not identifier then cb({}) return end
    local rows = fetchAll("SELECT id, label, amount, society, sender_identifier FROM billing WHERE identifier = ? ORDER BY id DESC", { identifier })
    cb(rows or {})
end)

RegisterNetEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(target, society, amount, label)
    local src = source
    local targetId = tonumber(target)
    if not targetId then return end
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then return end
    local amt = tonumber(amount)
    if not amt or amt <= 0 then return end
    local senderId = getIdentifier(src)
    local labelText = tostring(label or "Invoice")
    local societyName = tostring(society or "")
    insert("INSERT INTO billing (identifier, sender_identifier, label, amount, society) VALUES (?,?,?,?,?)",
        { xTarget.identifier, senderId or "", labelText, amt, societyName })
    sendDiscordLog("SendBill", { from = senderId, to = xTarget.identifier, label = labelText, amount = amt, society = societyName })
end)

RegisterNetEvent('esx_billing:sendBillzone')
AddEventHandler('esx_billing:sendBillzone', function(target, society, zoneLabel, amount, dcid)
    local src = source
    local targetId = tonumber(target)
    if not targetId then return end
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then return end
    local amt = tonumber(amount)
    if not amt or amt <= 0 then return end
    local senderId = getIdentifier(src)
    local labelText = tostring(zoneLabel or "Invoice")
    local societyName = tostring(society or "")
    insert("INSERT INTO billing (identifier, sender_identifier, label, amount, society) VALUES (?,?,?,?,?)",
        { xTarget.identifier, senderId or "", labelText, amt, societyName })
    sendDiscordLog("SendBill", { from = senderId, to = xTarget.identifier, label = labelText, amount = amt, society = societyName, dcid = dcid })
end)

RegisterNetEvent('esx_billing:payBill')
AddEventHandler('esx_billing:payBill', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local billId = tonumber(id)
    if not billId then return end
    local rows = fetchAll("SELECT id, identifier, sender_identifier, label, amount, society FROM billing WHERE id = ?", { billId })
    local bill = rows and rows[1]
    if not bill then return end
    if bill.identifier ~= xPlayer.identifier then return end
    local amount = tonumber(bill.amount or 0) or 0
    if amount <= 0 then
        execute("DELETE FROM billing WHERE id = ?", { billId })
        return
    end
    local bankBal = xPlayer.getAccount('bank') and xPlayer.getAccount('bank').money or 0
    if bankBal < amount then return end
    xPlayer.removeAccountMoney('bank', amount)
    local society = tostring(bill.society or "")
    local senderIdent = bill.sender_identifier or ""
    local cutPercent = 0
    if Config.BillCut and society ~= "" then
        cutPercent = tonumber(Config.BillCut[society] or 0) or 0
    end
    local cutAmt = math.floor(amount * (cutPercent / 100))
    local remainAmt = amount - cutAmt
    if society ~= "" then
        local acct = getSocietyAccount(society)
        if acct then acct.addMoney(cutAmt) end
    end
    if senderIdent ~= "" and remainAmt > 0 then
        for _, pid in ipairs(GetPlayers()) do
            local xp = ESX.GetPlayerFromId(tonumber(pid))
            if xp and xp.identifier == senderIdent then
                xp.addAccountMoney('bank', remainAmt)
                break
            end
        end
    end
    execute("DELETE FROM billing WHERE id = ?", { billId })
    sendDiscordLog("PayBill", { payer = xPlayer.identifier, id = billId, label = bill.label, amount = amount, society = society, sender = senderIdent })
end)

ESX.RegisterServerCallback(E("getBalance"), function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then cb({ Money = 0, balance = 0 }) return end
    local cash = xPlayer.getMoney()
    local bank = xPlayer.getAccount('bank') and xPlayer.getAccount('bank').money or 0
    cb({ Money = cash, balance = bank })
end)

