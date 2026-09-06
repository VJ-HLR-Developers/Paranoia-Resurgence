AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/mgun.mdl"
ENT.StartHealth = 200
ENT.Bleeds = false
ENT.HullType = HULL_HUMAN
ENT.SightDistance = 6000
ENT.SightAngle = 360
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.PoseParameterLooking_TurningSpeed = 5
ENT.ControllerParams = {
    ThirdP_Offset = Vector(),
    FirstP_Bone = "joint3",
    FirstP_Offset = Vector(0, 0, 50),
    FirstP_ShrinkBone = false,
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN_FRIENDLY"}
ENT.AlliedWithPlayerAllies = true
ENT.BecomeEnemyToPlayer = 2

ENT.HasMeleeAttack = false

ENT.HasRangeAttack = true
ENT.AnimTbl_RangeAttack = false
ENT.RangeAttackMaxDistance = 6000
ENT.RangeAttackMinDistance = 100
ENT.TimeUntilRangeAttackProjectileRelease = 0
ENT.NextRangeAttackTime = 0.1

ENT.VJ_ID_Healable = false

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = ACT_RANGE_ATTACK1

-- Custom
ENT.PKM_HasLOS = false
ENT.PKM_Shooting = false
ENT.PKM_Reload = false
ENT.PKM_LockTime = 0
ENT.PKM_StunnedT = 0
ENT.PKM_Ammo = 100

local bit_bor = bit.bor
local math_abs = math.abs
local math_approachangle = math.ApproachAngle
local math_angledifference = math.AngleDifference
local math_random = math.random
local math_rand = math.Rand
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self.PKM_Gunners = {}

    -- Spawn the gunner
    local gunner = ents.Create(self:GetClass() == "npc_vj_hlrpar1_ter_pkm" && "npc_vj_hlrpar1_terrorist" or "npc_vj_hlrpar1_rus_soldier")
    local att = self:GetAttachment(self:LookupAttachment("gunner"))
    gunner:SetPos(att.Pos)
    gunner:SetAngles(att.Ang)
    gunner:SetOwner(self)
    gunner:SetParent(self)
    gunner.MovementType = VJ_MOVETYPE_STATIONARY
    gunner.PKM_Gunner = true
    gunner.Weapon_Disabled = true
    gunner.HasGrenadeAttack = false
    gunner.AnimTbl_DamageAllyResponse = false
    gunner.AnimTbl_CallForHelp = false
    gunner.AnimTbl_TakingCover = false
    gunner.CanTurnWhileStationary = false
    gunner.Weapon_UnarmedBehavior = false
    //gunner.HasDeathAnimation = false
    gunner.PhysgunDisabled = true
    gunner.VJ_NPC_Class = self.VJ_NPC_Class
    gunner.DoNotDuplicate = true -- Otherwise you will have double gunners
    gunner:Spawn()
    gunner:SetBodygroup(gunner.Soldier_WepBG, gunner.Soldier_WepBGRemove) -- Remove weapon bodygroups
    self:SetRelationshipMemory(gunner, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    gunner:SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    gunner:SetState(VJ_STATE_ONLY_ANIMATION)
    self.PKM_Gunners = gunner

    VJ.HLR_ApplyFactionOptions(self)
    self:SetCollisionBounds(Vector(13, 13, 45), Vector(-13, -13, 0))
    self.PKM_LockTime = CurTime() + 0.3 -- Prevent spawn-killing
    self:SetPhysicsDamageScale(0.001) -- Take minimum physics damage
end
---------------------------------------------------------------------------------------------------------------------------------------------
local threshold = 3
--
function ENT:OnUpdatePoseParamTracking(pitch, yaw, roll)
    local poseYaw = self:GetPoseParameter("aim_yaw")
    local posePitch = self:GetPoseParameter("aim_pitch")
    -- Compare the difference between the current position of the pose parameter and the position it's suppose to go to
    if (math_abs(math_angledifference(poseYaw, math_approachangle(poseYaw, yaw, self.PoseParameterLooking_TurningSpeed))) >= threshold) or (math_abs(math_angledifference(posePitch, math_approachangle(posePitch, pitch, self.PoseParameterLooking_TurningSpeed))) >= threshold) then
        self.PKM_HasLOS = false
    else
        self.PKM_HasLOS = true
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRangeAttack(status, enemy)
    if status == "PreInit" then
        return !(self.PKM_HasLOS && CurTime() > self.PKM_LockTime) or CurTime() < self.PKM_StunnedT or self.PKM_Ammo < 0
    elseif status == "PostInit" then
        self:PlayAnim(ACT_RANGE_ATTACK1, false, false, false, 0, {AlwaysUseGesture = true})
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRangeAttackExecute(status, enemy, projectile)
    if status == "Init" then
        local attPos = self:GetAttachment(self:LookupAttachment("muzzle")).Pos
        self.PKM_Ammo = self.PKM_Ammo - 1
        if self.PKM_Ammo <= 0 then self:Reload() end
        VJ.EmitSound(self, "VJ.PARR1_PKM.Single")
        self:FireBullets({
            Attacker = self,
            Num = 1,
            Src = attPos,
            Dir = (self:GetAimPosition(enemy, attPos, 0) - attPos):Angle():Forward(),
            Spread = Vector(0.1, 0.1, 0.1),
            TracerName = "VJ_PARR_Tracer",
            Tracer = 1,
            Damage = self:ScaleByDifficulty(12),
            Force = 5,
            AmmoType = "SMG",
            Distance = 2048,
            HullSize = 1
        })
        self:FireFX()
        return true
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireFX()
    local attShell = self:GetAttachment(self:LookupAttachment("shell"))

    local effectData = EffectData()
    effectData:SetEntity(self)
    effectData:SetOrigin(attShell.Pos)
    effectData:SetAngles(attShell.Ang)
    util.Effect("RifleShellEject", effectData, true, true)

    local muz = ents.Create("env_sprite")
    muz:SetKeyValue("model", "vj_parr/sprites/muzzleflash1.vmt")
    muz:SetKeyValue("scale", "" .. math_rand(0.3, 0.5))
    muz:SetKeyValue("GlowProxySize", "2.0") -- Size of the glow to be rendered for visibility testing.
    muz:SetKeyValue("HDRColorScale", "1.0")
    muz:SetKeyValue("renderfx", "14")
    muz:SetKeyValue("rendermode", "3") -- Set the render mode to "3" (Glow)
    muz:SetKeyValue("renderamt", "255") -- Transparency
    muz:SetKeyValue("disablereceiveshadows", "0") -- Disable receiving shadows
    muz:SetKeyValue("framerate", "10.0") -- Rate at which the sprite should animate, if at all.
    muz:SetKeyValue("spawnflags", "0")
    muz:SetParent(self)
    muz:Fire("SetParentAttachment", "muzzle")
    muz:SetAngles(Angle(math_random(-100, 100), math_random(-100, 100), math_random(-100, 100)))
    muz:Spawn()
    muz:Activate()
    muz:Fire("Kill", nil, 0.08)

    local muzLight = ents.Create("light_dynamic")
    muzLight:SetKeyValue("brightness", "4")
    muzLight:SetKeyValue("distance", "120")
    muzLight:SetPos(self:GetAttachment(self:LookupAttachment("muzzle")).Pos)
    muzLight:Fire("Color", "255 150 60")
    muzLight:SetParent(self)
    muzLight:Spawn()
    muzLight:Activate()
    muzLight:Fire("TurnOn")
    muzLight:Fire("Kill", nil, 0.07)
    self:DeleteOnRemove(muzLight)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Reload()
    if !self.PKM_Reload then
        self.PKM_Reload = true
        self:PlayAnim(ACT_RANGE_ATTACK1, true, false, false)
        VJ.EmitSound(self, "vj_parr/par1/weapons/pkm/pkm_boxout.wav", 60, 100)
    end
    timer.Simple(1.5, function() if IsValid(self) then VJ.EmitSound(self, "vj_parr/par1/weapons/pkm/pkm_boxin.wav", 60, 100) end end)
    timer.Simple(2.5, function() if IsValid(self) then VJ.EmitSound(self, "vj_parr/par1/weapons/pkm/pkm_slideback1.wav", 60, 100) end end)
    timer.Simple(VJ.AnimDuration(self, ACT_RANGE_ATTACK1) + 3, function()
        if IsValid(self) && self.PKM_Reload && !self.Dead then
            self.PKM_Reload = false
            self.PKM_Ammo = self.PKM_Ammo + 100
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoImpactEffect(tr, damageType)
    return VJ.PARR1_Effect_Impact(tr)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector()
--
function ENT:OnDamaged(dmginfo, hitgroup, status)
    if status == "PreDamage" && dmginfo:GetDamagePosition() != vec then
        local rico = EffectData()
        rico:SetOrigin(dmginfo:GetDamagePosition())
        rico:SetScale(4) -- Size
        rico:SetMagnitude(2) -- Effect type | 1 = Animated | 2 = Basic
        util.Effect("VJ_PARR_Rico", rico)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        if self:IsGibDamage(dmginfo:GetDamageType()) then self.HasDeathAnimation = false end
        -- Kill the gunner if the PKM Emplacement is killed
        -- Unparent them due to Source spawning them on a random part of the map
        local gunner = self.PKM_Gunners
        if IsValid(gunner) then
            gunner:SetParent(NULL)
            gunner:SetPos(self:GetAttachment(self:LookupAttachment("gunner")).Pos)
            local doDmg = DamageInfo()
            doDmg:SetDamage(gunner:Health())
            doDmg:SetDamageType(dmginfo:GetDamageType())
            gunner:TakeDamageInfo(doDmg)
        end
    elseif status == "DeathAnim" then
        gunner = self.PKM_Gunners
        if IsValid(gunner) then
            self.DeathAnimationTime = VJ.AnimDuration(gunner, gunner:GetSequenceActivity(gunner:GetIdealSequence()))
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
    -- Remove the gunner but NOT when the PKM Emplacement is killed
    if !self.Dead then
        local gunner = self.PKM_Gunners
        if IsValid(gunner) then
            gunner:Remove()
        end
    end
end