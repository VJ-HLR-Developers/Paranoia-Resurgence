include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/zombie.mdl"
ENT.ControllerParams.FirstP_Bone = "Bip01_Head2"

ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTARM, Animation = ACT_FLINCH_LEFTARM}, {HitGroup = HITGROUP_RIGHTARM, Animation = ACT_FLINCH_RIGHTARM}}

ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIE_HEADSHOT, ACT_DIESIMPLE}

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    if self:GetModel() == "models/vj_parr/par1/early/zombie.mdl" then
        self.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD}
    end
    self:SetBodygroup(1, math_random(0, 2))
    self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
end