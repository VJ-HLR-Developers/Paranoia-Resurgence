AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/monster_spidermutant.mdl"
ENT.StartHealth = 50
ENT.SightAngle = 120
ENT.HullType = HULL_TINY
ENT.ControllerParams = {
    ThirdP_Offset = Vector(10, 0, 0),
    FirstP_Bone = "Head",
    FirstP_Offset = Vector(2, 0, 0),
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr2_blood_red"
ENT.BloodDecal = "VJ_PARR2_Blood_Red"
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.HasMeleeAttack = false

ENT.HasLeapAttack = true
ENT.LeapAttackDamage = 10
ENT.AnimTbl_LeapAttack = ACT_SPECIAL_ATTACK1
ENT.LeapAttackMaxDistance = 256
ENT.LeapAttackMinDistance = 1
ENT.LeapAttackDamageDistance = 50
ENT.TimeUntilLeapAttackDamage = 0.2
ENT.TimeUntilLeapAttackVelocity = 0.2
ENT.NextLeapAttackTime = 1
ENT.LeapAttackExtraTimers = {0.4, 0.6, 0.8}
ENT.NextAnyAttackTime_Leap = 3
ENT.LeapAttackStopOnHit = true

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = ACT_DIESIMPLE
ENT.LimitChaseDistance = true
ENT.LimitChaseDistance_Max = 200
ENT.LimitChaseDistance_Min = 0

ENT.CanFlinch = true
ENT.FlinchChance = 3
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH

ENT.DisableFootStepSoundTimer = true

ENT.SoundTbl_FootStep = {"vj_parr/par2/monsters/spidermutant/spider_walk1.wav", "vj_parr/par2/monsters/spidermutant/spider_walk2.wav", "vj_parr/par2/monsters/spidermutant/spider_walk3.wav", "vj_parr/par2/monsters/spidermutant/spider_walk4.wav"}
ENT.SoundTbl_LeapAttackDamage = "vj_parr/par2/spider/headbite.wav"
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

ENT.MainSoundPitch = VJ.SET(95, 105)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
    //print(key)
    if key == "step" then
        self:PlayFootstepSound()
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self.SoundTbl_Alert =
        "vj_parr/par2/spider/alert1.wav"

    self.SoundTbl_LeapAttackJump = {
        "vj_parr/par2/spider/attack1.WAV",
        "vj_parr/par2/spider/attack2.WAV",
        "vj_parr/par2/spider/attack3.WAV"
    }
    self.SoundTbl_Death = {
        "vj_parr/par2/spider/die1.wav",
        "vj_parr/par2/spider/die2.wav",
        "vj_parr/par2/spider/die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par2/spider/pain1.wav",
        "vj_parr/par2/spider/pain2.wav",
        "vj_parr/par2/spider/pain3.wav"
    }
    self:SetCollisionBounds(Vector(10, 10, 22), Vector(-10, -10, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
    -- When in deep water, drown by slowly taking damage
    if self:WaterLevel() > 2 then
        self:SetHealth(self:Health() - 1)
        if self:Health() <= 0 then
            self.Bleeds = false
            self:TakeDamage(1, self, self)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFlinch(dmginfo, hitgroup, status)
    if status == "Init" then
        return !self:IsOnGround() -- If it's not on ground, then don't play flinch so it won't cut off leap attacks mid air!
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnLeapAttack(status, enemy)
    if status == "Jump" then
        return VJ.CalculateTrajectory(self, NULL, "Curve", self:GetPos() + self:OBBCenter(), self:GetEnemy():EyePos(), 1) + self:GetForward() * 80 - self:GetUp() * 30
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        if GetConVar("vj_hlr1_corpse_static"):GetInt() == 1 && VJ_CVAR_AI_ENABLED && self.HasDeathAnimation then
            self.DeathAnimationDecreaseLengthAmount = -1
            self.DeathCorpseEntityClass = "prop_vj_animatable"
        end
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
        effectData:SetScale(120)
        util.Effect("VJ_Blood1", effectData)
        effectData:SetScale(8)
        effectData:SetFlags(3)
        effectData:SetColor(0)
        util.Effect("bloodspray", effectData)
        util.Effect("bloodspray", effectData)
    end
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR2_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 5))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib2.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR2_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(1, 0, 5))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib3.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR2_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 5))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib4.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR2_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(2, 0, 5))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib5.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR2_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 2, 5))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib6.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR2_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 4, 5))})
    self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
    return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local extraGibs = {"models/vj_parr/par1/gibs/hgib1.mdl", "models/vj_parr/par1/gibs/hgib2.mdl", "models/vj_parr/par1/gibs/hgib3.mdl", "models/vj_parr/par1/gibs/hgib4.mdl", "models/vj_parr/par1/gibs/hgib5.mdl", "models/vj_parr/par1/gibs/hgib6.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    VJ.HLR_ApplyCorpseSystem(self, corpse, extraGibs, {CollisionSound = gibsCollideSd, ExpSound = "vj_parr/par1/shared/bodysplat.wav", SplatDecal = "VJ_PARR1_Blood_Red_Large"})
end