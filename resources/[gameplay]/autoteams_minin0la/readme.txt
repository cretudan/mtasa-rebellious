------------------------------------------------------------ Created by |DGT|Puma-------------------------------
------------------------------------------------------------for [HUN/ENG]DGT Clan Server 24/7----------------------



Open server.lua  to "local names" write the clan name(on Scoreboard) to "local tags" write the tag (tag in the player name ) and to "local colors" write the color code for the team
ex.

local names ={"Admin Team","Player's"}
local tags  ={"%|AT%|","%[PT%]"}
local colors ={"#fffafa","#ff0000"}
local acls={"Admin","none"}

to tags you must put % else the script won't work :  |DGT| ------> %|DGT%|  the % must be the firs character and last but one.
for acls if you wanna check player acl group(if the player have in neame the tag but  he is not Admin he will be not moved in that team)
for check acl write the acl group name ex. "Admin","Modelator" ... and "none" if you don't wanna to check(if you write "none" it will check only the tag's as done before)