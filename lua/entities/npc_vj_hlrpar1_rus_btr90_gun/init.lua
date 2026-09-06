AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/td_btr90_v2_gun.mdl"
ENT.StartHealth = 0
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN_FRIENDLY"}
ENT.AlliedWithPlayerAllies = true
ENT.BecomeEnemyToPlayer = 2
ENT.HasOnPlayerSight = true
ENT.HasDeathCorpse = true

-- Tank Base
ENT.Tank_SoundTbl_Turning = "vj_hlr/gsrc/npc/tanks/bradley_turret_rot.wav"
ENT.Tank_SoundTbl_ReloadShell = "vj_hlr/gsrc/npc/tanks/25mm_reload.wav"
ENT.Tank_SoundTbl_FireShell = "vj_hlr/gsrc/npc/tanks/biggun2.wav"

local vecBullet = Vector(100, 0, 10)
ENT.Tank_Shell_SpawnPos = Vector(100, 0, 9)
ENT.Tank_Shell_VelocitySpeed = 3000
ENT.Tank_Shell_MuzzleFlashPos = Vector(100, 0, 9)
ENT.Tank_Shell_ParticlePos = Vector(100, 0, 9)

-- CUstom
ENT.BTR_NextMGT = 0

local math_random = math.random
local math_rand = math.Rand
local CurTime = CurTime
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_OnPrepareShell()
    self.Tank_Shell_TimeUntilFire = 0.5
    self.HasReloadShellSound = false
    self.Tank_Shell_NextFireTime = 0.5
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vecZ40 = Vector(0, 0, 40)
--
function ENT:Tank_OnFireShell(status, statusData)
    if status == "Init" then
        local ene = self:GetEnemy()
        local pos = self:LocalToWorld(vecBullet)
        self:FireBullets({
            Damage = 1,
            Force = 100,
            HullSize = 10,
            Dir = (ene:GetPos() + ene:OBBCenter()) - pos,
            Src = pos,
            Spread = Vector(math_rand(-50, 50), math_rand(-50, 50), 0),
            TracerName = "VJ_PARR_Tracer_Large",
            Callback = function(attack, tr, dmginfo)
                local hitPos = tr.HitPos
                VJ.ApplyRadiusDamage(self, self, hitPos, 50, 30, DMG_BLAST, true, true, {Force = 100})
                util.Decal("VJ_PARR1_Scorch", hitPos + tr.HitNormal, hitPos - tr.HitNormal)

                sound.Play("VJ.PARR1_Explosion.Single", hitPos, 70, 100, 1)
                sound.Play("vj_parr/par1/weapons/debris3.wav", hitPos, 70, 100, 1)

                local spr = ents.Create("env_sprite")
                spr:SetKeyValue("model", "vj_parr/sprites/zerogxplode.vmt")
                spr:SetKeyValue("GlowProxySize", "2.0")
                spr:SetKeyValue("HDRColorScale", "1.0")
                spr:SetKeyValue("renderfx", "14")
                spr:SetKeyValue("rendermode", "5")
                spr:SetKeyValue("renderamt", "255")
                spr:SetKeyValue("disablereceiveshadows", "0")
                spr:SetKeyValue("mindxlevel", "0")
                spr:SetKeyValue("maxdxlevel", "0")
                spr:SetKeyValue("framerate", "15.0")
                spr:SetKeyValue("spawnflags", "0")
                spr:SetKeyValue("scale", "1.5")
                spr:SetPos(hitPos + vecZ40)
                spr:Spawn()
                spr:Fire("Kill", nil, 0.9)
                timer.Simple(0.9, function() if IsValid(spr) then spr:Remove() end end)

                local expLight = ents.Create("light_dynamic")
                expLight:SetKeyValue("brightness", "4")
                expLight:SetKeyValue("distance", "300")
                expLight:SetPos(hitPos)
                expLight:Fire("Color", "255 150 0")
                expLight:Spawn()
                expLight:Activate()
                expLight:Fire("TurnOn")
                expLight:Fire("Kill", nil, 0.1)
            end
        })
        return true
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local bulletSpread = Vector(50, 50, 50)
--
function ENT:Tank_OnThinkActive()
    local ene = self:GetEnemy()
    if IsValid(ene) then
        local curTime = CurTime()
        if self.Tank_FacingTarget && curTime > self.BTR_NextMGT then
            local pos = self:LocalToWorld(vecBullet)
            self:FireBullets({
                Num = 1,
                Src = pos,
                Dir = (ene:GetPos() + ene:OBBCenter()) - pos,
                Spread = bulletSpread,
                Tracer = 1,
                TracerName = "VJ_PARR_Tracer",
                Force = 3,
                Damage = self:ScaleByDifficulty(12),
                AmmoType = "SMG"
            })
            self.BTR_NextMGT = curTime + 0.1
            VJ.EmitSound(self, "VJ.PARR1_MG.Single")
            self:FireFX()
        end
    end
    return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireFX()
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
    muz:Fire("SetParentAttachment", "mg")
    muz:SetAngles(Angle(math_random(-100, 100), math_random(-100, 100), math_random(-100, 100)))
    muz:Spawn()
    muz:Activate()
    muz:Fire("Kill", nil, 0.08)

    /*local muzLight = ents.Create("light_dynamic")
    muzLight:SetKeyValue("brightness", "4")
    muzLight:SetKeyValue("distance", "120")
    muzLight:SetPos(self:GetAttachment(self:LookupAttachment("mg")).Pos)
    muzLight:Fire("Color", "255 150 60")
    muzLight:SetParent(self)
    muzLight:Spawn()
    muzLight:Activate()
    muzLight:Fire("TurnOn")
    muzLight:Fire("Kill", nil, 0.07)
    self:DeleteOnRemove(muzLight)*/

    /*local startPos = self:GetPos() + self:GetUp() * 50 + self:GetForward() * 100
    local tr = util.TraceLine({
        start = startPos,
        endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
        filter = self
    })
    local beam = EffectData()
    beam:SetStart(startPos)
    beam:SetOrigin(tr.HitPos)
    beam:SetEntity(self)
    beam:SetAttachment(2)
    util.Effect("VJ_PARR_Tracer", beam)
    return tr.HitPos*/
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoImpactEffect(tr, damageType)
    return VJ.PARR1_Effect_Impact(tr)
end