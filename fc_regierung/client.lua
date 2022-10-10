ESX = nil

local NPCPosition = {x = -544.92, y = -204.46, z = 38.22, rot = 227.02}

local isNearPed = false
local isAtPed = false
local isPedLoaded = false
local pedModel = GetHashKey("cs_andreas")
local npc

Citizen.CreateThread(function()

    while true do

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local distance = Vdist(playerCoords, NPCPosition.x, NPCPosition.y, NPCPosition.z)
        isNearPed = false
        isAtPed = false

        if distance < 20.0 then
            isNearPed = true
            if not isPedLoaded then
                RequestModel(pedModel)
                while not HasModelLoaded(pedModel) do
                    Wait(10)
                end

                npc = CreatePed(4, pedModel, NPCPosition.x, NPCPosition.y, NPCPosition.z - 1.0, NPCPosition.rot, false, false)
                FreezeEntityPosition(npc, true)
                SetEntityHeading(npc, NPCPosition.rot)
                SetEntityInvincible(npc, true)
                SetBlockingOfNonTemporaryEvents(npc, true)

                isPedLoaded = true
            end
        end

        if isPedLoaded and not isNearPed then
            DeleteEntity(npc)
            SetModelAsNoLongerNeeded(pedModel)
            isPedLoaded = false
        end

        if distance < 2.0 then
            isAtPed = true
        end
        Citizen.Wait(500)
    end

end)


Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function (obj) ESX = obj end)
    end
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords  = GetEntityCoords(GetPlayerPed(-1))
		if(GetDistanceBetweenCoords(coords, -544.92, -204.46, 38.22, 227.02, true) < 2) then
			isInMarker2  = true
		else
			isInMarker2 = false
		end
		if isInMarker2 then                    
            ESX.ShowHelpNotification("Drücke E um deine Personalien Anzumelden.")
            if IsControlPressed(0, 38) then
				TriggerEvent('ali_dailyreward:show')
				Wait(1000)
            end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		DrawMarker(1, -429.04, 1110.75, 326.6907, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 255, 140, 0, 255, false, true, 2, false, false, false, false)
	end
end)

-----------------------------------------------------------------------------------------------------------------

RegisterNetEvent('ali_dailyreward:show')
AddEventHandler('ali_dailyreward:show', function(title)
    SendNUIMessage({
        title = title,
    })

    SetNuiFocus(true, true)
end)

RegisterNUICallback('exit', function(data)
   SetNuiFocus(false, false)
   TriggerServerEvent("ali_dailyreward:deny")
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)


RegisterNUICallback('join', function(data, cb)
   TriggerServerEvent('holEquipment')
   SetNuiFocus(false, false)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)








