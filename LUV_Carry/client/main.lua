ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function LoadAnimationDictionary(animationD)
	while (not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

local StatePlayer = {
	BeCarry = false,
	SetDeadAnim = false,
	IsCarry = false,
	CarryTarget = 0,
	TargetCarry = 0,
	LastAnim = nil,
	LastDictAnim = nil,
	IsCarryEmote = false,
}

local Next_hide = 0
local Next_show = 0
local Status_Toxic = 0

PlayerListId = {}
function OpenActionMenuInteraction(target)
	if StatePlayer.IsCarryEmote then
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'action_menu',
			{
				title    = ('Cancel Emote'),
				align    = 'top-right',
				elements = {
					{ label = "Cancel" }
				}
			},
			function(data2, menu2)
				ESX.UI.Menu.CloseAll()

				if StatePlayer.BeCarry then
					FreezeEntityPosition(PlayerPedId(), false)
					Wait(200)
					ClearPedTasks(PlayerPedId())
					DetachEntity(PlayerPedId(), true, false)

					StatePlayer.BeCarry = false
					StatePlayer.IsCarryEmote = false
					TriggerServerEvent("NSPx_HoldUp:ClearCarryEmote", StatePlayer.TargetCarry)
					StatePlayer.TargetCarry = 0
				else
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent("NSPx_HoldUp:DropCarryEmote", StatePlayer.TargetCarry)
					StatePlayer.TargetCarry = 0
					StatePlayer.IsCarryEmote = false
				end
			end, function(data2, menu2)
				menu2.close()
			end
		)
		return
	end
	ESX.UI.Menu.CloseAll()
	El = {}
	El = {
		{ label = 'CarryPeople (Dead)', value = 'drag3' }
	}

	if ESX.PlayerData.job.name == "ambulance" then
		table.insert(El, { label = 'Carry People Alive', value = 'drag_alive_job' })
		table.insert(El, { label = 'Carry People Ambulance', value = 'drag_job' })
	end
	if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "mechanic" or ESX.PlayerData.job.name == "admin" or ESX.PlayerData.job.name == "council" then
		table.insert(El, { label = 'Carry People Alive', value = 'drag_alive_job' })
	end
	table.insert(El, { label = 'Carry Emote', value = 'carry' })
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Player'),
			align    = 'top-right',
			elements = El
		},
		function(data2, menu2)
			ESX.UI.Menu.CloseAll()

			if data2.current.value == 'drag3' then
				if IsPedBeingStunned(PlayerPedId()) then
					return
				end
				if StatePlayer.IsCarry then
					StatePlayer.IsCarry = false
					StopAnimTask(PlayerPedId(), StatePlayer.LastDictAnim, StatePlayer.LastAnim, 3.0)
					TriggerServerEvent("NSPx_HoldUp:DropCorpse", StatePlayer.CarryTarget)
					StatePlayer.CarryTarget = 0

					if Next_hide > GetGameTimer() or Status_Toxic == 4 then
						SendNUIMessage({
							action = "Hide"
						})
						Next_hide = 0
					end
					Status_Toxic = 0
					Next_show = 0
					return
				end

				local player, distance = ESX.Game.GetClosestPlayer()
				local playerarea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 2.0)

				table.sort(playerarea,
					function(a, b)
						return GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),
								GetEntityCoords(GetPlayerPed(a)), true) <
							GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),
								GetEntityCoords(GetPlayerPed(b)), true)
					end)

				if #playerarea > 0 then
					for key, value in pairs(playerarea) do
						if IsPedDeadOrDying(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(tonumber(value)))), true) then
							StatePlayer.IsCarry = true
							LoadAnimationDictionary("missfinale_c2mcs_1")
							TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, 8.0, -1, 49, 0,
								false, false, false)
							StatePlayer.LastAnim = "fin_c2_mcs_1_camman"
							StatePlayer.LastDictAnim = "missfinale_c2mcs_1"

							StatePlayer.CarryTarget = tonumber(GetPlayerServerId(value))
							TriggerServerEvent("NSPx_HoldUp:CarryCorpse", StatePlayer.CarryTarget)
							while not HasAnimDictLoaded("dead@fall") do
								RequestAnimDict("dead@fall")
								Citizen.Wait(100)
							end


							-- TaskPlayAnim(GetPlayerPed(GetPlayerFromServerId(StatePlayer.CarryTarget)), 'missarmenian2' , 'corpse_search_exit_ped', 8.0, 8.0, -1, 1, 1.0, true, true, true )
							ClearPedTasksImmediately(GetPlayerPed(GetPlayerFromServerId(StatePlayer.CarryTarget)))
							break
						end
					end
				end
			elseif data2.current.value == 'drag_alive_job' then
				if StatePlayer.IsCarry then
					StatePlayer.IsCarry = false
					StopAnimTask(PlayerPedId(), StatePlayer.LastDictAnim, StatePlayer.LastAnim, 3.0)
					TriggerServerEvent("NSPx_HoldUp:DropCorpse", StatePlayer.CarryTarget)
					StatePlayer.CarryTarget = 0
					return
				end

				local player, distance = ESX.Game.GetClosestPlayer()
				local playerarea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 2.0)

				table.sort(playerarea,
					function(a, b)
						return GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),
								GetEntityCoords(GetPlayerPed(a)), true) <
							GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),
								GetEntityCoords(GetPlayerPed(b)), true)
					end)

				if #playerarea > 0 then
					for key, value in pairs(playerarea) do
						if IsPedDeadOrDying(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(tonumber(value))))) ~= 1 then
							StatePlayer.IsCarry = true
							LoadAnimationDictionary("missfinale_c2mcs_1")
							TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, 8.0, -1, 49, 0,
								false, false, false)
							StatePlayer.LastAnim = "fin_c2_mcs_1_camman"
							StatePlayer.LastDictAnim = "missfinale_c2mcs_1"

							StatePlayer.CarryTarget = tonumber(GetPlayerServerId(value))
							TriggerServerEvent("NSPx_HoldUp:CarrySync", StatePlayer.CarryTarget)
							break
						end
					end
				end
			elseif data2.current.value == 'drag_job' then
				local player, distance = ESX.Game.GetClosestPlayer()
				playerlist = {}
				Name = nil
				local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
				for i = 1, #players, 1 do
					if players[i] ~= PlayerId() then
						if PlayerListId[GetPlayerServerId(players[i])] then
							table.insert(playerlist,
								{
									label = GetPlayerName(players[i]) .. " - <span style='color:red;'>Carry Down</span>",
									value =
										GetPlayerServerId(players[i]),
									player = players[i]
								})
						else
							if IsPedDeadOrDying(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(players[i])))) == 1 then
								table.insert(playerlist,
									{
										label = GetPlayerName(players[i]) .. " - <span style='color:green;'>Carry</span>",
										value =
											GetPlayerServerId(players[i]),
										player = players[i]
									})
							end
						end
					end
				end
				table.insert(playerlist, { label = "<span style='color:blue;'>Drop All Player</span>", value = "clear" })
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Carry', {
					title    = "Carry Ambulance",
					align    = 'top-right',
					elements = playerlist
				}, function(data2, menu2)
					if data2.current.value ~= "clear" then
						if PlayerListId[data2.current.value] then
							TriggerServerEvent("NSPx_HoldUp:DropCorpse", data2.current.value)
							StopAnimTask(PlayerPedId(), StatePlayer.LastDictAnim, StatePlayer.LastAnim, 3.0)
							PlayerListId[data2.current.value] = nil
						else
							PlayerListId[data2.current.value] = true
							if IsPedDeadOrDying(GetPlayerPed(GetPlayerFromServerId(data2.current.value))) == 1 then
								TriggerServerEvent('NSPx_HoldUp:CarryCorpse', data2.current.value)

								LoadAnimationDictionary("missfinale_c2mcs_1")
								TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, 8.0, -1, 49,
									0, false, false, false)
								StatePlayer.LastAnim = "fin_c2_mcs_1_camman"
								StatePlayer.LastDictAnim = "missfinale_c2mcs_1"
							end
						end
					else
						for key, value in pairs(PlayerListId) do
							StopAnimTask(PlayerPedId(), StatePlayer.LastDictAnim, StatePlayer.LastAnim, 3.0)
							TriggerServerEvent("NSPx_HoldUp:DropCorpse", key)
						end
						PlayerListId = {}
					end
					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data2.current.value == 'carry' then
				if StatePlayer.IsCarry then
					StatePlayer.IsCarry = false
					StopAnimTask(PlayerPedId(), StatePlayer.LastDictAnim, StatePlayer.LastAnim, 3.0)
					TriggerServerEvent("NSPx_HoldUp:DropCorpse", StatePlayer.CarryTarget)
					StatePlayer.CarryTarget = 0
					return
				end

				CarryEmote()
			end
		end, function(data2, menu2)
			menu2.close()
		end
	)
end

function CarryEmote()
	local el = {}
	for key, value in pairs(Cfg.Animation) do
		table.insert(el, { label = value.Name, value = key })
	end
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'Carry_menu',
		{
			title    = ('Carry'),
			align    = 'top-right',
			elements = el
		},
		function(data2, menu2)
			if data2.current.value then
				ESX.UI.Menu.CloseAll()
				local player, distance = ESX.Game.GetClosestPlayer()
				local playerarea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 2.0)

				table.sort(playerarea,
					function(a, b)
						return GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),
								GetEntityCoords(GetPlayerPed(a)), true) <
							GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),
								GetEntityCoords(GetPlayerPed(b)), true)
					end)

				if #playerarea > 0 then
					for key, value in pairs(playerarea) do
						if IsPedDeadOrDying(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(tonumber(value))))) ~= 1 then
							StatePlayer.CarryEmoteKey = data2.current.value
							TriggerServerEvent("NSPx_HoldUp:RequestCarry", tonumber(GetPlayerServerId(value)),
								data2.current.value)
							break
						end
					end
				end
			end
		end, function(data2, menu2)
			menu2.close()
		end
	)
end

RegisterNetEvent("NSPx_HoldUp:RequestCarry")
AddEventHandler("NSPx_HoldUp:RequestCarry", function(TargetCarry, key)
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'RequestCarry',
		{
			title    = TargetCarry .. " Request " .. Cfg.Animation[key].Name,
			align    = 'top-right',
			elements = {
				{ label = "Accept",  value = "Accept" },
				{ label = "Decline", value = "Decline" }
			}
		},
		function(data2, menu2)
			ESX.UI.Menu.CloseAll()
			if data2.current.value == "Accept" then
				local targetPed = GetPlayerPed(GetPlayerFromServerId(TargetCarry))

				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(targetPed), true) < 3.0 then
					TriggerServerEvent("NSPx_HoldUp:AcceptCarry")
					local Cfgkey = Cfg.Animation[key]
					StatePlayer.IsCarryEmote = true
					StatePlayer.TargetCarry = TargetCarry
					StatePlayer.BeCarry = true

					local playerPed = PlayerPedId()

					FreezeEntityPosition(playerPed, true)
					ClearPedTasksImmediately(playerPed)
					Citizen.Wait(150)
					local attach = Cfgkey.Target.AttachEntity
					AttachEntityToEntity(playerPed, targetPed, attach.Bone, attach.xPos, attach.yPos, attach.zPos,
						attach.xRot, attach.yRot, attach.zRot, attach.P9, attach.UseSoftPinning, attach.Collision,
						attach.IsPed, attach.VertexIndex, attach.FixedRot)
					local anim = Cfgkey.Target.TaskAnim
					while not HasAnimDictLoaded(anim.Dict) do
						RequestAnimDict(anim.Dict)
						Citizen.Wait(100)
					end
					TaskPlayAnim(playerPed, anim.Dict, anim.Anim, anim.BlendInSpeed, anim.BlendOutSpeed, anim.Duration,
						anim.Flag, anim.PlaybackRate, anim.X, anim.Y, anim.Z)
					TriggerEvent("NSPx_HoldUp:Carry")
				else
					TriggerServerEvent("NSPx_HoldUp:DeclineCarry")
				end
			end
			if data2.current.value == "Decline" then
				TriggerServerEvent("NSPx_HoldUp:DeclineCarry")
			end
		end, function(data2, menu2)
			TriggerServerEvent("NSPx_HoldUp:DeclineCarry")
			menu2.close()
		end
	)
end)

RegisterNetEvent("NSPx_HoldUp:AcceptCarry")
AddEventHandler("NSPx_HoldUp:AcceptCarry", function(TargetCarry, key)
	local Cfgkey = Cfg.Animation[key]

	StatePlayer.IsCarryEmote = true
	StatePlayer.TargetCarry = TargetCarry

	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(StatePlayer.TargetCarry))
	ClearPedTasks(PlayerPedId())
	Citizen.Wait(150)
	local anim = Cfgkey.Source.TaskAnim
	while not HasAnimDictLoaded(anim.Dict) do
		RequestAnimDict(anim.Dict)
		Citizen.Wait(100)
	end
	TaskPlayAnim(playerPed, anim.Dict, anim.Anim, anim.BlendInSpeed, anim.BlendOutSpeed, anim.Duration, anim.Flag,
		anim.PlaybackRate, anim.X, anim.Y, anim.Z)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 56) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu')
			and IsPedOnFoot(PlayerPedId()) then
			OpenActionMenuInteraction()
		end
	end
end)

RegisterNetEvent("NSPx_HoldUp:ClearCarry")
AddEventHandler("NSPx_HoldUp:ClearCarry", function(TargetCarry)
	StatePlayer.IsCarry = false
	StopAnimTask(PlayerPedId(), StatePlayer.LastDictAnim, StatePlayer.LastAnim, 3.0)
	StatePlayer.CarryTarget = 0

	if Next_hide > GetGameTimer() or Status_Toxic == 4 then
		SendNUIMessage({
			action = "Hide"
		})
		Next_hide = 0
	end
	Status_Toxic = 0
	Next_show = 0
end)

RegisterNetEvent("NSPx_HoldUp:CarryCorpse")
AddEventHandler("NSPx_HoldUp:CarryCorpse", function(TargetCarry)
	if StatePlayer.TargetCarry and StatePlayer.TargetCarry > 0 then
		local oldtargetPed = GetPlayerPed(GetPlayerFromServerId(StatePlayer.TargetCarry))
		if oldtargetPed and IsPedInAnyVehicle(oldtargetPed, false) then
			TriggerServerEvent("NSPx_HoldUp:ClearCarry", TargetCarry)
			return
		end
	end

	if StatePlayer.TargetCarry ~= 0 and StatePlayer.TargetCarry ~= TargetCarry then
		TriggerServerEvent("NSPx_HoldUp:ClearCarry", StatePlayer.TargetCarry)
	end
	StatePlayer.TargetCarry = TargetCarry
	StatePlayer.BeCarry = true
	local targetPed = GetPlayerPed(GetPlayerFromServerId(StatePlayer.TargetCarry))
	-- if IsEntityDead(playerPed) then
	-- IsDead = true
	FreezeEntityPosition(PlayerPedId(), true)
	ClearPedTasksImmediately(PlayerPedId())
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, 0.20, 0.15, 0.63, 0.9, 0.6, 0.0, false, false, false, true, 2, true)
	TriggerServerEvent("NSPx_HoldUp:ChkToxic", TargetCarry)
	-- CreateThread(function()
	-- 	while StatePlayer.BeCarry and targetPed do
	-- 		Wait(500)
	-- 		AttachEntityToEntity(PlayerPedId(), targetPed, 0, 0.20, 0.15, 0.63, 0.9, 0.6, 0.0, false, false, false, true,
	-- 			2, true)
	-- 	end
	-- end)
	-- ClearPedTasksImmediately(PlayerPedId())
	-- end
end)

RegisterNetEvent("NSPx_HoldUp:CarrySync")
AddEventHandler("NSPx_HoldUp:CarrySync", function(TargetCarry)
	if StatePlayer.TargetCarry and StatePlayer.TargetCarry > 0 then
		local oldtargetPed = GetPlayerPed(GetPlayerFromServerId(StatePlayer.TargetCarry))
		if oldtargetPed and IsPedInAnyVehicle(oldtargetPed, false) then
			TriggerServerEvent("NSPx_HoldUp:ClearCarry", TargetCarry)
			return
		end
	end

	if StatePlayer.TargetCarry ~= 0 and StatePlayer.TargetCarry ~= TargetCarry then
		TriggerServerEvent("NSPx_HoldUp:ClearCarry", StatePlayer.TargetCarry)
	end
	StatePlayer.TargetCarry = TargetCarry
	StatePlayer.BeCarry = true
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(StatePlayer.TargetCarry))
	local coords = GetEntityCoords(playerPed)
	local lPed = GetPlayerPed(-1)
	-- if IsEntityDead(playerPed) then
	-- IsDead = true
	while not HasAnimDictLoaded("nm") do
		RequestAnimDict("nm")
		Citizen.Wait(100)
	end

	FreezeEntityPosition(lPed, true)
	ClearPedTasksImmediately(lPed)
	Citizen.Wait(150)
	AttachEntityToEntity(playerPed, targetPed, 0, 0.20, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, true)
	FreezeEntityPosition(playerPed, true)

	TaskPlayAnim(playerPed, "nm", "firemans_carry", 8.0, -8, -1, 33, 0, 0, 40, 0)


	-- end
end)

RegisterNetEvent("NSPx_HoldUp:DropCorpse")
AddEventHandler("NSPx_HoldUp:DropCorpse", function(TargetCarry)
	local playerPed = PlayerPedId()
	DetachEntity(playerPed, true, false)
	FreezeEntityPosition(playerPed, false)
	StatePlayer.BeCarry = false
	StatePlayer.TargetCarry = 0
	Wait(100)
	SetEntityCoords(playerPed, GetEntityCoords(playerPed) + vector3(0, 0, 0.50))
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("NSPx_HoldUp:DropCarryEmote")
AddEventHandler("NSPx_HoldUp:DropCarryEmote", function(TargetCarry)
	local playerPed = PlayerPedId()
	FreezeEntityPosition(playerPed, false)
	Wait(200)
	ClearPedTasks(playerPed)
	DetachEntity(playerPed, true, false)

	StatePlayer.BeCarry = false
	StatePlayer.IsCarryEmote = false
	StatePlayer.TargetCarry = 0
end)

RegisterNetEvent("NSPx_HoldUp:ClearCarryEmote")
AddEventHandler("NSPx_HoldUp:ClearCarryEmote", function()
	StatePlayer.IsCarryEmote = false
	ClearPedTasks(PlayerPedId())
	StatePlayer.CarryTarget = 0
end)

AddEventHandler('playerSpawned', function()
	if StatePlayer.BeCarry then
		TriggerServerEvent("NSPx_HoldUp:ClearCarry", StatePlayer.TargetCarry)
		StatePlayer.BeCarry = false
		if StatePlayer.IsCarryEmote then
			FreezeEntityPosition(PlayerPedId(), false)
			Wait(200)
			ClearPedTasks(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent("NSPx_HoldUp:ClearCarryEmote", StatePlayer.TargetCarry)
			StatePlayer.IsCarryEmote = false
			StatePlayer.BeCarry = false
		end
		StatePlayer.TargetCarry = 0
		StatePlayer.IsCarryEmote = false
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	Wait(200)
	if StatePlayer.IsCarry and not StatePlayer.BeCarry then
		TriggerServerEvent("NSPx_HoldUp:DropCorpse", StatePlayer.CarryTarget)
		StatePlayer.IsCarry = false
		StatePlayer.CarryTarget = 0

		if Next_hide > GetGameTimer() or Status_Toxic == 4 then
			SendNUIMessage({
				action = "Hide"
			})
			Next_hide = 0
		end
		Status_Toxic = 0
		Next_show = 0
	end
	if StatePlayer.IsCarryEmote then
		if StatePlayer.BeCarry then
			FreezeEntityPosition(PlayerPedId(), false)
			Wait(200)
			ClearPedTasks(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent("NSPx_HoldUp:ClearCarryEmote", StatePlayer.TargetCarry)
			StatePlayer.IsCarryEmote = false
			StatePlayer.BeCarry = false
		else
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent("NSPx_HoldUp:DropCarryEmote", StatePlayer.TargetCarry)
			StatePlayer.IsCarryEmote = false
		end
		StatePlayer.TargetCarry = 0
	end
	Wait(500)
	ClearPedLastDamageBone(PlayerPedId())
	ClearEntityLastDamageEntity(PlayerPedId())
	ClearPedTasks(PlayerPedId())
	ClearPedSecondaryTask(PlayerPedId())
	-- TaskPlayAnim(PlayerPedId(), 'missarmenian2' , 'corpse_search_exit_ped', 8.0, 8.0, -1, 1, 1.0, true, true, true )
end)

CreateThread(function()
	while true do
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle > 0 and DoesEntityExist(vehicle) then
			if StatePlayer.IsCarryEmote then
				ClearPedTasks(PlayerPedId())
				TriggerServerEvent("NSPx_HoldUp:DropCarryEmote", StatePlayer.TargetCarry)
				StatePlayer.IsCarryEmote = false
			end
		end
		Wait(1000)
	end
end)

exports('DropPlayer', function()
	if StatePlayer.IsCarryEmote then
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("NSPx_HoldUp:DropCarryEmote", StatePlayer.TargetCarry)
		StatePlayer.IsCarryEmote = false
	end
	if StatePlayer.IsCarry then
		TriggerServerEvent("NSPx_HoldUp:DropCorpse", StatePlayer.CarryTarget)
		StatePlayer.IsCarry = false
		StatePlayer.CarryTarget = 0

		if Next_hide > GetGameTimer() or Status_Toxic == 4 then
			SendNUIMessage({
				action = "Hide"
			})
			Next_hide = 0
		end
		Status_Toxic = 0
		Next_show = 0
	end
end)

RegisterNetEvent("NSPx_HoldUp:ChkToxic")
AddEventHandler("NSPx_HoldUp:ChkToxic", function(id_player)
	local toxic_level = Player(StatePlayer.CarryTarget).state.toxic or 0
	Status_Toxic = toxic_level
	if toxic_level > 0 and toxic_level <= 3 then
		Next_hide = TimePhase(toxic_level)
		Next_show = 0
		SendNUIMessage({
			action = "Show",
			Phase = toxic_level
		})
	end

	if toxic_level == 4 then
		SendNUIMessage({
			action = "Show",
			Phase = toxic_level
		})
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if StatePlayer.IsCarry then
			if (Next_hide and Next_hide < GetGameTimer()) and Next_show == 0 and Status_Toxic <= 3 then
				local toxic_level = Player(StatePlayer.CarryTarget).state.toxic
				Status_Toxic = toxic_level
				SendNUIMessage({
					action = "Hide"
				})
				Next_hide = 0
				Next_show = TimePhase(toxic_level)
			end

			if Next_show and Next_show < GetGameTimer() and Next_hide == 0 and Status_Toxic <= 3 then
				local toxic_level = Player(StatePlayer.CarryTarget).state.toxic
				Status_Toxic = toxic_level
				Next_hide = TimePhase(toxic_level)
				Next_show = 0
				SendNUIMessage({
					action = "Show",
					Phase = toxic_level
				})
			end

			if Status_Toxic == 4 then
				local playerped = PlayerPedId()
				SetEntityHealth(playerped, GetEntityHealth(playerped) - 2)
			end
		end
	end
end)

exports("Refresh_Toxic", function()
	if StatePlayer.BeCarry then
		TriggerServerEvent("NSPx_HoldUp:ChkToxic", StatePlayer.TargetCarry)
	end
end)

RegisterNetEvent("NSPx_HoldUp:Hide")
AddEventHandler("NSPx_HoldUp:Hide", function()
	if Next_hide > GetGameTimer() or Status_Toxic == 4 then
		SendNUIMessage({
			action = "Hide"
		})
		Next_hide = 0
	end
	Status_Toxic = 0
	Next_show = 0
end)

exports("Hide_Toxic", function()
	if StatePlayer.BeCarry and Status_Toxic then
		TriggerServerEvent("NSPx_HoldUp:Hide", StatePlayer.TargetCarry)
	end
end)

function TimePhase(num)
	if num == 1 then
		return GetGameTimer() + 15 * 1000
	end
	if num == 2 then
		return GetGameTimer() + 10 * 1000
	end
	if num == 3 then
		return GetGameTimer() + 5 * 1000
	end
	if num == 4 then
		return 0
	end
end
