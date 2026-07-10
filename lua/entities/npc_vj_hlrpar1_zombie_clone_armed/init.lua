include("entities/npc_vj_hlrpar1_zombie_clone/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/cut/zombie_slow_armed.mdl"

ENT.HasRangeAttack = true
ENT.NextRangeAttackTime = 0
ENT.RangeAttackMaxDistance = 2000
ENT.RangeAttackMinDistance = 60
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.LimitChaseDistance = true
ENT.LimitChaseDistance_Max = 300
ENT.LimitChaseDistance_Min = 150

local math_random = math.random
local math_rand = math.Rand
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireFX()
    local attShell = self:GetAttachment(self:LookupAttachment("shell"))

    local effectData = EffectData()
    effectData:SetEntity(self)
    effectData:SetOrigin(attShell.Pos)
    effectData:SetAngles(attShell.Ang)
    util.Effect("ShellEject", effectData, true, true)

    local muz = ents.Create("env_sprite")
    muz:SetKeyValue("model", "vj_hl/sprites/muzzleflash2.vmt")
    muz:SetKeyValue("scale", "" .. math_rand(0.15, 0.25))
    muz:SetKeyValue("GlowProxySize", "2.0")
    muz:SetKeyValue("HDRColorScale", "1.0")
    muz:SetKeyValue("renderfx", "14")
    muz:SetKeyValue("rendermode", "3")
    muz:SetKeyValue("renderamt", "255")
    muz:SetKeyValue("disablereceiveshadows", "0")
    muz:SetKeyValue("framerate", "15.0")
    muz:SetKeyValue("spawnflags", "0")
    muz:SetParent(self)
    muz:Fire("SetParentAttachment", "muzzle")
    muz:SetAngles(Angle(math_random(-100, 100), math_random(-100, 100), math_random(-100, 100)))
    muz:Spawn()
    muz:Activate()
    muz:Fire("Kill", "", 0.08)

    local muzLight = ents.Create("light_dynamic")
    muzLight:SetKeyValue("brightness", "4")
    muzLight:SetKeyValue("distance", "120")
    muzLight:SetPos(self:GetAttachment(self:LookupAttachment("muzzle")).Pos)
    muzLight:SetLocalAngles(self:GetAngles())
    muzLight:Fire("Color", "255 150 60")
    //muzLight:SetParent(self)
    muzLight:Spawn()
    muzLight:Activate()
    muzLight:Fire("TurnOn", "" , 0)
    muzLight:Fire("Kill", "", 0.07)
    //self:DeleteOnRemove(muzLight)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoImpactEffect(tr, damageType)
    return VJ.HLR1_Effect_Impact(tr)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRangeAttackExecute(status, enemy, projectile)
    if status == "Init" then
        local attPos = self:GetAttachment(self:LookupAttachment("muzzle")).Pos
        VJ.EmitSound(self, "VJ.PARR1_APS.Single")
        self:FireBullets({
            Attacker = self,
            Num = 1,
            Src = attPos,
            Dir = (self:GetAimPosition(enemy, attPos, 0) - attPos):Angle():Forward(),
            Spread = Vector(0.1, 0.1, 0),
            TracerName = "VJ_PARR_Tracer",
            Tracer = 1,
            Damage = self:ScaleByDifficulty(8),
            Force = 5,
            AmmoType = "Pistol",
            Distance = 2048,
            HullSize = 1
        })
        self:FireFX()
        return true
    end
end