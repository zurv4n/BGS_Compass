Config = {}

-- Flags for which systems to use
Config.UseCompass = true                -- Default use compass item
Config.DisableTabWheelCompass = false    -- Disable tab wheel compass (independent of compass being enabled or not)
Config.UseMap = true                    -- Default use map item

-- Compass/map items
Config.CompassItemToCheck   = "misc_map_compass"   -- Compass item in the db to check against
Config.MapItemToCheck       = "misc_map_map"           -- Map item in the db to check against

-- Map types: 0 is off, 1 is normal, 2 is expanded, 3 is simple compass
Config.MapTypeNoCompass = 0             -- Map type displayed with no compass (default nothing)
Config.MapTypeOnFoot = 1                -- Map type displayed on foot (default nothing)
Config.MapTypeOnMount = 3               -- Map type displayed on horseback/vehicle (default simple compass)

-- Whether or not to use user compass value instead of MapTypeCompass values
Config.UseUserCompass = false           -- Default to not use user compass

-- Time interval to check for inventory updates and horse/foot status (in ms)
Config.TimeToCheck = 1000               -- Default 1 seconds

-- List of all user groups that are exempted from the item check (can use map and compass no matter what)
Config.Exempted = {
    --"admin"
}

Config.Towns = {
    -- '1654810713', -- AguasdulcesFarm
    -- '201158410', -- AguasdulcesRuins
    -- '-1207133769', -- AguasdulcesVilla
    '7359335', -- Annesburg
    '-744494798', -- Armadillo
    -- '-1708386982', -- BeechersHope
    '1053078005', -- Blackwater
    -- '1778899666', -- Braithwaite
    -- '-1947415645', -- Butcher
    -- '1862420670', -- Caliga
    -- '-1851305682', -- cornwall
    -- '-473051294', -- Emerald
    -- '406627834', -- lagras
    -- '1299204683', -- Manicato
    -- '1463094051', -- Manzanita
    '2046780049', -- Rhodes
    '2147354003', -- Siska
    '-765540529', -- StDenis
    '427683330', -- Strawberry
    '-1524959147', -- Tumbleweed
    '459833523', -- valentine
    '2126321341', -- VANHORN
    -- '-872622034', -- Wallace
    -- '1663398575', -- wapiti
}