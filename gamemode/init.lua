ev = ev or {util = {}, gui = {}, meta = {}}

-- Send the following files to players.
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("core/sh_util.lua")
AddCSLuaFile("shared.lua")

-- Include utility functions then shared.lua
include("core/sh_util.lua")
include("shared.lua")

function GM:PlayerSpawn(client, transition)
    client:SetModel("models/humans/group01/male_01.mdl")
end