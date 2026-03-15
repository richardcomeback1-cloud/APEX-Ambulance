local pendingCarryRequests = {}
local activeCarries = {}

local function setCarry(carrierId, targetId)
    activeCarries[carrierId] = targetId
end

local function clearCarry(carrierId)
    activeCarries[carrierId] = nil
end

local function removePendingBySource(sourceId)
    for targetId, request in pairs(pendingCarryRequests) do
        if request.source == sourceId then
            pendingCarryRequests[targetId] = nil
        end
    end
end

RegisterNetEvent("NSPx_HoldUp:CarryCorpse", function(targetId)
    local sourceId = source
    if not targetId then return end

    setCarry(sourceId, targetId)
    TriggerClientEvent("NSPx_HoldUp:CarryCorpse", targetId, sourceId)
end)

RegisterNetEvent("NSPx_HoldUp:CarrySync", function(targetId)
    local sourceId = source
    if not targetId then return end

    setCarry(sourceId, targetId)
    TriggerClientEvent("NSPx_HoldUp:CarrySync", targetId, sourceId)
end)

RegisterNetEvent("NSPx_HoldUp:DropCorpse", function(targetId)
    local sourceId = source
    if not targetId then return end

    clearCarry(sourceId)
    TriggerClientEvent("NSPx_HoldUp:DropCorpse", targetId, sourceId)
    TriggerClientEvent("NSPx_HoldUp:ClearCarry", sourceId, targetId)
end)

RegisterNetEvent("NSPx_HoldUp:ClearCarry", function(targetId)
    local sourceId = source
    if not targetId then return end

    clearCarry(sourceId)
    TriggerClientEvent("NSPx_HoldUp:DropCorpse", targetId, sourceId)
    TriggerClientEvent("NSPx_HoldUp:ClearCarry", sourceId, targetId)
end)

RegisterNetEvent("NSPx_HoldUp:RequestCarry", function(targetId, carryKey)
    local sourceId = source
    if not targetId or not carryKey then return end

    pendingCarryRequests[targetId] = {
        source = sourceId,
        key = carryKey
    }

    TriggerClientEvent("NSPx_HoldUp:RequestCarry", targetId, sourceId, carryKey)
end)

RegisterNetEvent("NSPx_HoldUp:AcceptCarry", function()
    local targetId = source
    local request = pendingCarryRequests[targetId]
    if not request then return end

    pendingCarryRequests[targetId] = nil
    setCarry(request.source, targetId)

    TriggerClientEvent("NSPx_HoldUp:AcceptCarry", request.source, targetId, request.key)
end)

RegisterNetEvent("NSPx_HoldUp:DeclineCarry", function()
    local targetId = source
    local request = pendingCarryRequests[targetId]
    if not request then return end

    pendingCarryRequests[targetId] = nil
    TriggerClientEvent("NSPx_HoldUp:ClearCarryEmote", request.source)
end)

RegisterNetEvent("NSPx_HoldUp:DropCarryEmote", function(targetId)
    local sourceId = source
    if not targetId then return end

    clearCarry(sourceId)
    TriggerClientEvent("NSPx_HoldUp:DropCarryEmote", targetId, sourceId)
    TriggerClientEvent("NSPx_HoldUp:ClearCarryEmote", sourceId)
end)

RegisterNetEvent("NSPx_HoldUp:ClearCarryEmote", function(targetId)
    local sourceId = source
    if not targetId then return end

    clearCarry(sourceId)
    TriggerClientEvent("NSPx_HoldUp:DropCarryEmote", targetId, sourceId)
    TriggerClientEvent("NSPx_HoldUp:ClearCarryEmote", sourceId)
end)

RegisterNetEvent("NSPx_HoldUp:ChkToxic", function(_targetId)
    local sourceId = source
    TriggerClientEvent("NSPx_HoldUp:ChkToxic", sourceId)
end)

RegisterNetEvent("NSPx_HoldUp:Hide", function(_targetId)
    local sourceId = source
    TriggerClientEvent("NSPx_HoldUp:Hide", sourceId)
end)

AddEventHandler("playerDropped", function()
    local sourceId = source

    local carriedTarget = activeCarries[sourceId]
    if carriedTarget then
        TriggerClientEvent("NSPx_HoldUp:DropCorpse", carriedTarget, sourceId)
        TriggerClientEvent("NSPx_HoldUp:ClearCarry", sourceId, carriedTarget)
        clearCarry(sourceId)
    end

    for carrierId, targetId in pairs(activeCarries) do
        if targetId == sourceId then
            TriggerClientEvent("NSPx_HoldUp:ClearCarry", carrierId, sourceId)
            clearCarry(carrierId)
        end
    end

    pendingCarryRequests[sourceId] = nil
    removePendingBySource(sourceId)
end)
