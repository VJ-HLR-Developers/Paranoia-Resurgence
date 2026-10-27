AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/custom/dog.mdl"
ENT.StartHealth = 200
ENT.HullType = HULL_WIDE_SHORT
ENT.ControllerParams = {
    FirstP_Bone = "joint4",
    FirstP_Offset = Vector(10, 0, 11.5),
    FirstP_ShrinkBone = false
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr1_blood_red"
ENT.BloodDecal = "VJ_PARR1_Blood_Red"
ENT.HasBloodPool = false
ENT.Immune_Toxic = true

ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1, ACT_MELEE_ATTACK2}
ENT.TimeUntilMeleeAttackDamage = false
ENT.HasMeleeAttackKnockBack = true

ENT.HasRangeAttack = true
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
ENT.RangeAttackProjectiles = "obj_vj_hlr1_toxicspit"
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.NextRangeAttackTime = 1.5
ENT.RangeAttackMaxDistance = 784
ENT.RangeAttackMinDistance = 256

ENT.LimitChaseDistance = "OnlyRange"
ENT.LimitChaseDistance_Max = "UseRangeDistance"
ENT.LimitChaseDistance_Min = "UseRangeDistance"

ENT.CanTurnWhileMoving = false
ENT.CanFlinch = true
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIESIMPLE, ACT_DIEFORWARD}
ENT.DisableFootStepSoundTimer = true

ENT.SoundTbl_FootStep = {"vj_parr/par1/player/pl_wood_scr1.wav", "vj_parr/par1/player/pl_wood_scr2.wav", "vj_parr/par1/player/pl_wood_scr3.wav", "vj_parr/par1/player/pl_wood_scr4.wav"}
ENT.SoundTbl_Alert = {"vj_parr/par1/bullchicken/bc_idle1.wav", "vj_parr/par1/bullchicken/bc_idle2.wav", "vj_parr/par1/bullchicken/bc_idle2.wav", "vj_parr/par1/bullchicken/bc_idle3.wav", "vj_parr/par1/bullchicken/bc_idle4.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_parr/par1/bullchicken/bc_attackgrowl.wav", "vj_parr/par1/bullchicken/bc_attackgrowl2.wav", "vj_parr/par1/bullchicken/bc_attackgrowl3.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_parr/par1/bullchicken/bc_bite1.wav", "vj_parr/par1/bullchicken/bc_bite2.wav", "vj_parr/par1/bullchicken/bc_bite3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_parr/par1/zombie/claw_miss1.wav", "vj_parr/par1/zombie/claw_miss2.wav"}
ENT.SoundTbl_RangeAttack = {"vj_parr/par1/bullchicken/bc_attack2.wav", "vj_parr/par1/bullchicken/bc_attack3.wav"}
ENT.SoundTbl_Pain = {"vj_parr/par1/bullchicken/bc_pain1.wav", "vj_parr/par1/bullchicken/bc_pain2.wav", "vj_parr/par1/bullchicken/bc_pain3.wav", "vj_parr/par1/bullchicken/bc_pain4.wav"}
ENT.SoundTbl_Death = {"vj_parr/par1/bullchicken/bc_die1.wav", "vj_parr/par1/bullchicken/bc_die2.wav", "vj_parr/par1/bullchicken/bc_die3.wav"}
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

-- Custom
ENT.Zombie_Buffed = false
ENT.Brain_Ent = NULL

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self:SetCollisionBounds(Vector(30, 30, 44), Vector(-30, -30, 0))
    self:SetSurroundingBounds(Vector(80, 80, 150), Vector(-80, -80, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
    //print(key)
    if key == "step" then
        self:PlayFootstepSound()
    elseif key == "melee_whip" then
        self.MeleeAttackDamage = 25
        self:ExecuteMeleeAttack()
    elseif key == "melee_bite" then
        self.MeleeAttackDamage = 15
        self:ExecuteMeleeAttack()
    elseif key == "range" then
        self:ExecuteRangeAttack()
    elseif key == "body" then
        VJ.EmitSound(self, "vj_parr/par1/shared/bodydrop" .. math_random(1, 2) .. ".wav", 75, 100)
        local watLevel = self:WaterLevel()
        if watLevel > 0 && watLevel < 3 then
            ParticleEffect("water_splash_01", self:GetPos(), Angle())
            VJ.EmitSound(self, "vj_parr/par1/shared/splash_impact1.wav", 75, 100)
            /*local effectdata = EffectData()
            effectdata:SetOrigin(self:GetPos())
            effectdata:SetScale(10)
            util.Effect("watersplash", effectdata)*/
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent)
    if math_random(1, 3) == 1 then
        if ent.VJ_ID_Headcrab then
            self:PlayAnim("seecrab", true, false, true)
        else
            self:PlayAnim(ACT_HOP, true, false, true)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjPos(projectile)
    return self:GetAttachment(self:LookupAttachment("mouth")).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjVel(projectile)
    ParticleEffect("vj_hlr_spit_acid_spawn", self:GetPos() + self:OBBCenter() + self:GetForward() * 35, self:GetForward():Angle(), projectile)
    return VJ.CalculateTrajectory(self, self.EnemyData.Target, "Curve", projectile:GetPos(), 1, 10)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRangeAttackExecute(status, enemy, projectile)
    if status == "PostSpawn" then
        projectile.RadiusDamage = 20
        projectile.SoundTbl_Idle = {
            "vj_parr/par1/bullchicken/bc_acid1.wav",
            "vj_parr/par1/bullchicken/bc_acid2.wav"
        }
        projectile.SoundTbl_OnCollide = {
            "vj_parr/par1/bullchicken/bc_spithit1.wav",
            "vj_parr/par1/bullchicken/bc_spithit2.wav"
        }
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackKnockbackVelocity(ent)
    return self:GetForward() * 55 + self:GetUp() * 255
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
    if victim.LNR_InfectedVictim or victim.GOTDR_InfectedVictim or victim.NMRIHR_InfectedVictim or victim.CNCR_InfectedVictim or victim.ZPS_InfectedVictim or victim.OSZ_InfectedVictim then return end
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
                local zomList = VJ.PICK({"npc_vj_hlrpar1_zombie", "npc_vj_hlrpar1_zombie_v1"})
                local zomCloneList = VJ.PICK({"npc_vj_hlrpar1_zclone", "npc_vj_hlrpar1_zclone_v1", "npc_vj_hlrpar1_zclone_armed"})
                local zombie = ents.Create(
                    (cloneList[entClass] && zomCloneList) or (spetsnazList[entClass] && "npc_vj_hlrpar1_zalpha")
                    or (entClass == "npc_vj_hlrpar1_scientist" && "npc_vj_hlrpar1_zscientist") or (sciFemaleList[entClass] && "npc_vj_hlrpar1_zscientist_fem") or (hazmatSciList[entClass] && "npc_vj_hlrpar1_zhazmat") or zomList
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
                        local zomBleedTmr = "timer_melee_bleed" .. zombie:EntIndex()
                        zombie.GodMode = false
                        if timer.Exists(zomBleedTmr) then timer.Remove(zomBleedTmr) end
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
function ENT:OnFlinch(dmginfo, hitgroup, status)
    if status == "Init" then
        if dmginfo:GetDamage() > 30 then
            self.FlinchChance = 6
            self.AnimTbl_Flinch = ACT_BIG_FLINCH
        else
            self.FlinchChance = 14
            self.AnimTbl_Flinch = ACT_SMALL_FLINCH
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
    if status == "Init" then
        -- Make zombies immune to DMG_NERVEGAS, based on source code
        if dmginfo:IsDamageType(DMG_NERVEGAS) then
            dmginfo:SetDamage(0)
        end
    elseif status == "PreDamage" && self.Zombie_Buffed then
        -- Take 30% of bullet damage, based on source code
        if dmginfo:IsBulletDamage() then
            dmginfo:ScaleDamage(0.3)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" && GetConVar("vj_hlr1_corpse_static"):GetInt() == 1 && VJ_CVAR_AI_ENABLED && self.HasDeathAnimation then
        self.DeathAnimationDecreaseLengthAmount = -1
        self.DeathCorpseEntityClass = "prop_vj_animatable"
        VJ.HLR_StaticCorpseCheck(self)
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

    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib2.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 20))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib3.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 30))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib4.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 35))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib5.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 50))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib6.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 55))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib2.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 45))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib3.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 25))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib4.mdl", {BloodType = "Red", CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 15))})
    self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
    return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibs = {"models/vj_parr/par1/gibs/hgib1.mdl", "models/vj_parr/par1/gibs/hgib2.mdl", "models/vj_parr/par1/gibs/hgib3.mdl", "models/vj_parr/par1/gibs/hgib4.mdl", "models/vj_parr/par1/gibs/hgib5.mdl", "models/vj_parr/par1/gibs/hgib6.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    VJ.HLR_ApplyCorpseSystem(self, corpse, gibs, {CollisionSound = gibsCollideSd, ExpSound = "vj_parr/par1/shared/bodysplat.wav", SplatDecal = "VJ_PARR1_Blood_Red_Large"})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFootstepSound(moveType, sdFile)
    if !self:OnGround() then return end
    local watLevel = self:WaterLevel()
    if watLevel > 0 && watLevel < 3 then
        VJ.EmitSound(self, "vj_parr/par1/shared/npc_slosh" .. math_random(1, 2) .. ".wav", self.FootstepSoundLevel, self:GetSoundPitch(self.FootstepSoundPitch))
    end
end