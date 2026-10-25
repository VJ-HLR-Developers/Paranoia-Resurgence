include("entities/npc_vj_hlrpar1_rus_pkm/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/mgun.mdl"

local CurTime = CurTime
//local bit_bor = bit.bor
local math_random = math.random
local math_rand = math.Rand
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self.PKM_Gunners = {}

    -- Spawn the gunner
    local gunner = ents.Create("npc_vj_hlrpar2_rus_soldier")
    local att = self:GetAttachment(self:LookupAttachment("gunner"))
    gunner:SetPos(att.Pos)
    gunner:SetAngles(att.Ang)
    gunner:SetOwner(self)
    gunner:SetParent(self)
    gunner.MovementType = VJ_MOVETYPE_STATIONARY
    gunner.PoseParameterLooking_TurningSpeed = 5
    gunner.PKM_Gunner = true
    gunner.Weapon_Disabled = true
    gunner.AnimTbl_DamageAllyResponse = false
    gunner.AnimTbl_CallForHelp = false
    gunner.AnimTbl_TakingCover = false
    gunner.CanTurnWhileStationary = false
    gunner.Weapon_UnarmedBehavior = false
    gunner.PhysgunDisabled = true
    gunner.VJ_NPC_Class = self.VJ_NPC_Class
    gunner.DoNotDuplicate = true -- Otherwise you will have double gunners
    gunner:Spawn()
    gunner:SetBodygroup(gunner.Soldier_WepBG, gunner.Soldier_WepBGRemove) -- Remove weapon bodygroups
    self:SetRelationshipMemory(gunner, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    gunner:SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    self.PKM_Gunners = gunner

    VJ.HLR_ApplyFactionOptions(self)

    local curTime = CurTime()
    self.PKM_LockTime = curTime + 0.3 -- Prevent spawn-killing
    self:SetPhysicsDamageScale(0.001) -- Take minimum physics damage
    self:SetCollisionBounds(Vector(13, 13, 45), Vector(-13, -13, 0))
    self:SetSurroundingBounds(Vector(60, 60, 90), Vector(-60, -60, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRangeAttackExecute(status, enemy, projectile)
    if status == "Init" then
        local attPos = self:GetAttachment(self:LookupAttachment("muzzle")).Pos
        self.PKM_Ammo = self.PKM_Ammo - 1
        if self.PKM_Ammo <= 0 then self:Reload() end
        VJ.EmitSound(self, "VJ.PARR2_PKM.Single")
        self:FireBullets({
            Attacker = self.PKM_Gunners,
            Num = 1,
            Src = attPos,
            Dir = (self:GetAimPosition(enemy, attPos, 0) - attPos):Angle():Forward(),
            Spread = Vector(0.1, 0.1, 0),
            TracerName = "VJ_PARR_Tracer",
            Tracer = 1,
            Damage = self:ScaleByDifficulty(12),
            Force = 5,
            AmmoType = "SMG",
            Distance = 2048,
            HullSize = 1,
            /*Callback = function(attack, tr, dmginfo)
                dmginfo:SetDamageType(bit_bor(DMG_BULLET, DMG_AIRBOAT))
            end*/
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
    muz:SetKeyValue("model", "vj_parr/sprites/muzzleflash2.vmt")
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
    muzLight:Fire("Color", "255 150 60")
    muzLight:SetParent(self)
    muzLight:Fire("SetParentAttachment", "muzzle")
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
        self:RemoveAllGestures()
        VJ.EmitSound(self, "vj_parr/par2/weapons/pkm/pkm_boxout.wav", 60, 100)
    end
    timer.Simple(1.5, function() if IsValid(self) then VJ.EmitSound(self, "vj_parr/par2/weapons/pkm/pkm_boxin.wav", 60, 100) end end)
    timer.Simple(2.5, function() if IsValid(self) then VJ.EmitSound(self, "vj_parr/par2/weapons/pkm/pkm_slideback1.wav", 60, 100) end end)
    timer.Simple(VJ.AnimDuration(self, ACT_RANGE_ATTACK1) + 3, function()
        if IsValid(self) && self.PKM_Reload && !self.Dead then
            self.PKM_Reload = false
            self.PKM_Ammo = self.PKM_Ammo + 100
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoImpactEffect(tr, damageType)
    return VJ.PARR2_Effect_Impact(tr)
end