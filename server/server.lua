local VORPcore = {} -- core object

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

-- Register server event to check player inventory
RegisterServerEvent("BGS_Compass:checkPlayerInventory") 
AddEventHandler("BGS_Compass:checkPlayerInventory", function()
    local _source = source
    -- Error check for player inventory
    if not VORPcore.getUser(_source) then
        return
    end
    --[[
    local compassCount = exports.vorp_inventory:getItemCount(_source, nil, Config.CompassItemToCheck)
    if compassCount > 0 and Config.UseCompass then
        TriggerClientEvent("BGS_Compass:showMiniMap", _source)
    elseif compassCount == 0 and Config.UseCompass then
        TriggerClientEvent("BGS_Compass:hideMiniMap", _source)
    end

    local mapCount = exports.vorp_inventory:getItemCount(_source, nil, Config.MapItemToCheck)
    if mapCount > 0 and Config.UseMap then
        TriggerClientEvent("BGS_Compass:enableMap", _source)
    elseif mapCount == 0 and Config.UseMap then
        TriggerClientEvent("BGS_Compass:disableMap", _source)
    end
    ]]

    -- Z add
    -- get count of both
    local compassCount = exports.vorp_inventory:getItemCount(_source, nil, Config.CompassItemToCheck)
    local mapCount = exports.vorp_inventory:getItemCount(_source, nil, Config.MapItemToCheck)

    if Config.UseCompass and compassCount > 0 then
        if Config.UseMap and mapCount > 0 then
            --print('B')
            -- triggerClientEvent that handles on foot and on mount for both items
            TriggerClientEvent("BGS_Compass:enableMap", _source)
            --TriggerClientEvent("BGS_Compass:showMiniMap", _source)
            TriggerClientEvent("BGS_Compass:mapState", _source, 0)
        elseif mapCount == 0 and Config.UseMap then
            --print('C')
            -- triggerClientEvent that handles compass only for foot and mount
            TriggerClientEvent("BGS_Compass:disableMap", _source)
            --TriggerClientEvent("BGS_Compass:showMiniMap", _source)
            TriggerClientEvent("BGS_Compass:mapState", _source, 1)
        end
    elseif Config.UseMap and mapCount > 0 and compassCount == 0 then
        --print('M')
        -- triggerClientEvent that handles map only
        TriggerClientEvent("BGS_Compass:enableMap", _source)
        --TriggerClientEvent("BGS_Compass:hideMiniMap", _source)
        TriggerClientEvent("BGS_Compass:mapState", _source, 2)
    else
        --print('Neither')
        -- triggerClientEvent(fulldisable)
        TriggerClientEvent("BGS_Compass:disableMap", _source)
        --TriggerClientEvent("BGS_Compass:hideMiniMap", _source)
        TriggerClientEvent("BGS_Compass:mapState", _source, 3)
    end
    -- ]]
    -- if compass only
    -- if map only
    -- if both
    -- else none
    --[[
    
    ]]
end)

RegisterServerEvent("BGS_Compass:getUserGroup", function()
    local _source = source
    TriggerClientEvent("BGS_Compass:storeUserGroup", _source, VORPcore.getUser(_source).getGroup)
end)