AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/zombie_slow.mdl"
ENT.StartHealth = 200
ENT.HullType = HULL_HUMAN
ENT.ControllerParams = {
    ThirdP_Offset = Vector(30, 25, -50),
    FirstP_Bone = "Bone02",
    FirstP_Offset = Vector(3, 0, 5),
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr1_blood_red"
ENT.BloodDecal = "VJ_PARR1_Blood_Red"
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}

-- Melee Attack
ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK1
ENT.TimeUntilMeleeAttackDamage = false

ENT.CanTurnWhileMoving = false
ENT.CanFlinch = true
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH
ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTARM, Animation = ACT_FLINCH_LEFTARM}, {HitGroup = HITGROUP_RIGHTARM, Animation = ACT_FLINCH_RIGHTARM}, {HitGroup = HITGROUP_LEFTLEG, Animation = ACT_FLINCH_LEFTLEG}, {HitGroup = HITGROUP_RIGHTLEG, Animation = ACT_FLINCH_RIGHTLEG}}

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}

-- Sounds
ENT.DisableFootStepSoundTimer = true
ENT.HasExtraMeleeAttackSounds = true

ENT.SoundTbl_FootStep = {"vj_parr/par1/shared/npc_step1.wav", "vj_parr/par1/shared/npc_step2.wav", "vj_parr/par1/shared/npc_step3.wav", "vj_parr/par1/shared/npc_step4.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_parr/par1/zombie/claw_strike1.wav", "vj_parr/par1/zombie/claw_strike2.wav", "vj_parr/par1/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_parr/par1/zombie/claw_miss1.wav", "vj_parr/par1/zombie/claw_miss2.wav"}
ENT.SoundTbl_LeapAttackDamage = {"vj_parr/par1/zombie/claw_strike1.wav", "vj_parr/par1/zombie/claw_strike2.wav", "vj_parr/par1/zombie/claw_strike3.wav"}
ENT.SoundTbl_LeapAttackDamageMiss = {"vj_parr/par1/zombie/claw_miss1.wav", "vj_parr/par1/zombie/claw_miss2.wav"}
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

ENT.MainSoundPitch = VJ.SET(95, 105)

-- Custom
ENT.Zombie_Type = 0 -- 0 = Zombie, 1 = Zombie 4-Armed Mutant, 2 = Zombie 3-Armed Mutant, 3 = Zombie Spider Mutant, 4 = Zombie Ceiling Mutant, 5 = Armed Zombie

local woodSd = {"vj_parr/par1/player/pl_wood_scr1.wav", "vj_parr/par1/player/pl_wood_scr2.wav", "vj_parr/par1/player/pl_wood_scr3.wav", "vj_parr/par1/player/pl_wood_scr4.wav"}

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
    //print(key)
    if key == "step" then
        self:PlayFootstepSound()
    elseif key == "hand" then
        self:PlayFootstepSound(woodSd)
    elseif key == "melee" then
        self.MeleeAttackDamage = 30
        self:ExecuteMeleeAttack()
    elseif key == "melee_both" then
        self.MeleeAttackDamage = 40
        self:ExecuteMeleeAttack()
    elseif key == "range" then
        self:ExecuteRangeAttack()
    elseif key == "shoot" then
        local wep = self:GetActiveWeapon()
        if !IsValid(wep) then
            self:ExecuteRangeAttack()
        end
        if IsValid(wep) then
            wep:NPCShoot_Primary()
            if self.DeathAnimationCodeRan && self.DeathShoot then
                self:DeathShoot()
            end
        end
    elseif key == "body_knee" then
        VJ.EmitSound(self, "vj_parr/par1/shared/body_knee.wav", 75, 100)
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
    if IsValid(self:GetActiveWeapon()) then
        local wep = self.WeaponEntity
        if key == "reload_start" then
            VJ.EmitSound(wep, wep.Reload_Start, 60)
        elseif key == "reload_middle" then
            VJ.EmitSound(wep, wep.Reload_Middle, 60)
        elseif key == "reload_finish" then
            VJ.EmitSound(wep, wep.Reload_Finish, 60)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Voice()
    local pickVoice = math_random(1,2)
    if pickVoice == 1 then
        self.SoundTbl_Alert = {
            "vj_parr/par1/zombie/zo_alert10.wav",
            "vj_parr/par1/zombie/zo_alert20.wav",
            "vj_parr/par1/zombie/zo_alert30.wav"
        }
        self.SoundTbl_BeforeMeleeAttack = {
            "vj_parr/par1/zombie/zo_attack1.wav",
            "vj_parr/par1/zombie/zo_attack2.wav"
        }
        self.SoundTbl_Death = {
            "vj_parr/par1/zombie/zo_pain1.wav",
            "vj_parr/par1/zombie/zo_pain2.wav"
        }
        self.SoundTbl_Pain = {
            "vj_parr/par1/zombie/zo_pain1.wav",
            "vj_parr/par1/zombie/zo_pain2.wav"
        }
    elseif pickVoice == 2 then
        self.SoundTbl_Alert = {
            "vj_parr/par1/zombie/savior/zo_alert10.wav",
            "vj_parr/par1/zombie/savior/zo_alert20.wav",
            "vj_parr/par1/zombie/savior/zo_alert30.wav"
        }
        self.SoundTbl_BeforeMeleeAttack = {
            "vj_parr/par1/zombie/savior/zo_attack1.wav",
            "vj_parr/par1/zombie/savior/zo_attack2.wav"
        }
        self.SoundTbl_Death = {
            "vj_parr/par1/zombie/savior/zo_pain1.wav",
            "vj_parr/par1/zombie/savior/zo_pain2.wav"
        }
        self.SoundTbl_Pain = {
            "vj_parr/par1/zombie/savior/zo_pain1.wav",
            "vj_parr/par1/zombie/savior/zo_pain2.wav"
        }
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self:SetBodygroup(1, math_random(0, 5))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/zombie_slow.mdl" or myMDL == "models/vj_parr/par1/zombie_slow2.mdl" or myMDL == "models/vj_parr/par1/zombie_slow2a.mdl" or myMDL == "models/vj_parr/par1/zombie_slow2b.mdl" or myMDL == "models/vj_parr/par1/savior/zombie_him.mdl" or myMDL == "models/vj_parr/par1/early/zombie_slow.mdl" or myMDL == "models/vj_parr/par1/early/zombie_slow2.mdl" then
        self.Zombie_Type = 0
    elseif myMDL == "models/vj_parr/par1/zombie.mdl" or myMDL == "models/vj_parr/par1/early/zombie.mdl" then
        self.Zombie_Type = 1
    elseif myMDL == "models/vj_parr/par1/z_3h.mdl" or myMDL == "models/vj_parr/par1/early/z_3h.mdl" then
        self.Zombie_Type = 2
    elseif myMDL == "models/vj_parr/par1/spider.mdl" or myMDL == "models/vj_parr/par1/early/spider_v1.mdl" or myMDL == "models/vj_parr/par1/early/v2/spider_v2.mdl" then
        self.Zombie_Type = 3
    elseif myMDL == "models/vj_parr/par1/zombie_c.mdl" or myMDL == "models/vj_parr/par1/early/zombie_c.mdl" then
        self.Zombie_Type = 4
    elseif myMDL == "models/vj_parr/par1/cut/zombie_slow_armed.mdl" then
        self.Zombie_Type = 5
    elseif myMDL == "models/vj_parr/par1/savior/zombie_girl.mdl" or myMDL == "models/vj_parr/par1/savior/zombie_sc.mdl" then
        self.Zombie_Type = 6
    elseif myMDL == "models/vj_parr/par2/monster_soldierguard.mdl" then
        self.Zombie_Type = 7
    elseif myMDL == "models/vj_parr/par2/moster_scientist_male.mdl" then
        self.Zombie_Type = 8
    elseif myMDL == "models/vj_parr/par2/scientist_female_zombie1.mdl" or myMDL == "models/vj_parr/par2/scientist_female_zombie_fresh.mdl" or myMDL == "models/vj_parr/par2/v1/scientist_female_zombie1.mdl" or myMDL == "models/vj_parr/par2/v1/scientist_female_zombie_fresh.mdl" then
        self.Zombie_Type = 9
    elseif myMDL == "models/vj_parr/par2/early/soldier_soviet_guard_zombie.mdl" then
        self.Zombie_Type = 10
    elseif myMDL == "models/vj_parr/par2/monster_deadhazmat.mdl" or myMDL == "models/vj_parr/par2/monster_rotten_girl.mdl" or myMDL == "models/vj_parr/par2/custom/monster_soldierguard.mdl" then
        self.Zombie_Type = 10
    elseif myMDL == "models/vj_parr/par2/early/soldier_soviet_guard_zombie.mdl" then
        self.Zombie_Type = 11
    elseif myMDL == "models/vj_parr/par2/monster_soldier_rhb.mdl" or myMDL == "models/vj_parr/par2/monster_soldiershooter.mdl" or myMDL == "models/vj_parr/par2/cut/monster_himtrooper.mdl" or myMDL == "models/vj_parr/par2/cut/monster_himtrooper2.mdl" or myMDL == "models/vj_parr/par2/cut/soldier_clon_zombied.mdl" or myMDL == "models/vj_parr/par2/v1/monster_soldiershooter.mdl" then
        self.Zombie_Type = 12
    elseif myMDL == "models/vj_parr/par2/cut/monster_superofficer.mdl" then
        self.Zombie_Type = 13
    elseif myMDL == "models/vj_parr/par2/monster_boss.mdl" then
        self.Zombie_Type = 14
    end
    self:SetSurroundingBounds(Vector(60, 60, 90), Vector(-60, -60, 0))
    if self.Zombie_Init then self:Zombie_Init() end
    if self.Zombie_Voice then self:Zombie_Voice() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnMeleeAttack(status, enemy)
    if !VJ.AnimExists(self, ACT_MELEE_ATTACK2) then return end
    if status == "Init" && self.Zombie_Type == 0 then
        if self.MeleeAttack_IsPropAttack or (self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_ATTACK2)) then
            self.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK2
        else
            self.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK1
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackTraceDirection()
    return self:GetForward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ.Color2Byte(Color(130, 19, 10))
--
/*function ENT:OnKilledEnemy(ent, inflictor, wasLast)
    if ent.VJ_ID_Undead or !ent.IsVJBaseSNPC_Human then return end
    if math_random(1, 2) == 1 && (ent:LookupBone("Bip01 Pelvis") or ent:LookupBone("Bip02 Pelvis") or ent:LookupBone("ValveBiped.Bip01_Pelvis")) then
        local findPos = ent:GetPos()
        local findMDL = ent:GetModel()
        timer.Simple(0, function()
            for _, v in pairs(ents.FindInSphere(findPos, 1)) do
                if IsValid(v) && GetConVar("ai_serverragdolls"):GetInt() == 1 && v:GetClass() == "prop_ragdoll" && v:GetModel() == findMDL then
                    v:Remove()
                end
            end
        end)
        if ent.IsVJBaseSNPC then
            ent.HasDeathCorpse = false
            ent.HasDeathAnimation = false
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
            if ent:IsNPC() then
                local wep = ent:GetActiveWeapon()
                if IsValid(wep) then
                    wep:Remove()
                end
            end
            ent.HasRagdoll = false
            ent:Remove()
        end
        local zomList = VJ.PICK({"npc_vj_hlrpar1_zombie", "npc_vj_hlrpar1_zombie_early", "npc_vj_hlrpar1_z3h", "npc_vj_hlrpar1_z3h_early", "npc_vj_hlrpar1_z4h", "npc_vj_hlrpar1_z4h_early"})
        local zombie = ents.Create(zomList)
        if ent.VJ_ID_Living then
            zombie:SetPos(ent:GetPos())
            zombie:SetAngles(ent:GetAngles())
            zombie.GodMode = true
            zombie:Spawn()
            undo.ReplaceEntity(ent, zombie)
        end
        if ent:IsPlayer() then
            ent:Spectate(OBS_MODE_CHASE)
            ent:SpectateEntity(zombie)
        end
        self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
        if self.HasGibOnDeathEffects then
            local effectData = EffectData()
            effectData:SetOrigin(ent:GetPos() + ent:OBBCenter())
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
    end
end*/
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFlinch(dmginfo, hitgroup, status)
    if status == "Init" then
        if dmginfo:GetDamage() > 30 && VJ.AnimExists(self, ACT_BIG_FLINCH) then
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
    if self.Zombie_OnDamaged then self:Zombie_OnDamaged(dmginfo, hitgroup, status) end
    if status == "Init" then
        -- Make zombies immune to DMG_NERVEGAS, based on source code
        if dmginfo:IsDamageType(DMG_NERVEGAS) then
            dmginfo:SetDamage(0)
        end
        -- Spawn a unique decal from headshots, based on source code
        if hitgroup == HITGROUP_HEAD then
            self.BloodDecal = "VJ_PARR1_Brains"
        else
            self.BloodDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red"
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        -- Have armed zombie drop pistol on death
        if self.Zombie_Type == 5 then
            self:SetBodygroup(1, 1)
            self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/weapons/w_aps.mdl", {BloodDecal = "", Pos = self:GetAttachment(self:LookupAttachment("lhand")).Pos, Ang = self:GetAngles() + Angle(0, 0, -90), Vel = "UseDamageForce", CollideSound = ""}, function(gib) gib.PhysicsSounds = true end)
        end
        if GetConVar("vj_hlr1_corpse_static"):GetInt() == 1 && VJ_CVAR_AI_ENABLED && self.HasDeathAnimation then
            self.DeathAnimationDecreaseLengthAmount = -1
            self.DeathCorpseEntityClass = "prop_vj_animatable"
        end
        if hitgroup == HITGROUP_HEAD then
            VJ.EmitSound(self, "vj_parr/par1/shared/headshot.wav", 75, 100)
        end
    elseif status == "DeathAnim" then
        if hitgroup == HITGROUP_HEAD && VJ.AnimExists(self, ACT_DIE_HEADSHOT) then
            self.AnimTbl_Death = ACT_DIE_HEADSHOT
        elseif hitgroup == HITGROUP_STOMACH && VJ.AnimExists(self, ACT_DIE_GUTSHOT) then
            self.AnimTbl_Death = ACT_DIE_GUTSHOT
        end
    elseif status == "Finish" then
        -- Reset the blood decals to default if hit in head
        self.BloodDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red"
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
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib2.mdl", {CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib3.mdl", {CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(1, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib4.mdl", {CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 2, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib5.mdl", {CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(2, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib6.mdl", {CollisionDecal = "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 3, 40))})
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
        VJ.EmitSound(self, "vj_parr/par1/shared/npc_slosh" .. math_random(1, 2) .. ".wav", self.FootstepSoundLevel, self:GetSoundPitch(self.FootStepPitch1, self.FootStepPitch2))
    end
end