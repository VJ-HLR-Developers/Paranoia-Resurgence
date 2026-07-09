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
ENT.BloodParticle = "vj_parr_blood_red"
ENT.BloodDecal = "VJ_PARR_Blood_Red"
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

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self:SetCollisionBounds(Vector(5, 5, 5), Vector(-5, -5, 0))
    self.HasDeathSounds = math_random(0, 4) == 1 -- 1 in 5 chance to play a death squeak sound | Based on: https://github.com/ValveSoftware/halflife/blob/master/dlls/roach.cpp#L166
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTouch(ent)
    if ent.VJ_ID_Living then
        self:TakeDamage(self:Health() + 1, ent, ent)
        -- Based on:   EMIT_SOUND_DYN(ENT(pev), CHAN_BODY, "roach/rch_smash.wav", 0.7, ATTN_NORM, 0, 80 + RANDOM_LONG(0, 39) );
        VJ.EmitSound(self, "vj_parr/par1/roach/rch_smash.wav", 60, 80 + math_random(0, 39))
    end
end