include("entities/npc_vj_hlrpar2_clone/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par2/v1/monster_clonsoldier.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self:SetBodygroup(1, math_random(0, 2))
end