AddCSLuaFile("shared.lua")
include("shared.lua")

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
ENT.BloodParticle = "vj_parr_blood_red"
ENT.BloodDecal = "VJ_PARR_Blood_Red"
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
ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIE_GUTSHOT, ACT_DIE_HEADSHOT, ACT_DIESIMPLE}

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
ENT.Zombie_Type = 0 -- 0 = Zombie, 1 = Zombie Mutant, 2 = Zombie 3-Armed Mutant, 3 = Zombie Spider Mutant, 4 = Zombie Ceiling Mutant, 5 = Armed Zombie

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
function ENT:Zombie_Init()
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
    self:SetBodygroup(1, math_random(0, 5))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/zombie_slow.mdl" or myMDL == "models/vj_parr/par1/zombie_slow2.mdl" or myMDL == "models/vj_parr/par1/zombie_slow2a.mdl" or myMDL == "models/vj_parr/par1/zombie_slow2b.mdl" then
        self.Zombie_Type = 0
    elseif myMDL == "models/vj_parr/par1/zombie.mdl" then
        self.Zombie_Type = 1
    elseif myMDL == "models/vj_parr/par1/z_3h.mdl" then
        self.Zombie_Type = 2
    elseif myMDL == "models/vj_parr/par1/spider.mdl" or myMDL == "models/vj_parr/par1/early/spider_v1.mdl" or myMDL == "models/vj_parr/par1/early/spider_v2.mdl" then
        self.Zombie_Type = 3
    elseif myMDL == "models/vj_parr/par1/zombie_c.mdl" then
        self.Zombie_Type = 4
    elseif myMDL == "models/vj_parr/par1/cut/zombie_slow_armed.mdl" then
        self.Zombie_Type = 5
    end
    self:SetSurroundingBounds(Vector(60, 60, 90), Vector(-60, -60, 0))
    if self.Zombie_Init then self:Zombie_Init() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnMeleeAttack(status, enemy)
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
function ENT:OnFlinch(dmginfo, hitgroup, status)
    if status == "Init" then
        if dmginfo:GetDamage() > 30 then
            self.FlinchChance = 8
            self.AnimTbl_Flinch = ACT_BIG_FLINCH
        else
            self.FlinchChance = 16
            self.AnimTbl_Flinch = ACT_SMALL_FLINCH
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        if self.Zombie_Type == 5 then -- Have armed zombie drop pistol on death
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
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib2.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib3.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(1, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib4.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 2, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib5.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(2, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib6.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 3, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_b_bone.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 50))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_b_gib.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(1, 1, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_guts.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(2, 1, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_hmeat.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 45))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_lung.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 45))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_skull.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 60))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_legbone.mdl", {CollisionDecal = "VJ_PARR_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 15))})
    self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
    return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    VJ.HLR_ApplyCorpseSystem(self, corpse, nil, {CollisionSound = gibsCollideSd})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFootstepSound(moveType, sdFile)
    if !self:OnGround() then return end
    local watLevel = self:WaterLevel()
    if watLevel > 0 && watLevel < 3 then
        VJ.EmitSound(self, "vj_parr/par1/shared/npc_slosh" .. math_random(1, 2) .. ".wav", self.FootstepSoundLevel, self:GetSoundPitch(self.FootStepPitch1, self.FootStepPitch2))
    end
end