include("entities/npc_vj_hlrpar2_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/monster_soldiershooter.mdl"

ENT.Weapon_IgnoreSpawnMenu = true
ENT.Weapon_Strafe = false
ENT.AnimTbl_WeaponAttackGesture = false
//ENT.Weapon_RetreatDistance = 0
//ENT.Weapon_FindCoverOnReload = false

//ENT.CombatDamageResponse = false
ENT.AnimTbl_DamageAllyResponse = false
ENT.AnimTbl_CallForHelp = ACT_SIGNAL2
ENT.AnimTbl_TakingCover = false

-- Custom
ENT.Zombie_WepBG = 0

local math_random = math.random
local math_rand = math.Rand
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Voice()
    self.SoundTbl_Death = {
        "vj_parr/par2/clone/cl_die1.wav",
        "vj_parr/par2/clone/cl_die2.wav",
        "vj_parr/par2/clone/cl_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par2/clone/cl_pain1.wav",
        "vj_parr/par2/clone/cl_pain2.wav",
        "vj_parr/par2/clone/cl_pain3.wav",
        "vj_parr/par2/clone/cl_pain4.wav",
        "vj_parr/par2/clone/cl_pain5.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.Zombie_WepBG = 2
    self.Zombie_WepBGRemove = 2
    self:SetBodygroup(1, math_random(0, 1))
    if math_random(1, 2) == 1 then self:SetBodygroup(self.Zombie_WepBG, math_random(0, 1)) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    local npcState = self:GetNPCState()
    if act == ACT_IDLE && (npcState == NPC_STATE_ALERT or npcState == NPC_STATE_COMBAT) then
        return self.AnimationTranslations[ACT_IDLE_ANGRY] or ACT_IDLE_ANGRY
    end
    return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoImpactEffect(tr, damageType)
    return VJ.PARR2_Effect_Impact(tr)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathShoot()
    local wep = self:GetActiveWeapon()
    if IsValid(wep) && wep:Clip1() > 3 then
        local attMuz = wep:GetAttachment(wep:LookupAttachment("muzzle"))
        local attShell = wep:GetAttachment(wep:LookupAttachment("shell"))
        VJ.EmitSound(wep, wep.Primary.Sound)
        self:FireBullets({
            Attacker = self,
            Num = 1,
            Src = attMuz.Pos,
            Dir = attMuz.Ang:Forward(),
            Spread = Vector(0.1, 0.1, 0),
            TracerName = "VJ_PARR_Tracer",
            Tracer = 1,
            Damage = self.ScaleByDifficulty(self, wep.Primary.Damage),
            Force = 5,
            AmmoType = "SMG1",
            Distance = 2048,
            HullSize = 1
        })
        local effectData = EffectData()
        effectData:SetEntity(wep)
        effectData:SetOrigin(attShell.Pos)
        effectData:SetAngles(attShell.Ang)
        util.Effect("RifleShellEject", effectData, true, true)

        local muz = ents.Create("env_sprite")
        muz:SetKeyValue("model", "vj_parr/sprites/muzzleflash2.vmt")
        muz:SetKeyValue("scale", "" .. math_rand(0.15, 0.25))
        muz:SetKeyValue("GlowProxySize", "2.0")
        muz:SetKeyValue("HDRColorScale", "1.0")
        muz:SetKeyValue("renderfx", "14")
        muz:SetKeyValue("rendermode", "3")
        muz:SetKeyValue("renderamt", "255")
        muz:SetKeyValue("disablereceiveshadows", "0")
        muz:SetKeyValue("framerate", "15.0")
        muz:SetKeyValue("spawnflags", "0")
        muz:SetParent(wep)
        muz:Fire("SetParentAttachment", "muzzle")
        muz:SetAngles(Angle(math_random(-100, 100), math_random(-100, 100), math_random(-100, 100)))
        muz:Spawn()
        muz:Activate()
        muz:Fire("Kill", nil, 0.08)

        local muzLight = ents.Create("light_dynamic")
        muzLight:SetKeyValue("brightness", "4")
        muzLight:SetKeyValue("distance", "120")
        muzLight:SetPos(attMuz.Pos)
        muzLight:Fire("Color", "255 150 60")
        muzLight:SetParent(self)
        muzLight:Spawn()
        muzLight:Activate()
        muzLight:Fire("TurnOn")
        muzLight:Fire("Kill", nil, 0.07)
        self:DeleteOnRemove(muzLight)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAnimationTranslations(wepHoldType)
    local bodyGroup = self.Zombie_LastBodyGroup

    self.AnimationTranslations[ACT_IDLE] = ACT_IDLE
    self.AnimationTranslations[ACT_IDLE_ANGRY] = ACT_IDLE_ANGRY

    if bodyGroup == 0 then -- AK-74
        self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_SMG1
        self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
        self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
        self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
    elseif bodyGroup == 1 then -- PKM
        self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_AR2 // VJ.PICK({ACT_RANGE_ATTACK_SMG1, ACT_RANGE_ATTACK_AR2})
        //self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW
        self.AnimationTranslations[ACT_RELOAD] = ACT_RELOAD_SMG1
        self.AnimationTranslations[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
    -- Handle weapon body group changing
    local bodyGroup = self:GetBodygroup(self.Zombie_WepBG)
    local wep = self:GetActiveWeapon()
    if self.Zombie_LastBodyGroup != bodyGroup then
        self.Zombie_LastBodyGroup = bodyGroup
        if bodyGroup == 0 then -- AK-74
            self:DoChangeWeapon("weapon_vj_hlrpar2_ak74")
        elseif bodyGroup == 1 then -- PKM
            self:DoChangeWeapon("weapon_vj_hlrpar2_pkm")
        elseif IsValid(wep) then
            wep:Remove()
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "DeathAnim" then
        timer.Simple(0.5, function()
            if IsValid(self) then
                self:DeathWeaponDrop(dmginfo, hitgroup)
                self:OnDeath(dmginfo, hitgroup, "Finish")
            end
        end)
    elseif status == "Finish" then
        -- Remove the weapon body groups and other objects
        self:SetBodygroup(self.Zombie_WepBG, self.Zombie_WepBGRemove)
    end
    baseclass.Get("npc_vj_hlrpar1_zombie").OnDeath(self, dmginfo, hitgroup, status)
end