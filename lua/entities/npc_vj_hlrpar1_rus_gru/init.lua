include("entities/npc_vj_hlrpar1_rus_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/cut/soldier_gru.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self:SetBodygroup(1, math_random(0, 5))
end