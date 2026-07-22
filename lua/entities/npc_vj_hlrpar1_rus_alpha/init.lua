AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/vj_parr/par1/soldier_alpha.mdl", "models/vj_parr/par1/soldier_alpha_pistol.mdl"}
ENT.StartHealth = 200
ENT.HullType = HULL_HUMAN
ENT.ControllerParams = {
    ThirdP_Offset = Vector(30, 25, -50),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(3, 0, 5),
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr_blood_red"
ENT.BloodDecal = "VJ_PARR_Blood_Red"
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN"}
ENT.AlliedWithPlayerAllies = true
ENT.BecomeEnemyToPlayer = 2
ENT.HasOnPlayerSight = true

-- Melee Attack
ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK1
ENT.MeleeAttackDamage = 15
ENT.TimeUntilMeleeAttackDamage = false

-- Grenade Attack
ENT.HasGrenadeAttack = true
ENT.GrenadeAttackEntity = "obj_vj_hlrpar1_grenade"
ENT.AnimTbl_GrenadeAttack = ACT_SPECIAL_ATTACK1
ENT.GrenadeAttackAttachment = "rhand"
ENT.GrenadeAttackThrowTime = false
ENT.NextGrenadeAttackTime = VJ.SET(10, 12)
ENT.GrenadeAttackChance = 3

-- Weapon Attack
ENT.Weapon_IgnoreSpawnMenu = true
ENT.Weapon_Strafe = false
ENT.AnimTbl_WeaponAttackGesture = false
ENT.AnimTbl_WeaponAttackSecondary = ACT_RANGE_ATTACK2
ENT.Weapon_SecondaryFireTime = false

ENT.CanTurnWhileMoving = false
ENT.AnimTbl_DamageAllyResponse = ACT_SIGNAL3
ENT.AnimTbl_CallForHelp = ACT_SIGNAL1
ENT.AnimTbl_TakingCover = ACT_CROUCHIDLE
ENT.CanFlinch = true
ENT.AnimTbl_Flinch = ACT_SMALL_FLINCH
ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTARM, Animation = ACT_FLINCH_LEFTARM}, {HitGroup = HITGROUP_RIGHTARM, Animation = ACT_FLINCH_RIGHTARM}, {HitGroup = HITGROUP_LEFTLEG, Animation = ACT_FLINCH_LEFTLEG}, {HitGroup = HITGROUP_RIGHTLEG, Animation = ACT_FLINCH_RIGHTLEG}}

ENT.DropDeathLoot = false
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIE_GUTSHOT, ACT_DIE_HEADSHOT, ACT_DIESIMPLE}

-- Sounds
ENT.DisableFootStepSoundTimer = true

ENT.SoundTbl_FootStep = {"vj_parr/par1/shared/npc_step1.wav", "vj_parr/par1/shared/npc_step2.wav", "vj_parr/par1/shared/npc_step3.wav", "vj_parr/par1/shared/npc_step4.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_parr/par1/shared/cbar_hitbod1.wav", "vj_parr/par1/shared/cbar_hitbod2.wav", "vj_parr/par1/shared/cbar_hitbod3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_parr/par1/weapons/melee_whoosh1.wav", "vj_parr/par1/weapons/melee_whoosh2.wav"}
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

ENT.MainSoundPitch = VJ.SET(95, 105)

-- Custom
ENT.Soldier_Type = 0 -- 0 = Spetsnaz, 1 = Army, 2 = Terrorist, 3 = Clone, 4 = Saboteur
ENT.Soldier_WepBG = 0
ENT.Soldier_WepBGRemove = 0
ENT.Soldier_PistolAnims = false
ENT.Soldier_CanHurtWalk = true
ENT.Soldier_NextMouthMove = 0
ENT.Soldier_NextMouthDistance = 0
ENT.Soldier_NextStrafeT = 0
ENT.Soldier_NextRunT = 0

local CurTime = CurTime
local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
    //print(key)
    if key == "step" then
        self:PlayFootstepSound()
    elseif key == "melee" then
        self:ExecuteMeleeAttack()
    elseif key == "grenade" then
        timer.Adjust("attack_grenade_start" .. self:EntIndex(), 0)
    elseif key == "shoot" then
        local wep = self:GetActiveWeapon()
        if IsValid(wep) then
            wep:NPCShoot_Primary()
        end
    elseif key == "shoot_grenade" then -- Event-based secondary attack
        local wep = self:GetActiveWeapon()
        if IsValid(wep) then
            wep:NPC_SecondaryFire()
        end
    elseif key == "body_knee" then
        VJ.EmitSound(self, "vj_parr/par1/shared/body_knee.wav", 75, 100)
    elseif key == "body" then
        VJ.EmitSound(self, "vj_parr/par1/shared/bodydrop" .. math_random(1, 4) .. ".wav", 75, 100)
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
function ENT:Soldier_Init()
    self.SoundTbl_Idle = {
        "vj_parr/par1/alpha/alpha_clear0.wav",
        "vj_parr/par1/alpha/alpha_clear1.wav",
        "vj_parr/par1/alpha/alpha_clear2.wav",
        "vj_parr/par1/alpha/alpha_clear3.wav",
        "vj_parr/par1/alpha/alpha_clear4.wav",
        "vj_parr/par1/alpha/alpha_idle0.wav",
        "vj_parr/par1/alpha/alpha_idle1.wav",
        "vj_parr/par1/alpha/alpha_idle2.wav",
        "vj_parr/par1/alpha/alpha_idle3.wav",
        "vj_parr/par1/alpha/alpha_idle4.wav",
        "vj_parr/par1/alpha/alpha_idle5.wav",
        "vj_parr/par1/alpha/alpha_idle6.wav",
        "vj_parr/par1/alpha/alpha_idle7.wav",
        "vj_parr/par1/alpha/alpha_idle8.wav",
        "vj_parr/par1/alpha/alpha_idle9.wav"
    }
    self.SoundTbl_IdleDialogue = {
        "vj_parr/par1/alpha/alpha_ok0.wav",
        "vj_parr/par1/alpha/alpha_ok1.wav",
        "vj_parr/par1/alpha/alpha_ok3.wav",
        "vj_parr/par1/alpha/alpha_ok4.wav",
        "vj_parr/par1/alpha/alpha_ok5.wav",
        "vj_parr/par1/alpha/alpha_ok6.wav"
    }
    self.SoundTbl_IdleDialogueAnswer = {
        "vj_parr/par1/alpha/alpha_yes0.wav",
        "vj_parr/par1/alpha/alpha_yes1.wav",
        "vj_parr/par1/alpha/alpha_yes2.wav",
        "vj_parr/par1/alpha/alpha_yes3.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/alpha/alpha_enemy1.wav",
        "vj_parr/par1/alpha/alpha_enemy2.wav",
        "vj_parr/par1/alpha/alpha_enemy3.wav"
    }
    self.SoundTbl_ReceiveOrder = {
        "vj_parr/par1/alpha/alpha_yes0.wav",
        "vj_parr/par1/alpha/alpha_yes1.wav",
        "vj_parr/par1/alpha/alpha_yes2.wav",
        "vj_parr/par1/alpha/alpha_yes3.wav"
    }
    self.SoundTbl_Investigate =
        "vj_parr/par1/alpha/alpha_wait0.wav"

    self.SoundTbl_Alert = {
        "vj_parr/par1/alpha/alpha_enemy1.wav",
        "vj_parr/par1/alpha/alpha_enemy2.wav",
        "vj_parr/par1/alpha/alpha_enemy3.wav"
    }
    self.SoundTbl_KilledEnemy = {
        "vj_parr/par1/alpha/alpha_enemydown0.wav",
        "vj_parr/par1/alpha/alpha_enemydown1.wav",
        "vj_parr/par1/alpha/alpha_enemydown2.wav",
        "vj_parr/par1/alpha/alpha_enemydown3.wav",
        "vj_parr/par1/alpha/alpha_enemydown4.wav"
    }
    self.SoundTbl_GrenadeAttack = {
        "vj_parr/par1/alpha/alpha_grenade0.wav",
        "vj_parr/par1/alpha/alpha_grenade1.wav",
        "vj_parr/par1/alpha/alpha_grenade2.wav",
        "vj_parr/par1/alpha/alpha_grenade3.wav",
        "vj_parr/par1/alpha/alpha_grenade4.wav"
    }
    self.SoundTbl_GrenadeSight = {
        "vj_parr/par1/alpha/alpha_grenade0.wav",
        "vj_parr/par1/alpha/alpha_grenade1.wav",
        "vj_parr/par1/alpha/alpha_grenade2.wav",
        "vj_parr/par1/alpha/alpha_grenade3.wav",
        "vj_parr/par1/alpha/alpha_grenade4.wav"
    }
    self.SoundTbl_AllyDeath = {
        "vj_parr/par1/alpha/alpha_teammatedown1.wav",
        "vj_parr/par1/alpha/alpha_teammatedown2.wav",
        "vj_parr/par1/alpha/alpha_teammatedown3.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/alpha/alpha_die1.wav",
        "vj_parr/par1/alpha/alpha_die2.wav",
        "vj_parr/par1/alpha/alpha_die3.wav",
        "vj_parr/par1/alpha/alpha_die4.wav",
        "vj_parr/par1/alpha/alpha_die5.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/alpha/alpha_pain1.wav",
        "vj_parr/par1/alpha/alpha_pain2.wav",
        "vj_parr/par1/alpha/alpha_pain3.wav",
        "vj_parr/par1/alpha/alpha_pain4.wav",
        "vj_parr/par1/alpha/alpha_pain5.wav",
        "vj_parr/par1/alpha/alpha_pain6.wav"
    }
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/soldier_alpha_pistol.mdl" or myMDL == "models/vj_parr/par1/early/v2/soldier_alpha_pistol.mdl" then
        self:SetSkin(math_random(0, 2))
        self:SetBodygroup(1, math_random(0, 6))
    elseif myMDL == "models/vj_parr/par1/early/soldier_alpha_pistol.mdl" then
        self:SetSkin(math_random(0, 2))
        self:SetBodygroup(0, math_random(0, 1))
        self:SetBodygroup(1, math_random(0, 7))
    elseif myMDL == "models/vj_parr/par1/early/soldier_alpha.mdl" then
        self:SetBodygroup(0, math_random(0, 1))
        self:SetBodygroup(1, math_random(0, 9))
    else
        self:SetBodygroup(1, math_random(0, 7))
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/soldier_alpha.mdl" or myMDL == "models/vj_parr/par1/early/soldier_alpha.mdl" or myMDL == "models/vj_parr/par1/early/v2/soldier_alpha.mdl" then
        self.Soldier_Type = 0
        self.Soldier_WepBG = 2
        self.Soldier_WepBGRemove = 3
        self:SetBodygroup(self.Soldier_WepBG, math_random(0, 2))
    elseif myMDL == "models/vj_parr/par1/soldier_alpha_pistol.mdl" or myMDL == "models/vj_parr/par1/early/soldier_alpha_pistol.mdl" or myMDL == "models/vj_parr/par1/early/v2/soldier_alpha_pistol.mdl" then
        self.Soldier_Type = 0
        self.Soldier_WepBG = 2
        self.Soldier_WepBGRemove = 1
        self.Soldier_PistolAnims = true
    elseif myMDL == "models/vj_parr/par1/cut/general_pistol.mdl" then
        self.Soldier_Type = 0
        self.Soldier_WepBG = 1
        self.Soldier_WepBGRemove = 1
        self.Soldier_PistolAnims = true
    elseif myMDL == "models/vj_parr/par1/soldier.mdl" or myMDL == "models/vj_parr/par1/early/soldier.mdl" or myMDL == "models/vj_parr/par1/early/v2/soldier.mdl" or myMDL == "models/vj_parr/par1/cut/soldier_gru.mdl" then
        self.Soldier_Type = 1
        self.Soldier_WepBG = 2
        self.Soldier_WepBGRemove = 1
    elseif myMDL == "models/vj_parr/par1/cut/soldier_beret.mdl" then
        self.Soldier_Type = 1
        self.Soldier_WepBG = 1
        self.Soldier_WepBGRemove = 1
    elseif myMDL == "models/vj_parr/par1/terror.mdl" or myMDL == "models/vj_parr/par1/early/terror_old.mdl" then
        self.Soldier_Type = 2
        self.Soldier_WepBG = 2
        self.Soldier_WepBGRemove = 2
        self:SetBodygroup(self.Soldier_WepBG, math_random(0, 1))
    elseif myMDL == "models/vj_parr/par1/cut/terror_shahid.mdl" then
        self.Soldier_Type = 2
        self.Soldier_WepBG = 1
        self.Soldier_WepBGRemove = 2
        self:SetBodygroup(self.Soldier_WepBG, math_random(0, 1))
    elseif myMDL == "models/vj_parr/par1/soldier_clon.mdl" or myMDL == "models/vj_parr/par1/soldier_clon_bio.mdl" or myMDL == "models/vj_parr/par1/soldier_clon_heavy.mdl" or myMDL == "models/vj_parr/par1/early/soldier_clon_heavy.mdl" or myMDL == "models/vj_parr/par2/monster_clonsoldier.mdl" or myMDL == "models/vj_parr/par2/v1/monster_clonsoldier.mdl" then
        self.Soldier_Type = 3
        self.Soldier_WepBG = 2
        self.Soldier_WepBGRemove = 2
        self:SetBodygroup(self.Soldier_WepBG, math_random(0, 1))
    elseif myMDL == "models/vj_parr/par1/early/soldier_colba.mdl" then
        self.Soldier_Type = 3
        self.Soldier_WepBG = 1
        self.Soldier_WepBGRemove = 2
        self:SetBodygroup(self.Soldier_WepBG, math_random(0, 1))
    elseif myMDL == "models/vj_parr/par1/diversant.mdl" then
        self.Soldier_Type = 4
        self.Soldier_WepBG = 3
        self.Soldier_WepBGRemove = 2
        self:SetBodygroup(self.Soldier_WepBG, math_random(0, 1))
    elseif myMDL == "models/vj_parr/par1/cut/blackop.mdl" then
        self.Soldier_Type = 4
        self.Soldier_WepBG = 2
        self.Soldier_WepBGRemove = 1
    elseif myMDL == "models/vj_parr/par1/diversant_pistol.mdl" then
        self.Soldier_Type = 4
        self.Soldier_WepBG = 3
        self.Soldier_WepBGRemove = 1
        self.Soldier_PistolAnims = true
    end
    self.Soldier_NextStrafeT = CurTime() + 4
    if self.Soldier_Init then self:Soldier_Init() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateSound(sdData, sdFile)
    if VJ.HasValue(self.SoundTbl_Breath, sdFile) then return end
    local curTime = CurTime()
    self.Soldier_NextMouthMove = curTime + SoundDuration(sdFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    -- Hurt Walking
    if self.Soldier_CanHurtWalk then
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
    if act == ACT_IDLE then
        if self.Alerted && self:GetWeaponState() != VJ.WEP_STATE_HOLSTERED && IsValid(self:GetActiveWeapon()) then
            return self.AnimationTranslations[ACT_IDLE_ANGRY] or ACT_IDLE_ANGRY
        end
    end
    return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAnimationTranslations(wepHoldType)
    local bodyGroup = self.Soldier_LastBodyGroup

    self.AnimationTranslations[ACT_IDLE] = ACT_IDLE
    self.AnimationTranslations[ACT_IDLE_ANGRY] = ACT_IDLE_ANGRY
    self.AnimationTranslations[ACT_COVER_LOW] = ACT_CROUCHIDLE
    self.AnimationTranslations[ACT_WALK_AGITATED] = ACT_WALK_AGITATED
    self.AnimationTranslations[ACT_WALK_CROUCH] = ACT_WALK_AGITATED
    self.AnimationTranslations[ACT_RUN_AGITATED] = VJ.PICK({ACT_RUN, ACT_RUN_AGITATED})
    self.AnimationTranslations[ACT_RUN_CROUCH] = VJ.PICK({ACT_RUN, ACT_RUN_AGITATED})

    if self.Soldier_Type == 0 then -- Spetsnaz
        if !self.Soldier_PistolAnims then
            if bodyGroup == 0 then -- AKS
                self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SMG1
                self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
                self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
                self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
            elseif bodyGroup == 1 then -- VAL
                self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SMG1
                self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
                self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
                self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
            elseif bodyGroup == 2 then -- Groza
                self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SMG1
                self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
                self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
                self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
            end
        elseif self.Soldier_PistolAnims then
            if bodyGroup == 0 then -- APS
                self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_PISTOL
                self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_PISTOL_LOW
                self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_PISTOL
                self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_PISTOL_LOW
            end
        end
    elseif self.Soldier_Type == 1 then -- Army
        if bodyGroup == 0 then -- AK-74
            self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SMG1
            self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
            self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
            self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
        end
    elseif self.Soldier_Type == 2 or self.Soldier_Type == 3 then -- Terrorist && Clone
        if bodyGroup == 0 then -- AK-74
            self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SMG1
            self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
            self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
            self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
        elseif bodyGroup == 1 then -- PKM
            self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_AR2 //VJ.PICK({ACT_RANGE_ATTACK_SMG1, ACT_RANGE_ATTACK_AR2})
            //self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
            self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
            self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
        end
    elseif self.Soldier_Type == 4 then -- Saboteur
        if !self.Soldier_PistolAnims then
            if bodyGroup == 0 then -- MP5
                self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SMG1
                self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
                self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
                self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
            elseif bodyGroup == 1 then -- SPAS-12
                self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SHOTGUN
                self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SHOTGUN_LOW
                self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SHOTGUN
                self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SHOTGUN_LOW
            end
        elseif self.Soldier_PistolAnims then
            if bodyGroup == 0 then -- Glock 17
                self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_PISTOL
                self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_PISTOL_LOW
                self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_PISTOL
                self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_PISTOL_LOW
            end
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local animStrafing = {ACT_STRAFE_RIGHT, ACT_STRAFE_LEFT}
--
function ENT:Soldier_OnThink()
    if self.VJ_IsBeingControlled or self.IsGuard or self.Soldier_PistolAnims then return end
    local curTime = CurTime()
    if IsValid(self:GetEnemy()) && self.WeaponAttackState == VJ.WEP_ATTACK_STATE_FIRE_STAND && !self.VJ_IsBeingControlled && curTime > self.Soldier_NextStrafeT && !self:IsMoving() && self:GetPos():Distance(self:GetEnemy():GetPos()) < 1400 then
        self:StopMoving()
        self:PlayAnim(animStrafing, true, false, false)
        self.Soldier_NextRunT = curTime + 2
        self.Soldier_NextStrafeT = curTime + 8
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
    -- Mouth movement
    local curTime = CurTime()
    if curTime < self.Soldier_NextMouthMove then
        if self.Soldier_NextMouthDistance == 0 then
            self.Soldier_NextMouthDistance = math_random(10, 70)
        else
            self.Soldier_NextMouthDistance = 0
        end
        self:SetPoseParameter("mouth_move", self.Soldier_NextMouthDistance)
    else
        self:SetPoseParameter("mouth_move", 0)
    end

    -- Handle weapon body group changing
    local bodyGroup = self:GetBodygroup(self.Soldier_WepBG)
    local myMDL = self:GetModel()
    local wep = self:GetActiveWeapon()
    if self.Soldier_LastBodyGroup != bodyGroup then
        self.Soldier_LastBodyGroup = bodyGroup
        if self.Soldier_Type == 0 then -- Spetsnaz
            if !self.Soldier_PistolAnims then
                if bodyGroup == 0 then -- AK-74
                    self:DoChangeWeapon("weapon_vj_hlrpar1_aks")
                elseif bodyGroup == 1 then -- VAL
                    self:DoChangeWeapon("weapon_vj_hlrpar1_val")
                elseif bodyGroup == 2 then -- Groza
                    self:DoChangeWeapon("weapon_vj_hlrpar1_groza")
                elseif IsValid(wep) then
                    wep:Remove()
                end
            elseif self.Soldier_PistolAnims then
                if bodyGroup == 0 then -- APS
                    self:DoChangeWeapon("weapon_vj_hlrpar1_aps")
                elseif IsValid(wep) then
                    wep:Remove()
                end
            end
        elseif self.Soldier_Type == 1 then -- Army
            if bodyGroup == 0 then -- AK-74
                self:DoChangeWeapon("weapon_vj_hlrpar1_ak74")
            elseif IsValid(wep) then
                wep:Remove()
            end
        elseif self.Soldier_Type == 2 then -- Terrorist
            if bodyGroup == 0 then -- AK-74
                self:DoChangeWeapon("weapon_vj_hlrpar1_ak74")
            elseif bodyGroup == 1 then -- PKM
                self:DoChangeWeapon("weapon_vj_hlrpar1_pkm")
            elseif IsValid(wep) then
                wep:Remove()
            end
        elseif self.Soldier_Type == 3 then -- Clone
            if bodyGroup == 0 then -- AK-74/AKS
                if myMDL == "models/vj_parr/par2/monster_clonsoldier.mdl" or myMDL == "models/vj_parr/par2/v1/monster_clonsoldier.mdl" then
                    self:DoChangeWeapon("weapon_vj_hlrpar2_aks")
                else
                    self:DoChangeWeapon("weapon_vj_hlrpar1_ak74")
                end
            elseif bodyGroup == 1 then -- PKM
                if myMDL == "models/vj_parr/par2/monster_clonsoldier.mdl" or myMDL == "models/vj_parr/par2/v1/monster_clonsoldier.mdl" then
                    self:DoChangeWeapon("weapon_vj_hlrpar2_pkm")
                else
                    self:DoChangeWeapon("weapon_vj_hlrpar1_pkm")
                end
            elseif IsValid(wep) then
                wep:Remove()
            end
        elseif self.Soldier_Type == 4 then -- Saboteur
            if !self.Soldier_PistolAnims then
                if bodyGroup == 0 then -- MP5
                    self:DoChangeWeapon("weapon_vj_hlrpar1_mp5")
                elseif bodyGroup == 1 && myMDL != "models/vj_parr/par1/cut/blackop.mdl" then -- Shotgun
                    self:DoChangeWeapon("weapon_vj_hlrpar1_spas12")
                elseif IsValid(wep) then
                    wep:Remove()
                end
            elseif self.Soldier_PistolAnims then
                if bodyGroup == 0 then -- Glock 17
                    self:DoChangeWeapon("weapon_vj_hlrpar1_glock17")
                elseif IsValid(wep) then
                    wep:Remove()
                end
            end
        end
    end
    if self.Soldier_OnThink then self:Soldier_OnThink() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdAlertMonster = {"vj_parr/par1/npc/bunk/kulak_ih_mnogo.wav", "vj_parr/par1/npc/bunk/kulak_wtf2.wav"}
--
function ENT:OnAlert(ent)
    if math_random(1, 3) == 1 then
        if ent.IsVJBaseSNPC_Creature && !ent.VJ_ID_Vehicle && !ent.VJ_ID_Aircraft then -- Monster sounds
            self:PlaySoundSystem("Alert", sdAlertMonster)
            return
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackTraceDirection()
    return self:GetForward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnGrenadeAttack(status, overrideEnt, landDir)
    if status == "Init" then
        -- Play a unique animation when throwing back grenades
        if IsValid(overrideEnt) then
            self.AnimTbl_GrenadeAttack = ACT_SPECIAL_ATTACK2
            self.GrenadeAttackAttachment = "lhand"
        else
            self.AnimTbl_GrenadeAttack = ACT_SPECIAL_ATTACK1
            self.GrenadeAttackAttachment = "rhand"
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
    elseif status == "DeathAnim" then
        self:DeathWeaponDrop(dmginfo, hitgroup)
        self:OnDeath(dmginfo, hitgroup, "Finish")
        local activeWep = self:GetActiveWeapon()
        if IsValid(activeWep) then activeWep:Remove() end
    elseif status == "Finish" then
        -- Remove the weapon body groups and other objects
        self:SetBodygroup(self.Soldier_WepBG, self.Soldier_WepBGRemove)
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
    self:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
    return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibs = {"models/vj_parr/par1/gibs/hgib1.mdl", "models/vj_parr/par1/gibs/hgib2.mdl", "models/vj_parr/par1/gibs/hgib3.mdl", "models/vj_parr/par1/gibs/hgib4.mdl", "models/vj_parr/par1/gibs/hgib5.mdl", "models/vj_parr/par1/gibs/hgib6.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    VJ.HLR_ApplyCorpseSystem(self, corpse, gibs, {CollisionSound = gibsCollideSd, ExpSound = "vj_parr/par1/shared/bodysplat.wav"})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFootstepSound(moveType, sdFile)
    if !self:OnGround() then return end
    local watLevel = self:WaterLevel()
    if watLevel > 0 && watLevel < 3 then
        VJ.EmitSound(self, "vj_parr/par1/shared/npc_slosh" .. math_random(1, 2) .. ".wav", self.FootstepSoundLevel, self:GetSoundPitch(self.FootStepPitch1, self.FootStepPitch2))
    end
end