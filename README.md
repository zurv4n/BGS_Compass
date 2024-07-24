# BGS_Compass
## Usage
A simple compass/map item mod to use in your RedM VORP server.

Associates the usage of the compass/map (configurable on and off for each) with an item.

If the player has the compass item, they can see their compass (compass visibility and type is configurable).<br>
The player can also select their own compass type in the game menu but this will still require the compass item (configurable on/off).

If the player has the map item, they can use the map.

Item names are configurable, as well as the time to check for map/compass inventory updates.

Big thanks to Outsider for his help on optimizing this!

### REQUIRES VORP


### Z changes

Added the image and corresponding sql<br>

I have created a logic set that changes based on possession of either or both items as well as a town check.<br>

The current logic structure:<br>
With COMPASS only: both on foot and on horse, compass is visible<br>
With MAP only: no radar displayed when mounted or in vehicle. Minimap while on foot in town (RP - use bildings to orient map)<br>
With COMPASS and MAP: compass needle while mounted or in vehicle, minimap while on foot no matter the location.<br>

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES ('misc_map_map', 'Map', 5, 1, 'item_standard', 1, 'So you know where to go'); <br>
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES ('misc_map_compass', 'Compass', 5, 1, 'item_standard', 1, 'So you know how to get there');
