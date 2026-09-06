AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/td_btr90_v2.mdl"
ENT.StartHealth = 250
ENT.ControllerParams = {
    ThirdP_Offset = Vector(-20, 0, 40),
    FirstP_Bone = "joint1",
    FirstP_Offset = Vector(00, 0, 130),
    FirstP_ShrinkBone = false,
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN_FRIENDLY"}
ENT.AlliedWithPlayerAllies = true
ENT.BecomeEnemyToPlayer = 2
ENT.HasOnPlayerSight = true

ENT.SoundTbl_Breath = "vj_parr/par1/tanks/motor_loop.wav"
ENT.SoundTbl_Death = "VJ.PARR1_Explosion.Single"

ENT.MainSoundPitch = VJ.SET(95, 105)

-- Tank Base
ENT.Tank_SoundTbl_DrivingEngine = "vj_hlr/gsrc/npc/tanks/tankdrive.wav"
ENT.Tank_SoundTbl_Track = "vehicles/v8/fourth_cruise_loop2.wav"

ENT.Tank_DriveAwayDistance = 500
ENT.Tank_DriveTowardsDistance = 2000
ENT.Tank_RanOverDistance = 400
ENT.Tank_TurningSpeed = 2.5
ENT.Tank_DrivingSpeed = 300

ENT.Tank_GunnerENT = "npc_vj_hlrpar1_rus_btr90_gun"
ENT.Tank_CollisionBoundSize = 60
ENT.Tank_CollisionBoundUp = 90
ENT.Tank_DeathDriverCorpse = "models/vj_parr/par1/soldier.mdl"
ENT.Tank_DeathDecal = "VJ_PARR1_Scorch"

-- Custom
ENT.BTR_DmgForce = 0

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_Init()
    self.SoundTbl_Idle = {
        "vj_parr/par1/npc/army/afgan.wav",
        "vj_parr/par1/npc/army/fix.wav",
        "vj_parr/par1/npc/army/pentagon_hack.wav",
        "vj_parr/par1/soldier/bolnoy1.wav",
        "vj_parr/par1/soldier/bolnoy2.wav",
        "vj_parr/par1/soldier/bolnoy3.wav",
        "vj_parr/par1/soldier/rest1.wav",
        "vj_parr/par1/soldier/rest2.wav",
        "vj_parr/par1/soldier/rest3.wav",
        "vj_parr/par1/soldier/rest4.wav",
        "vj_parr/par1/soldier/sleep.wav",
        "vj_parr/par1/alpha/monologue7.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/npc/army/zapalil1.wav",
        "vj_parr/par1/npc/army/zapalil2.wav",
        "vj_parr/par1/npc/army/zapalil3.wav",
        "vj_parr/par1/npc/army/zapalil4.wav"
    }
    self.SoundTbl_ReceiveOrder = {
        "vj_parr/par1/soldier/ok1.wav",
        "vj_parr/par1/soldier/ok2.wav",
        "vj_parr/par1/soldier/ok3.wav",
        "vj_parr/par1/soldier/yes1.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par1/npc/army/karaul1.wav",
        "vj_parr/par1/npc/army/karaul2.wav",
        "vj_parr/par1/npc/army/karaul3.wav",
        "vj_parr/par1/npc/army/karaul4.wav"
    }
    self.SoundTbl_OnPlayerSight = {
        "vj_parr/par1/soldier/hello2.wav",
        "vj_parr/par1/soldier/hello3.wav",
        "vj_parr/par1/soldier/hello4.wav",
        "vj_parr/par1/soldier/hello5.wav",
        "vj_parr/par1/alpha/hello1.wav",
        "vj_parr/par1/alpha/hello2.wav",
        "vj_parr/par1/alpha/hello3.wav",
        "vj_parr/par1/alpha/hello4.wav",
        "vj_parr/par1/alpha/hello5.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_GunnerSpawnPosition()
    return self:GetPos() + self:GetForward() * 32 + self:GetUp() * 71 + self:GetRight() * 1.2
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tank_UpdateMoveParticles()
    local spawnPos = self:GetPos() + self:GetForward() * -135
    local effectData = EffectData()
    effectData:SetScale(1)
    effectData:SetEntity(self)
    effectData:SetOrigin(spawnPos + self:GetRight() * 40)
    util.Effect("VJ_VehicleMove", effectData, true, true)
    effectData:SetOrigin(spawnPos + self:GetRight() * -40)
    util.Effect("VJ_VehicleMove", effectData, true, true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetNearDeathSparkPositions()
    local randPos = math_random(1, 5)
    if randPos == 1 then
        self.Spark1:SetLocalPos(self:GetPos() + self:GetRight() * 15 + self:GetForward() * -16 + self:GetUp() * 80)
    elseif randPos == 2 then
        self.Spark1:SetLocalPos(self:GetPos() + self:GetRight() * 42 + self:GetForward() * 110 + self:GetUp() * 50)
    elseif randPos == 3 then
        self.Spark1:SetLocalPos(self:GetPos() + self:GetRight() * -42 + self:GetForward() * 110 + self:GetUp() * 50)
    elseif randPos == 4 then
        self.Spark1:SetLocalPos(self:GetPos() + self:GetRight() * 50 + self:GetForward() * -40 + self:GetUp() * 70)
    elseif randPos == 5 then
        self.Spark1:SetLocalPos(self:GetPos() + self:GetRight() * -50 + self:GetForward() * -45 + self:GetUp() * 70)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local expPos = Vector(0, 0, 150)
--
function ENT:Tank_OnInitialDeath(dmginfo, hitgroup)
    self.BTR_DmgForce = dmginfo:GetDamageForce()
    for i = 0, 1, 0.5 do
        timer.Simple(i, function()
            if IsValid(self) then
                VJ.EmitSound(self, self.SoundTbl_Death, 100)
                VJ.EmitSound(self, "vj_parr/par1/weapons/debris3.wav", 100)
                util.BlastDamage(self, self, self:GetPos(), 200, 40)
                util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)

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
                spr:SetKeyValue("scale", "4")
                spr:SetPos(self:GetPos() + expPos)
                spr:Spawn()
                spr:Fire("Kill", nil, 0.9)
                timer.Simple(0.9, function() if IsValid(spr) then spr:Remove() end end)
            end
        end)
    end

    timer.Simple(1.5, function()
        if IsValid(self) then
            VJ.EmitSound(self, self.SoundTbl_Death, 100)
            util.BlastDamage(self, self, self:GetPos(), 200, 40)
            util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
            VJ.EmitSound(self, "vj_parr/par1/weapons/debris3.wav", 100)
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
            spr:SetKeyValue("scale", "4")
            spr:SetPos(self:GetPos() + expPos)
            spr:Spawn()
            spr:Fire("Kill", nil, 0.9)
            timer.Simple(0.9, function() if IsValid(spr) then spr:Remove() end end)
        end
    end)
    return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector()
--
function ENT:OnDamaged(dmginfo, hitgroup, status)
    if status == "Init" && dmginfo:GetDamagePosition() != vec then
        local rico = EffectData()
        rico:SetOrigin(dmginfo:GetDamagePosition())
        rico:SetScale(5) -- Size
        rico:SetMagnitude(math_random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
        util.Effect("VJ_PARR_Rico", rico)
    end
    self.BaseClass.OnDamaged(self, dmginfo, hitgroup, status)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local metalCollideSD = {"vj_parr/par1/shared/metal1.wav", "vj_parr/par1/shared/metal2.wav", "vj_parr/par1/shared/metal3.wav", "vj_parr/par1/shared/metal4.wav"}
--
function ENT:Tank_OnDeathCorpse(dmginfo, hitgroup, corpse, status, statusData)
    if status == "Override" then
        util.BlastDamage(self, self, self:GetPos() + self:GetUp() * 80, 200, 10)
    elseif status == "Soldier" then
        statusData:SetBodygroup(1, math_random(0, 5))
        statusData:SetBodygroup(3, math_random(0, 1))
        statusData:SetBodygroup(2, 1)
    elseif status == "Effects" then
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
        spr:SetKeyValue("scale", "4")
        spr:SetPos(self:GetPos() + expPos)
        spr:Spawn()
        spr:Fire("Kill", nil, 0.9)
        timer.Simple(0.9, function() if IsValid(spr) then spr:Remove() end end)
        return true
    end
end