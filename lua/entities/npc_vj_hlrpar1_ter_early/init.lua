include("entities/npc_vj_hlrpar1_terrorist/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/early/terror_old.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self:SetSkin(math_random(0, 1))
    self:SetBodygroup(1, math_random(0, 3))
end