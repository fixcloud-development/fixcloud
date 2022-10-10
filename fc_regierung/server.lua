ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local data = {}
local items = {'fixkit', 'fixkit', 'fixkit', 'fixkit', 'fixkit', 'fixkit', 'fixkit', 'fixkit'}

item1 = (items[math.random(#items)])
item2 = (items[math.random(#items)])
item3 = (items[math.random(#items)])

RegisterServerEvent('holEquipment')
AddEventHandler('holEquipment', function()
    if data[GetPlayerIdentifier(source, 1)] == nil then
        data[GetPlayerIdentifier(source, 1)] = 1
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem(item1, 1)  
        xPlayer.addInventoryItem(item2, 1)
        xPlayer.addInventoryItem(item3, 1)
        xPlayer.addMoney(3000)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du hast deine Tägliche Belohnung abgeholt.', length = 8000, style = { ['background-color'] = '#ff0000', ['color'] = '#ffffff' } })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du kannst erst nach der nächsten Sonnenwende deine Belohnung abholen.', length = 8000, style = { ['background-color'] = '#ff0000', ['color'] = '#ffffff' } })
    end
end)

RegisterNetEvent("ali_dailyreward:deny")
AddEventHandler("ali_dailyreward:deny", function(data)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du hast deine Tägliche Belohnung abgelehnt.', length = 8000, style = { ['background-color'] = '#ff0000', ['color'] = '#ffffff' } })
end)