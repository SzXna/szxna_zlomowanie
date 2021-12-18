local Keys = {
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

ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


local blips = {
     {title="Złomowisko", colour=11, id=527},
}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)
 
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		for i, v in pairs(config.coords) do
		info.blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
		end
    end
end)

Citizen.CreateThread(function()
	for i, v in pairs(config.coords) do
		while true do
			Wait(0)
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local vehicle = GetVehiclePedIsIn(ped)
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 102, 102, 204, 100, false, true, 2, false, false, false, false)
					if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 3 then
						if IsPedInAnyVehicle(ped, false) then
							ESX.ShowHelpNotification('Nacisnij ~INPUT_CONTEXT~ aby ~y~zezłomować pojazd')
							if IsControlJustReleased(0, Keys['E']) then
								ESX.ShowNotification("Pojazd został ~y~zezłomowany")
								TriggerServerEvent('szxna_zlomowanie:svo', vehicleProps)
								ESX.Game.DeleteVehicle(vehicle)
							end
						else
							ESX.ShowHelpNotification('Musisz być w pojeździe, aby go ~y~zezłomować')
						end
					end
		end
	end
end)
