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
    ThirdP_Offset = Vector(10, 0, -30),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(5, 0, 5),
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_RUSSIAN"}
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr_blood_red"
ENT.BloodDecal = "VJ_PARR_Blood_Red"
ENT.HasBloodPool = false
ENT.Behavior = VJ_BEHAVIOR_PASSIVE
ENT.BecomeEnemyToPlayer = 2
ENT.DropDeathLoot = false
ENT.HasOnPlayerSight = true
ENT.HasMeleeAttack = false
ENT.DisableFootStepSoundTimer = true
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
ENT.DeathAnimationTime = false
ENT.CanTurnWhileMoving = false

ENT.CanFlinch = true
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH
ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTLEG, Animation = ACT_FLINCH_LEFTLEG}, {HitGroup = HITGROUP_RIGHTLEG, Animation = ACT_FLINCH_RIGHTLEG}}

ENT.SoundTbl_FootStep = {"vj_parr/par1/shared/npc_step1.wav", "vj_parr/par1/shared/npc_step2.wav", "vj_parr/par1/shared/npc_step3.wav", "vj_parr/par1/shared/npc_step4.wav"}
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

ENT.MainSoundPitch = VJ.SET(95, 105)

local ACT_FEAR_DISPLAY;

local CurTime = CurTime
local math_random = math.random
local math_rand = math.Rand

-- Custom
ENT.Civilian_Type = 0 -- 0 = Male, 1 = Female
ENT.Civilian_NextMouthMove = 0
ENT.Civilian_NextMouthDistance = 0
ENT.Civilian_NextTieAnnoyanceT = 0
ENT.Civilian_ControllerAnim = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Init()
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
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/npc_elektrik.mdl" or myMDL == "models/vj_parr/par1/npc_worker.mdl" then
        self:SetBodygroup(1, math_random(0, 3))
    elseif myMDL == "models/vj_parr/par1/npc_signal.mdl" then
        self:SetBodygroup(1, math_random(0, 1))
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    ACT_FEAR_DISPLAY = util.GetActivityIDByName("ACT_FEAR_DISPLAY")
    local curTime = CurTime()
    self.Civilian_NextTieAnnoyanceT = curTime + math_rand(2, 100)
    if self.Civilian_Init then self:Civilian_Init() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply, controlEnt)
    if self.Civilian_Type != 0 then return end
    ply:ChatPrint("RELOAD: Toggle scared animations")
    ply:ChatPrint("LMOUSE: Play tie annoyance (if not scared & possible)")

    self.Civilian_ControllerAnim = 0
    self.Civilian_NextTieAnnoyanceT = 0

    function controlEnt:OnKeyBindPressed(key)
        local npc = self.VJCE_NPC
        -- Toggle behavior setting (Idle / Alert)
        if key == IN_RELOAD then
            if npc.Civilian_ControllerAnim == 0 then
                npc.Civilian_ControllerAnim = 1
                self.VJCE_Player:ChatPrint("I am scared!")
            else
                npc.Civilian_ControllerAnim = 0
                self.VJCE_Player:ChatPrint("Calming down...")
            end
            local curTime = CurTime()
        elseif key == IN_ATTACK && curTime > npc.Civilian_NextTieAnnoyanceT then
            npc:PlayAnim(ACT_VM_IDLE_1, true, false)
            npc.Civilian_NextTieAnnoyanceT = curTime + 4
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
    //print(key)
    if key == "step" then
        self:PlayFootstepSound()
    elseif key == "body" then
        VJ.EmitSound(self, "vj_parr/par1/shared/bodydrop" .. math_random(1, 2) .. ".wav", 75, 100)
    elseif key == "body_knee" then
        VJ.EmitSound(self, "vj_parr/par1/shared/body_knee.wav", 75, 100)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    -- Scared animations
    local npcState = self:GetNPCState()
    if self.Civilian_Type == 0 && ((!self.VJ_IsBeingControlled && (npcState == NPC_STATE_ALERT or npcState == NPC_STATE_COMBAT)) or (self.VJ_IsBeingControlled && self.Civilian_ControllerAnim == 1)) then
        if act == ACT_IDLE then
            return ACT_CROUCHIDLE
        elseif act == ACT_WALK then
            return ACT_WALK_SCARED
        elseif act == ACT_RUN then
            return ACT_RUN_SCARED
        end
    elseif self.Civilian_Type == 1 && (npcState == NPC_STATE_ALERT or npcState == NPC_STATE_COMBAT) then
        if act == ACT_IDLE then
            return ACT_IDLE
        end
    end
    return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SCHEDULE_IDLE_STAND()
    if !self.BaseClass.SCHEDULE_IDLE_STAND(self) then return end
    -- Tie annoyance
    local curTime = CurTime()
    if self.Civilian_Type == 0 && curTime > self.Civilian_NextTieAnnoyanceT && self:GetNPCState() <= NPC_STATE_IDLE then
        if math_random(1, 8) == 1 then
            self:PlayAnim(ACT_VM_IDLE_1, true, false)
        end
        self.Civilian_NextTieAnnoyanceT = curTime + math_rand(25, 100)
    end
    return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent)
    if self.VJ_IsBeingControlled or self.Civilian_Type != 0 then return end
    if math_random(1, 2) == 1 && ent:GetPos():Distance(self:GetPos()) >= 300 then
        self:PlayAnim(ACT_FEAR_DISPLAY, true, false, true)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateSound(sdData, sdFile)
    local curTime = CurTime()
    self.Civilian_NextMouthMove = curTime + SoundDuration(sdFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        if GetConVar("vj_hlr1_corpse_static"):GetInt() == 1 && VJ_CVAR_AI_ENABLED && self.HasDeathAnimation then
            self.DeathAnimationDecreaseLengthAmount = -1
            self.DeathCorpseEntityClass = "prop_vj_animatable"
        end
    elseif status == "DeathAnim" then
        if hitgroup == HITGROUP_HEAD then
            self.AnimTbl_Death = ACT_DIE_HEADSHOT
        elseif hitgroup == HITGROUP_STOMACH then
            self.AnimTbl_Death = ACT_DIE_GUTSHOT
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