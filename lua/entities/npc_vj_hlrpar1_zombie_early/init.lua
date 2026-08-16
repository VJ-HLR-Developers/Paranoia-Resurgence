include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/early/zombie_slow.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self:SetBodygroup(1, math_random(0, 5))
    self:SetBodygroup(2, math_random(0, 1))
    self:SetBodygroup(3, math_random(0, 1))
end