Keys 					  = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX			    		= nil
local AllowNeedHelp		= true
local ScriptProp		= {}
local AlertData			= {}
local ScriptEntity		= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config["Router"], function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    ESX.PlayerData = ESX.GetPlayerData()
    ScriptWork()
end)

function ScriptWork()

	print("^7 [^4Scripts^7][^2"..string.upper(GetCurrentResourceName()).."^7][^4Loaded Success^7]")

	AddEventHandler('onResourceStop', function(resource)
		if resource == GetCurrentResourceName() then
			for k,v in pairs(ScriptEntity) do DeleteEntity(v) end
		end
	end)

	function LoadAnimDict(dict)
		while (not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Citizen.Wait(0)
		end
	end

	-- RegisterCommand("al",function(source, args)
	-- 	if args[1] then
	-- 		exports['nakin_medicreport']:SendAlert({
	-- 			text = "โดนห่อศพ "..args[1].."",
	-- 			color = "rgb(255, 0, 54, 0.5)",
	-- 			type = "bodybag"
	-- 		})
	-- 	end
	-- end)

	-- RegisterCommand("al3",function(source, args)
	-- 	exports['nakin_medicreport']:SendAlert({
	-- 		text = "25:34",
	-- 	})
	-- end)

	-- RegisterCommand("al2",function(source, args)
	-- 	exports['nakin_medicreport']:SendAlert()
	-- end)

	RegisterCommand("medicpreview", function(source, args)
		SendAlert({
			type = "normal"
		})
	end, false)

	RegisterCommand("medicsuccess", function(source, args)
		if not ESX.GetPlayerData().job or ESX.GetPlayerData().job.name ~= "ambulance" then
			return
		end

		local caseId = tonumber(args and args[1])
		if not caseId then
			exports['nakin_allnotify']:AddNotify({type = "error", text = "ใช้คำสั่ง: medicsuccess [idcase]"})
			return
		end

		TriggerServerEvent(scriptName..':UpdateCase', caseId, "done")
		exports['nakin_allnotify']:AddNotify({type = "success", text = "อัปเดตเคสเป็นปลอดภัยแล้ว"})
	end, false)

	RegisterNetEvent(scriptName..':RefreshBlackList')
	AddEventHandler(scriptName..':RefreshBlackList', function(data)
		if ESX.GetPlayerData().job.name == "ambulance" then
			BlackList = data
			SendNUIMessage({ type = 'RefreshBlackList', data = BlackList})
		end
	end)

	RegisterNetEvent(scriptName..':SetCanNeedHelp')
	AddEventHandler(scriptName..':SetCanNeedHelp', function(status)
		AllowNeedHelp = status
	end)

	function SendAlert(data)
		if AllowNeedHelp then
			-- if IsPedDeadOrDying(GetPlayerPed(-1)) then
				NeedHelp = true
				TriggerServerEvent(scriptName..':AddAlert', data)
			-- end
		else
			exports['nakin_allnotify']:AddNotify({type = "error", text = "ไม่สามารถขอความช่วยเหลือได้"})
		end
	end

	AddEventHandler('playerSpawned', function()
		if NeedHelp then
			NeedHelp = nil
			if acase then
				TriggerServerEvent(scriptName..':UpdateCase', acase, "done")
			end
			acase = nil
		end
	end)

	local DeathReported = false
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(800)
			if ESX and ESX.GetPlayerData() and ESX.GetPlayerData().job and ESX.GetPlayerData().job.name == "ambulance" then
				local ped = PlayerPedId()
				if IsEntityDead(ped) then
					if not DeathReported then
						DeathReported = true
						TriggerServerEvent(scriptName..':ReleaseAcceptedCases')
					end
				else
					DeathReported = false
				end
			else
				DeathReported = false
				Citizen.Wait(1000)
			end
		end
	end)

	function SetNewTable()
		local newtable = {}
		for i = 1, 3000 do
			if AlertData[i] then
				table.insert(newtable, AlertData[i])
			end
		end
		AlertData = newtable
	end

	function removeBrTags(inputString)
		return inputString:gsub("<br>", "")
	end

	RegisterNetEvent(scriptName..':AddMedicCase')
	AddEventHandler(scriptName..':AddMedicCase', function(newdata,newcase)
		if ESX.GetPlayerData().job.name == "ambulance" then
			if newcase then
				-- SendNUIMessage({type = 'AlertUI', text = removeBrTags(newcase)})
				local previewText = "คนสลบกดเรียกเคส"
				if newdata and newdata.name and newdata.phone then
					previewText = ("คนสลบกดเรียกเคส: %s (%s)"):format(newdata.name, newdata.phone)
				end
				TriggerEvent("nakin_allnotify:AddAlert",{
					job = "ambulance",
					text = previewText,
					waypoint = true,
					time = 5,
					coords = newdata.coords,
					case = newdata.caseid
				})
			end
			newdata.time = newdata.servertime
			newdata.remain = tonumber(newdata.remain) or Config["DefaultCaseRemainSeconds"] or 2700
			newdata.remaintext = string.format("%02d:%02d", math.floor(newdata.remain / 60), newdata.remain % 60)
			table.insert(AlertData, newdata)
			RefreshTabletUI()
		end
	end)

	RegisterNetEvent(scriptName..':UpdateCase')
	AddEventHandler(scriptName..':UpdateCase', function(caseid,status,text,ac)
		if ESX.GetPlayerData().job.name == "ambulance" then
			if status == -1 then
				AlertData = {}
			else
				for k,v in pairs(AlertData) do
					if v.caseid == caseid then
						if status == 0 then
							AlertData[k] = nil
						else
							AlertData[k].text = text
							AlertData[k].status = status
							if status == 2 and ac ~= nil then
								AlertData[k].ac = ac
							end
						end
					end
				end
			end
			RefreshTabletUI()
		end
	end)

	function RefreshTabletUI()
		SetNewTable()
		-- print(ESX.DumpTable(AlertData))
		SendNUIMessage({type = 'RefreshCase', data = AlertData})
	end

	function UpdateCaseTimeUI()
		local timePayload = {}
		for _, v in pairs(AlertData) do
			table.insert(timePayload, {
				caseid = v.caseid,
				casetime = v.casetime,
				remaintext = v.remaintext
			})
		end

		SendNUIMessage({type = 'UpdateCaseTime', data = timePayload})
	end

	function ConvertSecondsToMinutes(seconds)
		local minutes = math.floor(seconds / 60) -- คำนวณนาที
		local remaining_seconds = seconds % 60 -- คำนวณวินาทีที่เหลือ
		return string.format("%d:%02d นาที", minutes, remaining_seconds) -- จัดรูปแบบข้อความ
	end

	function ConvertSecondsToClock(seconds)
		seconds = tonumber(seconds) or 0
		if seconds < 0 then
			seconds = 0
		end
		local minutes = math.floor(seconds / 60)
		local remaining_seconds = seconds % 60
		return string.format("%02d:%02d", minutes, remaining_seconds)
	end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			for k, v in pairs(AlertData) do
				v.time = v.time + 1
				v.casetime = ConvertSecondsToMinutes(v.time - v.servertime)
				v.remain = tonumber(v.remain) or Config["DefaultCaseRemainSeconds"] or 2700
				if v.remain > 0 and v.status ~= 3 then
					v.remain = v.remain - 1
				end
				v.remaintext = ConvertSecondsToClock(v.remain)
			end
			if ToggleUI then
				UpdateCaseTimeUI()
			end
		end
	end)

	function SetTablet(status)
		local Ped = PlayerPedId()
		if status then
			local anime = {
				dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a",
				anime = "idle_a",
				prop = "prop_cs_tablet",
				bone = 28422,
				PropPlacementPos = vector3(-0.05, 0.0, 0.0),
				PropPlacementRot = vector3(0.0, 0.0, 0.0),
			}
			LoadAnimDict(anime.dict)
			TaskPlayAnim(Ped, anime.dict ,anime.anime ,8.0, -8.0, -1, 49, 0, false, false, false )
			if not tablet then
				tablet = CreateObject(GetHashKey(anime.prop), GetEntityCoords(Ped), true, false, false)
				AttachEntityToEntity(tablet,  Ped,  GetPedBoneIndex(Ped, anime.bone), anime.PropPlacementPos,anime.PropPlacementRot,  false, false, false, false, 2, true)
				table.insert(ScriptEntity, tablet)
			end
			ESX.Streaming.RequestAnimDict(anime.dict, function()
				TaskPlayAnim(Ped, anime.dict, anime.anime, 8.0, -8, -1, 49, 0.0, false, false, false)
			end)
		else
			if tablet then
				ClearPedTasks(Ped)
				for k,v in pairs(ScriptEntity) do DeleteEntity(v) end
				tablet = nil
			end
		end
	end

	RegisterKeyMapping('ToggleTablet', 'Open Tablet', 'keyboard', "F4")

    RegisterCommand('ToggleTablet', function()
		if ESX.GetPlayerData().job.name == "ambulance" then
        	ToggleTablet(true)
		end
    end)

	RegisterNetEvent(scriptName..':UpdateId')
	AddEventHandler(scriptName..':UpdateId', function(id)
		if NeedHelp then
			acase = id
		end
	end)


	local function findCaseByCaseId(caseId)
		caseId = tonumber(caseId)
		if not caseId then
			return nil, nil
		end

		for index, caseData in pairs(AlertData) do
			if tonumber(caseData.caseid) == caseId then
				return index, caseData
			end
		end

		return nil, nil
	end

	function ToggleTablet(status)
		ToggleUI = status
		SetNuiFocus(ToggleUI, ToggleUI)
		SendNUIMessage({ type = 'Toggle', status = ToggleUI})
		SetTablet(ToggleUI)
		if not BlackList then
			TriggerServerEvent(scriptName..':LoadBlackList')
		end
	end

	RegisterNUICallback('exit', function()
		ToggleTablet(false)
	end)

	RegisterNUICallback('print', function(data)
		print(ESX.DumpTable(data.data))
	end)

	RegisterNUICallback('getcase', function(data, cb)
		if Waiting then
			if cb then cb('busy') end
			return
		end

		Waiting = true
		local _, caseData = findCaseByCaseId(data and data.caseid)
		if caseData then
			TriggerServerEvent(scriptName..':UpdateCase', caseData.caseid, "getcase")
			if cb then cb('ok') end
		else
			if cb then cb('not_found') end
		end

		Citizen.SetTimeout(1000, function()
			Waiting = false
		end)
	end)

	RegisterNUICallback('markGPS', function(data, cb)
		local _, caseData = findCaseByCaseId(data and data.caseid)
		if caseData then
			SetNewWaypoint(caseData.coords.x, caseData.coords.y)
			exports['nakin_allnotify']:AddNotify({type = "success", text = "ปักหมุดเป้าหมายแล้ว"})
			if cb then cb('ok') end
			return
		end

		if cb then cb('not_found') end
	end)

	RegisterNetEvent(scriptName..':markGPS')
	AddEventHandler(scriptName..':markGPS', function(caseid)
		local _, caseData = findCaseByCaseId(caseid)
		if caseData then
			SetNewWaypoint(caseData.coords.x, caseData.coords.y)
		end
	end)

	RegisterNUICallback('DeleteCase', function(data, cb)
		if Waiting then
			if cb then cb('busy') end
			return
		end

		Waiting = true
		local _, caseData = findCaseByCaseId(data and data.caseid)
		if caseData and tonumber(caseData.status) == 3 then
			TriggerServerEvent(scriptName..':UpdateCase', caseData.caseid, "deletecase")
			if cb then cb('ok') end
		elseif caseData then
			exports['nakin_allnotify']:AddNotify({type = "error", text = "ลบได้เฉพาะเคสที่ปลอดภัยแล้ว"})
			if cb then cb('invalid_status') end
		else
			if cb then cb('not_found') end
		end

		Citizen.SetTimeout(1000, function()
			Waiting = false
		end)
	end)

	RegisterNUICallback('RemoveAll', function(data)
		if not Waiting then
			Waiting = true
			TriggerServerEvent(scriptName..':UpdateCase',-1, "deleteall")
			Citizen.Wait(1000)
			Waiting = false
		end
	end)

	RegisterNUICallback('addblacklistnumber', function(data)
		if not Waiting then
			Waiting = true
			if data.number then
				TriggerServerEvent(scriptName..':AddBlackListNumber', tonumber(data.number), data.status)
				if data.status then
					exports['nakin_allnotify']:AddNotify({type = "success", text = "เพิ่ม "..data.number.." ในรายการ BlackList แล้ว"})
				end
			end
			Citizen.Wait(1000)
			Waiting = false
		end
	end)

end

