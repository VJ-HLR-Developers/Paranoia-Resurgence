AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_parr/par1/npc_elektrik.mdl", "models/vj_parr/par1/npc_signal.mdl", "models/vj_parr/par1/npc_svarka.mdl", "models/vj_parr/par1/npc_worker.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
ENT.ControllerParams = {
    ThirdP_Offset = Vector(30, 25, -50),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(3, 0, 5)
}

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN_FRIENDLY"}
ENT.AlliedWithPlayerAllies = true
ENT.BecomeEnemyToPlayer = 2
ENT.HasOnPlayerSight = true

ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr1_blood_red"
ENT.BloodDecal = "VJ_PARR1_Blood_Red"
ENT.HasBloodPool = false

ENT.Behavior = VJ_BEHAVIOR_PASSIVE

ENT.HasMeleeAttack = false
ENT.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK1
ENT.MeleeAttackDamage = 25
ENT.TimeUntilMeleeAttackDamage = false

ENT.Weapon_IgnoreSpawnMenu = true

ENT.DisableFootStepSoundTimer = true

ENT.DropDeathLoot = false
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
ENT.DeathAnimationTime = false

ENT.CanTurnWhileMoving = false

ENT.CanFlinch = true
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH
ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTARM, Animation = ACT_FLINCH_LEFTARM}, {HitGroup = HITGROUP_RIGHTARM, Animation = ACT_FLINCH_RIGHTARM}, {HitGroup = HITGROUP_LEFTLEG, Animation = ACT_FLINCH_LEFTLEG}, {HitGroup = HITGROUP_RIGHTLEG, Animation = ACT_FLINCH_RIGHTLEG}}

ENT.SoundTbl_FootStep = {"vj_parr/par1/shared/npc_step1.wav", "vj_parr/par1/shared/npc_step2.wav", "vj_parr/par1/shared/npc_step3.wav", "vj_parr/par1/shared/npc_step4.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_parr/par1/shared/cbar_hitbod1.wav", "vj_parr/par1/shared/cbar_hitbod2.wav", "vj_parr/par1/shared/cbar_hitbod3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_parr/par1/weapons/melee_whoosh1.wav", "vj_parr/par1/weapons/melee_whoosh2.wav"}
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

ENT.MainSoundPitch = VJ.SET(95, 105)

local ACT_FEAR_DISPLAY;

local CurTime = CurTime
local math_random = math.random
local math_rand = math.Rand

-- Custom
ENT.Civilian_Type = 0 -- 0 = Male, 1 = Female, 2 = Par2 Paulina, 3 = Pirogov, 4 = Melee, 5 = Spetsnaz
ENT.CIvilian_WeaponModel = false
ENT.Civilian_CanHurtWalk = false
ENT.Civilian_NextMouthMove = 0
ENT.Civilian_NextMouthDistance = 0
ENT.Civilian_NextTieAnnoyanceT = 0
ENT.Civilian_NextStrafeT = 0
ENT.Civilian_ControllerAnim = 0

function ENT:OnInput(key, activator, caller, data)
    //print(key)
    if key == "step" then
        self:PlayFootstepSound()
    elseif key == "melee" then
        self:ExecuteMeleeAttack()
    elseif key == "body" then
        VJ.EmitSound(self, "vj_parr/par1/shared/bodydrop" .. math_random(1, 2) .. ".wav", 75, 100)
    elseif key == "body_knee" then
        VJ.EmitSound(self, "vj_parr/par1/shared/body_knee.wav", 75, 100)
    end
    if key == "Use" and IsValid(activator) and self:Disposition(activator) == D_LI and (self.IsGuard or !self.FollowPlayer) /*and self:GetNPCState() == NPC_STATE_IDLE*/ then
        if self.CanChatMessage then
            activator:PrintMessage(HUD_PRINTTALK, VJ.GetName(self) .. " is busy and won't follow you.")
        end
        if self.SoundTbl_Busy then
            self:PlaySoundSystem("Speech", self.SoundTbl_Busy)
        end
    end
end

function ENT:PreInit()
    if GetConVar("VJ_PARR_Hostile_Russians"):GetInt() == 1 and self.VJ_NPC_Class[1] == "CLASS_PLAYER_ALLY" and self.VJ_NPC_Class[2] == "CLASS_RUSSIAN_FRIENDLY" then
        self.VJ_NPC_Class = {"CLASS_RUSSIAN"}
        self.AlliedWithPlayerAllies = false
    end
end

function ENT:Civilian_Voice()
    self.SoundTbl_Death = {
        "vj_parr/par1/military/mil_die1.wav",
        "vj_parr/par1/military/mil_die2.wav",
        "vj_parr/par1/military/mil_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/military/mil_pain1.wav",
        "vj_parr/par1/military/mil_pain2.wav",
        "vj_parr/par1/military/mil_pain3.wav",
        "vj_parr/par1/military/mil_pain4.wav",
        "vj_parr/par1/military/mil_pain5.wav"
    }
    local pickVoice = math_random(1, 2)
    if pickVoice == 1 then
        self.SoundTbl_Idle = {
            "vj_parr/par1/npc/bunk/prof_idle1.wav",
            "vj_parr/par1/npc/bunk/prof_idle2.wav",
            "vj_parr/par1/npc/bunk/prof_idle3.wav",
            "vj_parr/par1/npc/bunk/prof_idle4.wav",
            "vj_parr/par1/npc/bunk/prof_idle5.wav",
            "vj_parr/par1/npc/bunk/prof_idle6.wav"
        }
        self.SoundTbl_CombatIdle = {
            "vj_parr/par1/npc/indust/worker0.wav",
            "vj_parr/par1/npc/indust/worker1.wav",
            "vj_parr/par1/npc/indust/worker2.wav",
            "vj_parr/par1/npc/indust/worker3.wav",
            "vj_parr/par1/npc/indust/worker4.wav",
            "vj_parr/par1/npc/indust/worker5.wav"
        }
        self.SoundTbl_OnPlayerSight = {
            "vj_parr/par1/npc/bunk/prof_hello1.wav",
            "vj_parr/par1/npc/bunk/prof_hello2.wav",
            "vj_parr/par1/npc/bunk/prof_hello3.wav"
        }
        self.SoundTbl_Alert = {
            "vj_parr/par1/npc/indust/worker0.wav",
            "vj_parr/par1/npc/indust/worker1.wav",
            "vj_parr/par1/npc/indust/worker2.wav",
            "vj_parr/par1/npc/indust/worker3.wav",
            "vj_parr/par1/npc/indust/worker4.wav",
            "vj_parr/par1/npc/indust/worker5.wav"
        }
    elseif pickVoice == 2 then
        self.SoundTbl_Idle = {
            "vj_parr/par1/npc/bunk/worker1.wav",
            "vj_parr/par1/npc/bunk/worker2.wav",
            "vj_parr/par1/npc/bunk/worker3.wav",
            "vj_parr/par1/npc/bunk/worker4.wav",
            "vj_parr/par1/npc/bunk/worker5.wav"
        }
    end
end

function ENT:Civilian_Init()
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/npc_elektrik.mdl" or myMDL == "models/vj_parr/par1/npc_worker.mdl" then
        self:SetBodygroup(1, math_random(0, 3))
    elseif myMDL == "models/vj_parr/par1/npc_signal.mdl" then
        self:SetBodygroup(1, math_random(0, 1))
    end
end

function ENT:Init()
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/npc_cooker.mdl" or myMDL == "models/vj_parr/par1/npc_elektrik.mdl" or myMDL == "models/vj_parr/par1/npc_himik.mdl" or myMDL == "models/vj_parr/par1/npc_officer.mdl" or myMDL == "models/vj_parr/par1/npc_officer_general.mdl" or myMDL == "models/vj_parr/par1/npc_scientist.mdl" or myMDL == "models/vj_parr/par1/npc_signal.mdl" or myMDL == "models/vj_parr/par1/npc_soldier.mdl" or myMDL == "models/vj_parr/par1/npc_svarka.mdl" or myMDL == "models/vj_parr/par1/npc_worker.mdl" or myMDL == "models/vj_parr/par1/cut/rammfan.mdl" or myMDL == "models/vj_parr/par1/early/v1/npc_cooker.mdl" or myMDL == "models/vj_parr/par1/early/v1/npc_soldier.mdl" or myMDL == "models/vj_parr/par1/cut/worker2.mdl" or myMDL == "models/vj_parr/par1/early/v2/npc_cooker.mdl" or myMDL == "models/vj_parr/par1/early/v2/npc_soldier.mdl" then
        self.Civilian_Type = 0
    elseif myMDL == "models/vj_parr/par1/npc_fsceint.mdl" or myMDL == "models/vj_parr/par1/npc_fsceint.mdl" or myMDL == "models/vj_parr/par1/npc_medic.mdl" then
        self.Civilian_Type = 1
    elseif myMDL == "models/vj_parr/par2/char_polina.mdl" then
        self.Civilian_Type = 2
    elseif myMDL == "models/vj_parr/par2/char_pirogov.mdl" or myMDL == "models/vj_parr/par2/early/v1/hazmat.mdl" then
        self.Civilian_Type = 3
    elseif myMDL == "models/vj_parr/par1/early/v1/npc_worker_old.mdl" then
        self.Civilian_Type = 4
    elseif myMDL == "models/vj_parr/par1/npc_soldier_alpha.mdl" or myMDL == "models/vj_parr/par1/early/v1/npc_soldier_alpha.mdl" or myMDL == "models/vj_parr/par1/early/v2/npc_soldier_alpha.mdl" then
        self.Civilian_Type = 5
    end

    ACT_FEAR_DISPLAY = util.GetActivityIDByName("ACT_FEAR_DISPLAY")

    local curTime = CurTime()
    self.Civilian_NextTieAnnoyanceT = curTime + math_rand(2, 100)
    self.Civilian_NextStrafeT = curTime + 4
    if self.Civilian_Init then self:Civilian_Init() end
    if self.Civilian_Voice then self:Civilian_Voice() end
end

function ENT:Controller_Initialize(ply, controlEnt)
    if self.Civilian_Type != 0 and self.Civilian_Type != 2 and self.Civilian_Type != 5 then return end
    ply:ChatPrint("RELOAD: Toggle scared animations")
    ply:ChatPrint("LMOUSE: Play tie annoyance (if not scared & possible)")

    self.Civilian_ControllerAnim = 0
    self.Civilian_NextTieAnnoyanceT = 0

    function controlEnt:OnKeyBindPressed(key)
        local npc = self:GetNPC()
        local curTime = CurTime()
        -- Toggle behavior setting (Idle / Alert)
        if key == IN_RELOAD then
            if npc.Civilian_ControllerAnim == 0 then
                npc.Civilian_ControllerAnim = 1
                self:GetPlayer():ChatPrint("I am scared!")
            else
                npc.Civilian_ControllerAnim = 0
                self:GetPlayer():ChatPrint("Calming down...")
            end
        elseif key == IN_ATTACK and curTime > npc.Civilian_NextTieAnnoyanceT then
            npc:PlayAnim(ACT_VM_IDLE_1, true, false)
            npc.Civilian_NextTieAnnoyanceT = curTime + 4
        end
    end
end

function ENT:TranslateActivity(act)
    -- Hurt Walking
    if self.Civilian_CanHurtWalk then
        local myHP = self:Health()
        local myMaxHP = self:GetMaxHealth()
        if act == ACT_WALK then
            if myHP <= (myMaxHP / 2.2) then
                return ACT_WALK_HURT
            end
        elseif act == ACT_RUN then
            if myHP <= (myMaxHP / 2.2) then
                return ACT_RUN_HURT
            end
        end
    end
    -- Scared animations
    local npcState = self:GetNPCState()
    if (self.Civilian_Type == 0 or self.Civilian_Type == 2 or self.Civilian_Type == 5) and ((!self.VJ_Controlled and (npcState == NPC_STATE_ALERT or npcState == NPC_STATE_COMBAT)) or (self.VJ_Controlled and self.Civilian_ControllerAnim == 1)) then
        if act == ACT_IDLE then
            return ACT_CROUCHIDLE
        elseif act == ACT_WALK then
            return ACT_WALK_SCARED
        elseif act == ACT_RUN then
            return ACT_RUN_SCARED
        end
        -- Some NPCs don't have scared animations
    elseif (self.Civilian_Type == 1 or self.Civilian_Type == 3) and (npcState == NPC_STATE_ALERT or npcState == NPC_STATE_COMBAT) then
        if act == ACT_IDLE then
            return ACT_IDLE
        end
    end
    if act == ACT_IDLE and self.IsGuard and npcState == NPC_STATE_IDLE and VJ.AnimExists(self, ACT_IDLE_RELAXED) then
        return ACT_IDLE_RELAXED
    end
    return self.BaseClass.TranslateActivity(self, act)
end

function ENT:SCHEDULE_IDLE_STAND()
    if !self.BaseClass.SCHEDULE_IDLE_STAND(self) then return end
    -- Tie annoyance
    local curTime = CurTime()
    if self.Civilian_Type == 0 and curTime > self.Civilian_NextTieAnnoyanceT and self:GetNPCState() <= NPC_STATE_IDLE then
        if math_random(1, 8) == 1 then
            self:PlayAnim(ACT_VM_IDLE_1, true, false)
        end
        self.Civilian_NextTieAnnoyanceT = curTime + math_rand(25, 100)
    end
    return true
end

function ENT:OnCreateSound(sdData, sdFile)
    local curTime = CurTime()
    self.Civilian_NextMouthMove = curTime + SoundDuration(sdFile)
end

function ENT:OnIdleDialogue(ent, status, statusInfo)
    -- Don't talk to PKM Emplacements
    local entClass = ent:GetClass()
    if status == "CheckEnt" and (entClass == "npc_vj_hlrpar1_clo_pkm" or entClass == "npc_vj_hlrpar1_rus_pkm" or entClass == "npc_vj_hlrpar1_sab_pkm" or entClass == "npc_vj_hlrpar1_ter_pkm" or entClass == "npc_vj_hlrpar2_clo_pkm" or entClass == "npc_vj_hlrpar2_rus_pkm") then
        return true
    end
end

local wrenchSds = {"vj_parr/par1/shared/cbar_hitbod1.wav", "vj_parr/par1/shared/cbar_hitbod2.wav", "vj_parr/par1/shared/cbar_hitbod3.wav"}
local axeSds = {"vj_parr/par1/weapons/machete_hit1.wav", "vj_parr/par1/weapons/machete_hit2.wav", "vj_parr/par1/weapons/machete_hit3.wav", "vj_parr/par1/weapons/machete_hit4.wav"}
--
function ENT:OnThink()
    -- If we're guarding then don't follow player
    if !self.IsGuard and !self.FollowPlayer then
        self.FollowPlayer = true
    elseif self.IsGuard and self.FollowPlayer then
        self.FollowPlayer = false
        self:ResetFollowBehavior()
    end
    -- Mouth animation when talking
    local curTime = CurTime()
    if curTime < self.Civilian_NextMouthMove then
        if self.Civilian_NextMouthDistance == 0 then
            self.Civilian_NextMouthDistance = math_random(10, 70)
        else
            self.Civilian_NextMouthDistance = 0
        end
        self:SetPoseParameter("mouth_move", self.Civilian_NextMouthDistance)
    else
        self:SetPoseParameter("mouth_move", 0)
    end
    if self.Civilian_Type != 4 and self:GetModel() != "models/vj_parr/par1/cut/worker2.mdl" then return end
    -- Handle weapon body group changing
    local bodyGroup = self:GetBodygroup(3)
    local myMDL = self:GetModel()
    if self.Civilian_LastBodyGroup != bodyGroup then
        self.Civilian_LastBodyGroup = bodyGroup
        if (self.Civilian_Type == 4 and bodyGroup == 0) or (myMDL == "models/vj_parr/par1/cut/worker2.mdl" and bodyGroup == 1) then -- Axe
            self.HasMeleeAttack = true
            self.CIvilian_WeaponModel = "models/vj_parr/par1/weapons/early/w_axe.mdl"
            if self.Civilian_Type == 4 then self.Weapon_UnarmedBehavior = false end
            self.SoundTbl_MeleeAttackExtra = axeSds
        elseif (self.Civilian_Type == 4 and bodyGroup == 1) or (myMDL == "models/vj_parr/par1/cut/worker2.mdl" and bodyGroup == 2) then -- Wrench
            self.HasMeleeAttack = true
            self.CIvilian_WeaponModel = "models/vj_parr/par1/weapons/early/w_wrench.mdl"
            if self.Civilian_Type == 4 then self.Weapon_UnarmedBehavior = false end
            self.SoundTbl_MeleeAttackExtra = wrenchSds
        elseif (self.Civilian_Type == 4 and bodyGroup == 2) or (myMDL == "models/vj_parr/par1/cut/worker2.mdl" and bodyGroup == 0) then
            self.HasMeleeAttack = false
            self.CIvilian_WeaponModel = false
            if self.Civilian_Type == 4 then self.Weapon_UnarmedBehavior = true end
            self.SoundTbl_MeleeAttackExtra = wrenchSds
        end
    end
    if self.Civilian_OnThink then self:Civilian_OnThink() end
end

local animStrafing = {ACT_STRAFE_RIGHT, ACT_STRAFE_LEFT}
--
function ENT:Civilian_OnThink()
    if self.IsGuard or self.Dead or self.Civilian_Type != 4 then return end
    local curTime = CurTime()
    local ene = self.EnemyData.Target
    if IsValid(ene) and self.AttackAnimTime > curTime and !self.VJ_Controlled and curTime > self.Civilian_NextStrafeT and !self:IsMoving() and self:GetPos():Distance(ene:GetPos()) < 100 then
        self:StopMoving()
        self:PlayAnim(animStrafing, true, false, false)
        self.Civilian_NextStrafeT = curTime + 8
    end
end

function ENT:OnAlert(ent)
    if self.VJ_Controlled or self.Civilian_Type != 0 then return end
    if math_random(1, 2) == 1 and ent:GetPos():Distance(self:GetPos()) >= 300 then
        self:PlayAnim(ACT_FEAR_DISPLAY, true, false, true)
    end
end

function ENT:MeleeAttackTraceDirection()
    return self:GetForward()
end

function ENT:OnBleed(dmginfo, hitgroup)
    -- Spawn a unique decal from headshots, based on source code
    if hitgroup == HITGROUP_HEAD or hitgroup == 8 then
        self.BloodDecal = "VJ_PARR1_Brains"
    else
        self.BloodDecal = (self.VJ_PARR2_NPC and "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red"
    end
end

function ENT:OnDamaged(dmginfo, hitgroup, status)
    if status == "Init" then
        -- Make NPCs immune to DMG_NERVEGAS if they're wearing a gasmask, based on source code
        local myMDL = self:GetModel()
        local myBG = self:GetBodygroup(1)
        if (myMDL == "models/vj_parr/par1/npc_worker.mdl" and myBG == 3)
            or (myMDL == "models/vj_parr/par1/cut/worker2.mdl" and myBG == 2)
            or (myMDL == "models/vj_parr/par1/early/v1/npc_worker_old.mdl" and myBG == 0)
            or myMDL == "models/vj_parr/par1/npc_himik.mdl"
            or ((myMDL == "models/vj_parr/par1/npc_soldier.mdl" or myMDL == "models/vj_parr/par1/early/v1/npc_soldier.mdl" or myMDL == "models/vj_parr/par1/early/v2/npc_soldier.mdl") and myBG == 8)
            or myMDL == "models/vj_parr/par2/char_pirogov.mdl" then
            if dmginfo:IsDamageType(DMG_NERVEGAS) then
                dmginfo:SetDamage(0)
            end
        end
        -- If we're wearing a helmet, create rico FX when hit
        if ((myMDL == "models/vj_parr/par1/npc_soldier_alpha.mdl" or myMDL == "models/vj_parr/par1/early/v1/npc_soldier_alpha.mdl" or myMDL == "models/vj_parr/par1/early/v2/npc_soldier_alpha.mdl") and myBG != 5)
            or (myMDL == "models/vj_parr/par1/early/v1/npc_worker_old.mdl" and self:GetBodygroup(2) != 1) then
            if hitgroup == 8 and dmginfo:GetDamagePosition() != vec then
                self.HasBloodParticle = false -- Disable blood particles temporarily when shot at the helmet
                local rico = EffectData()
                rico:SetOrigin(dmginfo:GetDamagePosition())
                rico:SetScale(4) -- Size
                rico:SetMagnitude(2) -- Effect type | 1 = Animated | 2 = Basic
                util.Effect("VJ_PARR_Rico", rico)
            else
                self.HasBloodParticle = true
            end
        else
            -- Make this custom hitgroup use same scale as head hitgroup if we're not wearing a helmet
            if hitgroup == 8 then
                dmginfo:SetDamage(dmginfo:GetBaseDamage())
                dmginfo:ScaleDamage(3)
            end
        end
    end
end

function ENT:OnFlinch(dmginfo, hitgroup, status)
    if status == "Init" then
        if dmginfo:GetDamage() > 30 and VJ.AnimExists(self, ACT_BIG_FLINCH) then
            self.FlinchChance = 6
            self.AnimTbl_Flinch = ACT_BIG_FLINCH
        else
            self.FlinchChance = 14
            self.AnimTbl_Flinch = ACT_SMALL_FLINCH
        end
    end
end

function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        if GetConVar("vj_hlr1_corpse_static"):GetInt() == 1 and VJ_CVAR_AI_ENABLED and self.HasDeathAnimation then
            if GetConVar("VJ_PARR_DropWeapon"):GetInt() == 0 then self.CIvilian_WeaponModel = false end
            self.DeathAnimationDecreaseLengthAmount = -1
            self.DeathCorpseEntityClass = "prop_vj_animatable"
            VJ.HLR_StaticCorpseCheck(self)
        end
        if hitgroup == HITGROUP_HEAD or hitgroup == 8 then
            VJ.EmitSound(self, "vj_parr/par1/shared/headshot.wav", 75, 100)
        end
        if (hitgroup == HITGROUP_HEAD or hitgroup == 8) and VJ.AnimExists(self, ACT_DIE_HEADSHOT) then
            self.AnimTbl_Death = ACT_DIE_HEADSHOT
        elseif hitgroup == HITGROUP_STOMACH and VJ.AnimExists(self, ACT_DIE_GUTSHOT) then
            self.AnimTbl_Death = ACT_DIE_GUTSHOT
        end
        local myMDL = self:GetModel()
        if (self.Civilian_Type == 4 or myMDL == "models/vj_parr/par1/cut/worker2.mdl") and self.CIvilian_WeaponModel then
            if myMDL == "models/vj_parr/par1/cut/worker2.mdl" then
                self:SetBodygroup(3, 0)
            else
                self:SetBodygroup(3, 2)
            end
            self:CreateGibEntity("obj_vj_gib", self.CIvilian_WeaponModel, {Pos = self:GetAttachment(self:LookupAttachment("rhand")).Pos, Ang = self:GetAngles(), Vel = "UseDamageForce", CollideSound = "", CollisionDecal = false}, function(gib) gib.PhysicsSounds = true end)
        end
    elseif status == "Finish" then
        -- Reset the blood decals to default if hit in head
        self.BloodDecal = (self.VJ_PARR2_NPC and "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red"
    end
end

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
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib1.mdl", {CollisionDecal = (self.VJ_PARR2_NPC and "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib2.mdl", {CollisionDecal = (self.VJ_PARR2_NPC and "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 1, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib3.mdl", {CollisionDecal = (self.VJ_PARR2_NPC and "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(1, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib4.mdl", {CollisionDecal = (self.VJ_PARR2_NPC and "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 2, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib5.mdl", {CollisionDecal = (self.VJ_PARR2_NPC and "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(2, 0, 40))})
    self:CreateGibEntity("obj_vj_gib", "models/vj_parr/par1/gibs/hgib6.mdl", {CollisionDecal = (self.VJ_PARR2_NPC and "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red", CollideSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 3, 40))})
    self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
    return true, {AllowSound = false}
end

local gibs = {"models/vj_parr/par1/gibs/hgib1.mdl", "models/vj_parr/par1/gibs/hgib2.mdl", "models/vj_parr/par1/gibs/hgib3.mdl", "models/vj_parr/par1/gibs/hgib4.mdl", "models/vj_parr/par1/gibs/hgib5.mdl", "models/vj_parr/par1/gibs/hgib6.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    VJ.HLR_ApplyCorpseSystem(self, corpse, gibs, {CollisionSound = gibsCollideSd, ExpSound = "vj_parr/par1/shared/bodysplat.wav", SplatDecal = "VJ_PARR1_Blood_Red_Large"})
end

function ENT:OnFootstepSound(moveType, sdFile)
    if !self:OnGround() then return end
    local watLevel = self:WaterLevel()
    if watLevel > 0 and watLevel < 3 then
        VJ.EmitSound(self, "vj_parr/par1/shared/npc_slosh" .. math_random(1, 2) .. ".wav", self.FootstepSoundLevel, self:GetSoundPitch(self.FootstepSoundPitch))
    end
end