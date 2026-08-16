include("entities/npc_vj_hlrpar2_zarmed/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par2/v1/monster_soldiershooter.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.Zombie_WepBG = 2
    self.Zombie_WepBGRemove = 2
    self:SetBodygroup(self.Zombie_WepBG, math_random(0, 1))
end