include("entities/npc_vj_hlrpar2_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/cut/dog_zombied.mdl"
ENT.StartHealth = 100
ENT.HullType = HULL_WIDE_SHORT
ENT.FlinchHitGroupMap = false
ENT.HasLeapAttack = true
ENT.LeapAttackDamage = 20
ENT.AnimTbl_LeapAttack = ACT_RANGE_ATTACK1
ENT.LeapAttackMaxDistance = 156
ENT.LeapAttackMinDistance = 128
ENT.LeapAttackDamageDistance = 50
ENT.TimeUntilLeapAttackDamage = 0.2
ENT.TimeUntilLeapAttackVelocity = 0.2
ENT.NextLeapAttackTime = 1
ENT.LeapAttackExtraTimers = {0.4, 0.6, 0.8}
ENT.NextAnyAttackTime_Leap = 3
ENT.LeapAttackStopOnHit = true
ENT.AnimTbl_Death = ACT_DIESIMPLE

ENT.SoundTbl_FootStep = {"vj_parr/par1/player/pl_wood_scr1.wav", "vj_parr/par1/player/pl_wood_scr2.wav", "vj_parr/par1/player/pl_wood_scr3.wav", "vj_parr/par1/player/pl_wood_scr4.wav"}
ENT.SoundTbl_LeapAttackDamageMiss = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self:SetCollisionBounds(Vector(13, 13, 40), Vector(-13, -13, 0))
    baseclass.Get("npc_vj_hlrpar1_zombie").Init(self)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Voice()
    self.SoundTbl_Alert = {
        "vj_parr/par2/zombie/zo_alert10.wav",
        "vj_parr/par2/zombie/zo_alert20.wav",
        "vj_parr/par2/zombie/zo_alert30.wav"
    }
    self.SoundTbl_BeforeMeleeAttack = {
        "vj_parr/par2/zombie/zo_attack1.wav",
        "vj_parr/par2/zombie/zo_attack2.wav"
    }
    self.SoundTbl_LeapAttackJump = {
        "vj_parr/par2/zombie/zo_attack1.wav",
        "vj_parr/par2/zombie/zo_attack2.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par2/zombie/zo_pain1.wav",
        "vj_parr/par2/zombie/zo_pain2.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par2/zombie/zo_pain1.wav",
        "vj_parr/par2/zombie/zo_pain2.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    local npcState = self:GetNPCState()
    if act == ACT_IDLE && (npcState == NPC_STATE_ALERT or npcState == NPC_STATE_COMBAT) then
        return ACT_IDLE_ANGRY
    end
    return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnLeapAttack(status, enemy)
    if status == "Jump" then
        return VJ.CalculateTrajectory(self, NULL, "Curve", self:GetPos() + self:OBBCenter(), self:GetEnemy():EyePos(), 1) + self:GetForward() * 150 - self:GetUp() * 15
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFlinch(dmginfo, hitgroup, status)
    if status == "Init" then
        return !self:OnGround() -- If it's not on ground, then don't play flinch so it won't cut off leap attacks mid air!
    end
    baseclass.Get("npc_vj_hlrpar1_zombie").OnFlinch(self, dmginfo, hitgroup, status)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        if VJ_CVAR_AI_ENABLED && self.HasDeathAnimation then
            self.DeathAnimationDecreaseLengthAmount = -1
            self.DeathCorpseEntityClass = "prop_vj_animatable"
            VJ.HLR_StaticCorpseCheck(self)
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
local gibsCollideSd = {"vj_parr/par1/shared/flesh1.wav", "vj_parr/par1/shared/flesh2.wav", "vj_parr/par1/shared/flesh3.wav", "vj_parr/par1/shared/flesh5.wav", "vj_parr/par1/shared/flesh6.wav", "vj_parr/par1/shared/flesh7.wav"}
local colorRed = VJ.Color2Byte(Color(130, 19, 10))
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
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {CollisionDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 20))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib2.mdl", {CollisionDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 20))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib3.mdl", {CollisionDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(1, 0, 20))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib4.mdl", {CollisionDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 2, 20))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib5.mdl", {CollisionDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(2, 0, 20))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib6.mdl", {CollisionDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 3, 20))})
    self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
    return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    if self.DeathCorpseEntityClass != "prop_vj_animatable" then return end
    corpse:ResetSequence(self:GetSequence())
    corpse:SetCycle(1)
    corpse:SetMoveType(self:GetMoveType())
    corpse:SetCollisionGroup(self.DeathCorpseCollisionType)
    local minBounds, maxBounds = self:GetCollisionBounds()
    corpse:SetCollisionBounds(Vector(minBounds.x, maxBounds.y, 5), Vector(-minBounds.x, -maxBounds.y, 0))
    corpse:SetSurroundingBounds(Vector(minBounds.x * 100, maxBounds.y * 100, 5 * 100), Vector(-minBounds.x * 100, -maxBounds.y * 100, 0))
    baseclass.Get("npc_vj_hlrpar1_zombie").OnCreateDeathCorpse(self, dmginfo, hitgroup, corpse)
end