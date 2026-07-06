AddCSLuaFile()

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "MP5"
SWEP.Author = "Darkborn"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category = "VJ Base"
    -- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = false
SWEP.NPC_ReloadSound = "vj_hlr/null.wav"
SWEP.NPC_CanBePickedUp = false
SWEP.NPC_HasSecondaryFire = true
SWEP.NPC_SecondaryFireEnt = "obj_vj_hlrpar1_grenade_40mm"
SWEP.NPC_SecondaryFireSound = "vj_parr/par1/weapons/mp5/hks_pinpull.wav"
    -- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly = true
SWEP.WorldModel = "models/vj_parr/par1/weapons/w_9mmar.mdl"
SWEP.HoldType = "smg"
    -- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(180, 165, 90)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, 4, 0)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"
    -- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 8
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Sound = "VJ.PARR1_MP5.Single"
SWEP.Primary.TracerType = "VJ_PARR_Tracer"
SWEP.PrimaryEffects_ShellType = "ShellEject"
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.DryFireSound = "vj_hlr/gsrc/wep/dryfire1.wav"

-- Custom
local validModels = {
    ["models/vj_parr/par1/diversant.mdl"] = true,
    ["models/vj_parr/par1/cut/blackop.mdl"] = true
}
SWEP.Reload_Start = "vj_parr/par1/weapons/mp5/hks_clipout.wav"
SWEP.Reload_Middle = "vj_parr/par1/weapons/mp5/hks_clipin.wav"
SWEP.Reload_Finish = "vj_parr/par1/weapons/mp5/hks_01.wav"
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
    timer.Simple(0.1, function()
        if IsValid(self) && IsValid(self:GetOwner()) && VJ.HLR_Weapon_CheckModel(self, validModels) then
            self.NPC_NextPrimaryFire = false
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DoImpactEffect(tr, damageType)
    return VJ.HLR1_Effect_Impact(tr)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnDrawWorldModel()
    return !IsValid(self:GetOwner())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
    local muz = ents.Create("env_sprite")
    muz:SetKeyValue("model", "vj_parr/sprites/muzzleflash1.vmt")
    muz:SetKeyValue("scale", "" .. math.Rand(0.3, 0.5))
    muz:SetKeyValue("GlowProxySize", "2.0") -- Size of the glow to be rendered for visibility testing.
    muz:SetKeyValue("HDRColorScale", "1.0")
    muz:SetKeyValue("renderfx", "14")
    muz:SetKeyValue("rendermode", "3") -- Set the render mode to "3" (Glow)
    muz:SetKeyValue("renderamt", "255") -- Transparency
    muz:SetKeyValue("disablereceiveshadows", "0") -- Disable receiving shadows
    muz:SetKeyValue("framerate", "10.0") -- Rate at which the sprite should animate, if at all.
    muz:SetKeyValue("spawnflags", "0")
    muz:SetParent(self)
    muz:Fire("SetParentAttachment", self.PrimaryEffects_MuzzleAttachment)
    muz:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
    muz:Spawn()
    muz:Activate()
    muz:Fire("Kill", "", 0.08)
    self.BaseClass.PrimaryAttackEffects(self, owner)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:NPC_SecondaryFire()
    local owner = self:GetOwner()
    local spawnPos = self:GetAttachment(self:LookupAttachment("muzzle_launcher")).Pos
    local projectile = ents.Create(self.NPC_SecondaryFireEnt)
    projectile:SetPos(spawnPos)
    projectile:SetAngles(owner:GetAngles())
    projectile:SetOwner(owner)
    projectile:Spawn()
    projectile:Activate()
    local phys = projectile:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
        if phys:IsGravityEnabled() then
            phys:SetVelocity(VJ.CalculateTrajectory(owner, owner:GetEnemy(), "Curve", projectile:GetPos(), 1, 1))
        else
            phys:SetVelocity(VJ.CalculateTrajectory(owner, owner:GetEnemy(), "Line", projectile:GetPos(), 1, 2000))
        end
        projectile:SetAngles(projectile:GetVelocity():GetNormal():Angle())
    end
end