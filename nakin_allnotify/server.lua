ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.BASE, function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

local function sendNotify(target, data)
    if type(data) ~= 'table' then
        return
    end

    TriggerClientEvent('nakin_allnotify:AddNotify', target or -1, {
        type = data.type,
        text = data.text,
        time = data.time,
    })
end

RegisterNetEvent('nakin_allnotify:AddNotify')
AddEventHandler('nakin_allnotify:AddNotify', function(data)
    sendNotify(source, data)
end)

RegisterNetEvent('nakin_allnotify:SendAlert')
AddEventHandler('nakin_allnotify:SendAlert', function(data)
    if type(data) ~= 'table' then
        return
    end

    if not data.coords then
        return
    end

    TriggerClientEvent(scriptName..':AddAlert', -1, data)
end)

RegisterNetEvent('nakin_allnotify:CreateAlertZone')
AddEventHandler('nakin_allnotify:CreateAlertZone', function(coords)
    if not coords then
        return
    end

    TriggerClientEvent('nakin_allnotify:CreateAlertZone', -1, coords)
end)

exports('AddNotify', function(target, data)
    sendNotify(target, data)
end)

exports('SendAlert', function(data)
    TriggerClientEvent(scriptName..':AddAlert', -1, data)
end)
