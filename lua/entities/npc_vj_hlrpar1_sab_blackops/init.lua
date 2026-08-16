include("entities/npc_vj_hlrpar1_saboteur/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/cut/blackop.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self:SetBodygroup(1, math_random(0, 1))
    self:SetBodygroup(3, math_random(0, 1))

    if self:GetBodygroup(1) == 0 then
        self:SetBodygroup(4, 0)
    else
        self:SetBodygroup(4, 1)
    end
end