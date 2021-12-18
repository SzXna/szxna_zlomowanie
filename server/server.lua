esx = nil

TriggerEvent('esx:getSharedObject', function(obj) esx = obj end)

RegisterServerEvent('szxna_zlomowanie:svo')
AddEventHandler('szxna_zlomowanie:svo', function (vehicleProps)
    local _source = source
    local xPlayer = esx.GetPlayerFromId(_source)
    local identifiers = GetPlayerIdentifier(source, 0)
	MySQL.Sync.execute("DELETE FROM `owned_vehicles` WHERE plate=@plate", {['@plate'] = vehicleProps.plate})
	sendtodiscord("Zezłomowanie pojazdu", "tablice: `" .. vehicleProps.plate .. "`\nhex złomiarza: `" .. identifiers .. "`")
end)

function sendtodiscord(status, message)
	local date = os.date('*t')
	local wh = config.discordwebhook
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
	local embed = {
		{
			["title"]= (status),
			['description'] = (message),
			["color"] = 38400,
				['image'] = {
					['url'] = "",
				},
				['author'] = {
					['name'] = "",
				},
				['footer'] = {
					['text'] = ("" .. date ..""),
				}
		}
	}
		PerformHttpRequest(config.discordwebhook, function(err, headers) end, 'POST', json.encode({ embeds = embed, content = ''}), { ['Content-Type'] = 'application/json' })
end