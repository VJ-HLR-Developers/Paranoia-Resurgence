AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/krisa.mdl"
ENT.StartHealth = 1
ENT.TurningSpeed = 120
ENT.HullType = HULL_TINY
ENT.ControllerParams = {
    ThirdP_Offset = Vector(0, 0, 20),
    FirstP_Bone = "Dummy01",
    FirstP_Offset = Vector(0, 0, 4),
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.CanOpenDoors = false
ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr1_blood_red"
ENT.BloodDecal = "VJ_PARR1_Blood_Red"
ENT.HasBloodPool = false
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = ACT_DIESIMPLE
ENT.HasMeleeAttack = false
ENT.FootstepSoundTimerRun = 3
ENT.FootstepSoundTimerWalk = 3
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = "vj_parr/par1/roach/rch_walk.wav"
ENT.SoundTbl_Death = "vj_parr/par1/roach/rch_die.wav"
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

-- Custom
ENT.Rat_SteppedOn = false

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self:SetCollisionBounds(Vector(5, 5, 5), Vector(-5, -5, 0))
    self.HasDeathSounds = math_random(0, 4) == 1 -- 1 in 5 chance to play a death squeak sound | Based on: https://github.com/ValveSoftware/halflife/blob/master/dlls/roach.cpp#L166
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTouch(ent)
    if ent.VJ_ID_Living && !self.GodMode then
        self.Rat_SteppedOn = true
        self:TakeDamage(self:Health() + 1, ent, ent)
        -- Based on:   EMIT_SOUND_DYN(ENT(pev), CHAN_BODY, "roach/rch_smash.wav", 0.7, ATTN_NORM, 0, 80 + RANDOM_LONG(0, 39) );
        VJ.EmitSound(self, "vj_parr/par1/roach/rch_smash.wav", 60, 80 + math_random(0, 39))
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
    if status == "Init" then
        -- Spawn a unique decal from headshots or being stepped on, based on source code
        if hitgroup == HITGROUP_HEAD or self.Rat_SteppedOn then
            self.BloodDecal = "VJ_PARR1_Brains"
        else
            self.BloodDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red"
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        if GetConVar("vj_hlr1_corpse_static"):GetInt() == 1 && VJ_CVAR_AI_ENABLED && self.HasDeathAnimation then
            self.DeathAnimationDecreaseLengthAmount = -1
            self.DeathCorpseEntityClass = "prop_vj_animatable"
        end
        if hitgroup == HITGROUP_HEAD then
            VJ.EmitSound(self, "vj_parr/par1/shared/headshot.wav", 75, 100)
        end
    elseif status == "Finish" then
        -- Reset the blood decals to default if hit in head
        self.BloodDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red"
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
        effectData:SetScale(30)
        util.Effect("VJ_Blood1", effectData)
    end
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd})
    self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
    return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibs = {"models/vj_parr/par1/gibs/hgib1.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    VJ.HLR_ApplyCorpseSystem(self, corpse, gibs, {CollisionSound = gibsCollideSd, ExpSound = "vj_parr/par1/shared/bodysplat.wav", SplatDecal = "VJ_PARR1_Blood_Red_Large"})
end