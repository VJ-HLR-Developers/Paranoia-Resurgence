include("entities/npc_vj_hlrpar2_zarmed/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par2/cut/soldier_clon_zombied.mdl"
ENT.StartHealth = 300

ENT.Weapon_RetreatDistance = 150

ENT.CombatDamageResponse = true
ENT.AnimTbl_CallForHelp = false
ENT.AnimTbl_TakingCover = ACT_CROUCHIDLE

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.Zombie_WepBG = 2
    self.Zombie_WepBGRemove = 2
    self:SetBodygroup(1, math_random(0, 1))
    if math_random(1, 2) == 1 then self:SetBodygroup(self.Zombie_WepBG, math_random(0, 1)) end
end