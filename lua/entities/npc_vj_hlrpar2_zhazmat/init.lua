include("entities/npc_vj_hlrpar2_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par2/monster_deadhazmat.mdl"
ENT.FlinchHitGroupMap = false

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self:SetSkin(math_random(0, 1))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    if act == ACT_IDLE && self.Alerted then
        return ACT_IDLE_ANGRY
    end
    return self.BaseClass.TranslateActivity(self, act)
end