AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/cut/crow.mdl"
ENT.StartHealth = 25
ENT.HullType = HULL_TINY
ENT.TurningSpeed = 12
ENT.TurningUseAllAxis = true
ENT.MovementType = VJ_MOVETYPE_AERIAL
ENT.Aerial_FlyingSpeed_Calm = 150
ENT.Aerial_FlyingSpeed_Alerted = 150
ENT.AA_GroundLimit = 400
ENT.AA_MinWanderDist = 300
ENT.ControllerParams = {
    FirstP_Bone = "Crow.Head",
    FirstP_Offset = Vector(10, 0, 0),
    FirstP_ShrinkBone = false
}
ENT.IdleAlwaysWander = true
ENT.CanOpenDoors = false
ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr1_blood_red"
ENT.BloodDecal = "VJ_PARR1_Blood_Red"
ENT.HasBloodPool = false
ENT.HasMeleeAttack = false

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = ACT_DIESIMPLE

ENT.SoundTbl_Idle = "vj_parr/par1/crow/crow.wav"
ENT.SoundTbl_Pain = "vj_parr/par1/crow/crow.wav"
ENT.SoundTbl_Death = "vj_parr/par1/crow/crow.wav"
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

ENT.MainSoundPitch = VJ.SET(95, 105)

-- Custom
ENT.Crow_FollowOffsetPos = 0

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self:SetCollisionBounds(Vector(10, 10, 10), Vector(-10, -10, 0))
    self.Crow_FollowOffsetPos = Vector(math_random(-50, 50), math_random(-120, 120), math_random(-150, 150))
    if !IsValid(VJ.HLR_NPC_Crow_Leader) then
        VJ.HLR_NPC_Crow_Leader = self
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    if act == ACT_IDLE then
        return ACT_FLY
    end
    return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
    if self.VJ_Controlled then return end
    local leader = VJ.HLR_NPC_Crow_Leader
    if IsValid(leader) then
        if leader != self && leader.AA_CurrentMovePos then
            self.DisableWandering = true
            self:AA_MoveTo(leader, true, "Calm", {AddPos = self.Crow_FollowOffsetPos, IgnoreGround = true}) -- Medzavorin haladz e (Kharen deghme)
        end
    else
        self.IsGuard = false
        self.DisableWandering = false
        VJ.HLR_NPC_Crow_Leader = self
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" && GetConVar("vj_hlr1_corpse_static"):GetInt() == 1 && VJ_CVAR_AI_ENABLED && self.HasDeathAnimation then
        self.DeathAnimationDecreaseLengthAmount = -1
        self.DeathCorpseEntityClass = "prop_vj_animatable"
        VJ.HLR_StaticCorpseCheck(self)
    elseif status == "DeathAnim" then
        self:DoChangeMovementType(VJ_MOVETYPE_GROUND)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ.Color2Byte(Color(130, 19, 10))
local gibsCollideSd = {"vj_parr/par1/shared/flesh1.wav", "vj_parr/par1/shared/flesh2.wav", "vj_parr/par1/shared/flesh3.wav", "vj_parr/par1/shared/flesh5.wav", "vj_parr/par1/shared/flesh6.wav", "vj_parr/par1/shared/flesh7.wav"}
--
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
    self.HasDeathSounds = false
    if self.HasGibOnDeathEffects then
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos() + self:OBBCenter())
        effectData:SetColor(colorRed)
        effectData:SetScale(90)
        util.Effect("VJ_Blood1", effectData)
        effectData:SetScale(8)
        effectData:SetFlags(3)
        effectData:SetColor(1)
        util.Effect("bloodspray", effectData)
        util.Effect("bloodspray", effectData)
    end

    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 5))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib2.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(1, 0, 5))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib3.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 5))})
    self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
    return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibs = {"models/vj_parr/par1/gibs/hgib1.mdl", "models/vj_parr/par1/gibs/hgib2.mdl", "models/vj_parr/par1/gibs/hgib3.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    VJ.HLR_ApplyCorpseSystem(self, corpse, gibs, {CollisionSound = gibsCollideSd, ExpSound = "vj_parr/par1/shared/bodysplat.wav", SplatDecal = "VJ_PARR1_Blood_Red_Large"})
end