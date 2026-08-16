include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/vj_parr/par1/zombie_slow2.mdl", "models/vj_parr/par1/zombie_slow2a.mdl", "models/vj_parr/par1/zombie_slow2b.mdl"}
ENT.StartHealth = 300

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self:SetBodygroup(1, math_random(0, 3))
end