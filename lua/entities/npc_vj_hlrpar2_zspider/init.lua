AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/monster_spidermutant.mdl"
ENT.StartHealth = 25
ENT.SightAngle = 120
ENT.HullType = HULL_TINY
ENT.ControllerParams = {
    ThirdP_Offset = Vector(10, 0, 0),
    FirstP_Bone = "Head",
    FirstP_Offset = Vector(2, 0, 0)
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr2_blood_red"
ENT.BloodDecal = "VJ_PARR2_Blood_Red"
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.HasMeleeAttack = false

ENT.HasLeapAttack = true
ENT.LeapAttackDamage = 20
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

-- Custom
ENT.Zombie_Buffed = false
ENT.Brain_Ent = NULL

local math_random = math.random
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
    -- Spawn animation
    if VJ_CVAR_AI_ENABLED && (math_random(1, 3) == 1 or self.Zombie_Turned) then
        timer.Simple(0, function()
            if IsValid(self) then
                self:PlayAnim("scen_outofhole", true, false)
                self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
            end
        end)
        timer.Simple(VJ.AnimDuration(self, "scen_outofhole"), function()
            if IsValid(self) then
                self:SetState()
            end
        end)
    end
    self:SetCollisionBounds(Vector(10, 10, 22), Vector(-10, -10, 0))
    self:SetSurroundingBounds(Vector(40, 40, 80), Vector(-40, -40, 0))
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
        return !self:OnGround() -- If it's not on ground, then don't play flinch so it won't cut off leap attacks mid air!
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnLeapAttack(status, enemy)
    if status == "Jump" then
        return VJ.CalculateTrajectory(self, NULL, "Curve", self:GetPos() + self:OBBCenter(), self.EnemyData.Target:EyePos(), 1) + self:GetForward() * 80 - self:GetUp() * 30
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ.Color2Byte(Color(130, 19, 10))
local cloneList = {["npc_vj_hlrpar1_clone"] = true, ["npc_vj_hlrpar1_clo_v1"] = true, ["npc_vj_hlrpar1_clo_heavy"] = true, ["npc_vj_hlrpar1_clo_heavy_v1"] = true, ["npc_vj_hlrpar2_clone"] = true, ["npc_vj_hlrpar2_clone_v1"] = true}
local hazmatSciList = {["npc_vj_hlrpar1_sci_haz"] = true, ["npc_vj_hlrpar2_pirogov"] = true}
local sciFemaleList = {["npc_vj_hlrpar1_sci_fem"] = true, ["npc_vj_hlrpar1_paulina"] = true, ["npc_vj_hlrpar2_paulina"] = true}
local spetsnazList = {["npc_vj_hlrpar1_rus_alpha"] = true, ["npc_vj_hlrpar1_rus_alpha_savior"] = true, ["npc_vj_hlrpar1_rus_alpha_v1"] = true, ["npc_vj_hlrpar1_rus_alpha_v2"] = true, ["npc_vj_hlrpar1_rus_alpha_offd"] = true, ["npc_vj_hlrpar1_rus_alpha_offd_v1"] = true, ["npc_vj_hlrpar1_rus_alpha_offd_v2"] = true, ["npc_vj_hlrpar2_rus_alpha"] = true, ["npc_vj_hlrpar2_rus_alpha_v1"] = true}
--
function ENT:OnKilledEnemy(ent, inflictor, wasLast)
    if GetConVar("VJ_PARR_Zombie_Infection"):GetInt() == 0 then return end
    if ent.VJ_ID_Undead or (ent.IsVJBaseSNPC_Human && ent.BloodColor != VJ.BLOOD_COLOR_RED) then return end
    if math_random(1, 2) == 1 && (ent:LookupBone("Bip01 Pelvis") or ent:LookupBone("Bip02 Pelvis") or ent:LookupBone("bip01_pelvis") or ent:LookupBone("unnamed002") or ent:LookupBone("ValveBiped.Bip01_Pelvis")) then
        local findPos = ent:GetPos()
        local findMDL = ent:GetModel()
        timer.Simple(0, function()
            for _, v in pairs(ents.FindInSphere(findPos, 1)) do
                if IsValid(v) && GetConVar("ai_serverragdolls"):GetInt() == 1 && v:GetClass() == "prop_ragdoll" && v:GetModel() == findMDL then
                    v:Remove()
                end
            end
        end)
        if IsValid(ent:GetParent()) then
            ent:SetPos(ent:GetParent():GetAttachment(ent:GetParentAttachment()).Pos)
            ent:SetParent(NULL)
        end
        if ent.IsVJBaseSNPC then
            ent.HasDeathCorpse = false
            ent.DeathAnimationTime = 99
            //ent.DeathDelayTime = 5
            ent.CanGib = false
        end
        if ent.IsDrGNextbot then
            ent.RagdollOnDeath = false
        end
        if ent:IsPlayer() then
            local plyRag = ent:GetRagdollEntity()
            if IsValid(plyRag) then
                plyRag:Remove()
            end
        end
        if ent:IsNPC() or ent:IsNextBot() then
            if ent:IsNPC() && !ent.IsVJBaseSNPC then
                local wep = ent:GetActiveWeapon()
                if IsValid(wep) then
                    wep:Remove()
                end
            end
            ent.HasRagdoll = false
        end
        local entDeath = VJ.PICK(ent.AnimTbl_Death)
        if ent.IsVJBaseSNPC then
            timer.Simple(0, function() if IsValid(ent) then ent:PlayAnim(entDeath, true, false) end end)
        end
        timer.Simple(VJ.AnimDuration(ent, entDeath), function()
            if IsValid(ent) then
                local entClass = ent:GetClass()
                local zomList = VJ.PICK({"npc_vj_hlrpar2_zombie", "npc_vj_hlrpar2_zombie_v1", "npc_vj_hlrpar2_zclassic"})
                local zomCloneList = VJ.PICK({"npc_vj_hlrpar1_zclone", "npc_vj_hlrpar1_zclone_v1", "npc_vj_hlrpar1_zclone_armed"})
                local zombie = ents.Create(
                    (cloneList[entClass] && zomCloneList) or (spetsnazList[entClass] && "npc_vj_hlrpar1_zalpha")
                    or (entClass == "npc_vj_hlrpar1_scientist" && "npc_vj_hlrpar2_zscientist") or (sciFemaleList[entClass] && "npc_vj_hlrpar2_zscientist_fem") or (hazmatSciList[entClass] && "npc_vj_hlrpar2_zhazmat") or zomList
                )
                if ent.VJ_ID_Living then
                    zombie:SetPos(ent:GetPos())
                    zombie:SetAngles(ent:GetAngles())
                    zombie.Zombie_Turned = true
                    zombie.GodMode = true
                    zombie:Spawn()
                    undo.ReplaceEntity(ent, zombie)
                end
                if ent:IsPlayer() then
                    ent:Spectate(OBS_MODE_CHASE)
                    ent:SpectateEntity(zombie)
                end
                zombie:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
                if zombie.HasGibOnDeathEffects then
                    local effectData = EffectData()
                    effectData:SetOrigin(zombie:GetPos() + zombie:OBBCenter())
                    effectData:SetColor(colorRed)
                    effectData:SetScale(80)
                    util.Effect("VJ_Blood1", effectData)
                    effectData:SetScale(8)
                    effectData:SetFlags(3)
                    effectData:SetColor(0)
                    util.Effect("bloodspray", effectData)
                    util.Effect("bloodspray", effectData)
                end
                timer.Simple(1, function()
                    if IsValid(zombie) then
                        zombie.GodMode = false
                        if timer.Exists("timer_melee_bleed" .. zombie:EntIndex()) then timer.Remove("timer_melee_bleed" .. zombie:EntIndex()) end
                    end
                end)
                local wepEnt = ent.WeaponEntity
                if IsValid(wepEnt) then wepEnt:Remove() end
                ent:Remove()
            end
        end)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
    if status == "Init" then
        -- Make spider immune to DMG_NERVEGAS, based on source code
        if dmginfo:IsDamageType(DMG_NERVEGAS) then
            dmginfo:SetDamage(0)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        if GetConVar("vj_hlr1_corpse_static"):GetInt() == 1 && VJ_CVAR_AI_ENABLED && self.HasDeathAnimation then
            self.DeathAnimationDecreaseLengthAmount = -1
            self.DeathCorpseEntityClass = "prop_vj_animatable"
            VJ.HLR_StaticCorpseCheck(self)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
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