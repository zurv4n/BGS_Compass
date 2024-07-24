-- Define the map types
local mapTypeOnFoot = Config.MapTypeOnFoot
local mapTypeOnMount = Config.MapTypeOnMount
local mapTypeNoCompass = Config.MapTypeNoCompass

local hasMapItem = false

--local inTownCheck = nil

local userGroup

local function contains(table, element)
	if table ~= 0 then
		for k, v in pairs(table) do
			if v == element then
				return true
			end
		end
	end
	return false
end

local function checkInTown()
    print('getting called')
    --local PlayerLoc = GetEntityCoords(PlayerPedId())
    local x,y,z =  table.unpack(GetEntityCoords(PlayerPedId()))
    local inTownCheck = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z,1)
    return inTownCheck
end

RegisterNetEvent('BGS_Compass:mapState')
AddEventHandler('BGS_Compass:mapState', function(flag)
--local function mapState(flag)
    local player = PlayerPedId()
    local playerOnMout = IsPedOnMount(player)
    local playerOnVeh = IsPedInAnyVehicle(player, false)
    --print(flag)

    if flag == 0 then -- both items
        --print('Both Items')
        --do stuff
        if not playerOnMout and not playerOnVeh and not Config.UseUserCompass then
            --print('BF')
            SetMinimapType(mapTypeOnFoot)
            DisplayRadar(true)
        elseif playerOnMout or playerOnVeh and not Config.UseUserCompass then
            --print('BV')
            SetMinimapType(mapTypeOnMount)
            DisplayRadar(true)
        end


    elseif flag == 1 then -- compass only
        -- do stuff
        SetMinimapType(mapTypeOnMount)
        DisplayRadar(true)
        --print('C')
    elseif flag == 2 then -- map only
        --print('map only')
        -- do stuff
        local itc = checkInTown()

        if itc then
            --print('natRet: '..tostring(inTownCheck))
            for k, town in pairs(Config.Towns) do
                --print(town)
                if town == tostring(itc) then
                    --print('we in')
                    if not playerOnMout and not playerOnVeh and not Config.UseUserCompass then
                        SetMinimapType(mapTypeOnFoot)
                        DisplayRadar(true)
                        --print('MFT')
                    elseif playerOnMout or playerOnVeh and not Config.UseUserCompass then
                        --SetMinimapType(mapTypeOnMount)
                        DisplayRadar(false)
                        --print('MVT')
                    end
                    --SetMinimapType(mapTypeOnFoot)
                    --DisplayRadar(true)
                    --inTownCheck = nil
                    break
                end
            end
        else
            --SetMinimapType(mapTypeNoCompass)
            DisplayRadar(false)
        end
    else -- no items
        -- do stuff
        --SetMinimapType(mapTypeNoCompass)
        DisplayRadar(false)
    end
end)

-- Register show minimap event
RegisterNetEvent('BGS_Compass:showMiniMap')
AddEventHandler('BGS_Compass:showMiniMap', function()
    local player = PlayerPedId()
    local playerOnMout = IsPedOnMount(player)
    local playerOnVeh = IsPedInAnyVehicle(player, false)

    --[[ Z add testing
    local PlayerLoc = GetEntityCoords(PlayerPedId())
    inTownCheck = Citizen.InvokeNative(0x43AD8FC02B429D33, PlayerLoc.x, PlayerLoc.y, PlayerLoc.z, 1)
    print(tostring(inTownCheck))
    -- Z end ]]

    -- Check if player is on foot or vehicle
    if not playerOnMout and not playerOnVeh and not Config.UseUserCompass then
        --[[]]
        -- Z add
        if hasMapItem then
            SetMinimapType(mapTypeOnFoot)
            DisplayRadar(true)
        else
            SetMinimapType(mapTypeOnMount)
            DisplayRadar(true)
        end
        -- Z end
        
        --[[ Original
        SetMinimapType(mapTypeOnFoot)
        DisplayRadar(true)
        ]]
    elseif playerOnMout or playerOnVeh and not Config.UseUserCompass then
        SetMinimapType(mapTypeOnMount)
        DisplayRadar(true)
    else
        DisplayRadar(true)
        return
    end
end)

--Register hide minimap event
RegisterNetEvent('BGS_Compass:hideMiniMap')
AddEventHandler('BGS_Compass:hideMiniMap', function()
    local PlayerLoc = GetEntityCoords(PlayerPedId())
    local x,y,z =  table.unpack(GetEntityCoords(PlayerPedId()))
    local inTownCheck = Citizen.InvokeNative(0x43AD8FC02B429D33, PlayerLoc.x, PlayerLoc.y, PlayerLoc.z,1)
    if not hasMapItem and not inTownCheck then
        if not Config.UseUserCompass then
            SetMinimapType(mapTypeNoCompass)
        else
            DisplayRadar(false)
        end
    end
    inTownCheck = nil
end)

-- Z add
-- Create local function so if in town and have map, you get minimap on foot.
-- Town hash table
--[[ natives for checking in town
_GET_MAP_ZONE_AT_COORDS
0x43AD8FC02B429D33
]]
--[[
local function check_inTown()
    local PlayerLoc = GetEntityCoords(PlayerPedId())
    inTownCheck = Citizen.InvokeNative(0x43AD8FC02B429D33, PlayerLoc.x, PlayerLoc.y, PlayerLoc.z)
    for k, town in pairs(Config.Towns) do
        if town == inTownCheck then
            SetMinimapType(mapTypeOnFoot)
            DisplayRadar(true)
            break
        end
    end
    

    if hasMapItem and inTown then
        SetMinimapType(mapTypeOnFoot)
        DisplayRadar(true)
    end

]]

-- Register show map event
RegisterNetEvent('BGS_Compass:enableMap')
AddEventHandler('BGS_Compass:enableMap', function()
    hasMapItem = true
    --[[
    -- check in town on foot and show minimap
    local PlayerLoc = GetEntityCoords(PlayerPedId())
    local x,y,z =  table.unpack(GetEntityCoords(PlayerPedId()))
    local inTownCheck = Citizen.InvokeNative(0x43AD8FC02B429D33, PlayerLoc.x, PlayerLoc.y, PlayerLoc.z,1)
    if inTownCheck then
        --print('natRet: '..tostring(inTownCheck))
        for k, town in pairs(Config.Towns) do
            --print(town)
            if town == tostring(inTownCheck) then
                --print('we in')
                SetMinimapType(mapTypeOnFoot)
                DisplayRadar(true)
                inTownCheck = nil
                break
            end
        end
    end
    ]]
end)

--Register hide map event
RegisterNetEvent('BGS_Compass:disableMap')
AddEventHandler('BGS_Compass:disableMap', function()
    hasMapItem = false
end)

RegisterNetEvent("BGS_Compass:storeUserGroup", function(group)
    userGroup = group
end)

-- Add character selected event handler to check for inventory
RegisterNetEvent("vorp:SelectedCharacter", function()
    local playerPed = PlayerPedId()
    TriggerServerEvent("BGS_Compass:getUserGroup")
    Wait(100)
    -- Create thread loop for checking inventory on player spawn
    if not contains(Config.Exempted, userGroup) then
        if Config.UseMap then
            TriggerEvent("BGS_Compass:disableMap", playerPed)
        end
        CreateThread(function()
            while Config.UseCompass or Config.UseMap do
                Wait(0)
                TriggerServerEvent("BGS_Compass:checkPlayerInventory")
                Citizen.Wait(Config.TimeToCheck) -- Check inventory every X seconds
            end
        end)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if contains(Config.Exempted, userGroup) then
            return
        end
        if Config.UseMap and not contains(Config.Exempted, userGroup) then
            if not hasMapItem then
                ClearGpsPlayerWaypoint()
                ClearGpsMultiRoute()
                if Citizen.InvokeNative(0x4E511D093A86AD49, joaat("map")) then -- search for this native to add animation to look at map
                    Citizen.InvokeNative(0x04428420A248A354, joaat("map"))
                end
            end
        end
        if Config.DisableTabWheelCompass and not contains(Config.Exempted, userGroup) then
            if Citizen.InvokeNative(0x96FD694FE5BE55DC, joaat("hud_quick_select")) == 1322164459 or Citizen.InvokeNative(0x96FD694FE5BE55DC, joaat("hud_quick_select")) == 400623090 then
                DisplayRadar(false)
            end
        end
    end
end)