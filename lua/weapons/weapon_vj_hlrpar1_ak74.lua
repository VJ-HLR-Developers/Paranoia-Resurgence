AddCSLuaFile()

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "AK-74"
SWEP.Author = "Darkborn"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category = "Paranoia Resurgence"
    -- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = false
SWEP.NPC_ReloadSound = "vj_hlr/null.wav"
SWEP.NPC_CanBePickedUp = false
    -- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly = true
SWEP.WorldModel = "models/vj_parr/par1/weapons/w_ak74.mdl"
SWEP.HoldType = "ar2"
    -- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(180, 163, 90)
SWEP.WorldModel_CustomPositionOrigin = Vector(2, 8, -0.5)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"
    -- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 12
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Sound = "VJ.PARR1_AK74.Single"
SWEP.Primary.TracerType = "VJ_PARR_Tracer"
SWEP.PrimaryEffects_ShellType = "RifleShellEject"
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.DryFireSound = "vj_hlr/gsrc/wep/dryfire1.wav"

-- Custom
local validModels = {
    ["models/vj_parr/par1/soldier.mdl"] = true,
    ["models/vj_parr/par1/soldier_clon.mdl"] = true,
    ["models/vj_parr/par1/soldier_clon_bio.mdl"] = true,
    ["models/vj_parr/par1/soldier_clon_heavy.mdl"] = true,
    ["models/vj_parr/par1/terror.mdl"] = true,
    ["models/vj_parr/par1/cut/soldier_beret.mdl"] = true,
    ["models/vj_parr/par1/cut/soldier_gru.mdl"] = true,
    ["models/vj_parr/par1/cut/terror_shahid.mdl"] = true,
    ["models/vj_parr/par1/early/soldier.mdl"] = true,
    ["models/vj_parr/par1/early/v2/soldier.mdl"] = true,
    ["models/vj_parr/par1/early/soldier_clon_heavy.mdl"] = true,
    ["models/vj_parr/par1/early/soldier_colba.mdl"] = true,
    ["models/vj_parr/par1/early/terror_old.mdl"] = true
}
SWEP.Reload_Start = "vj_parr/par1/weapons/aks/AKS_OUT.WAV"
SWEP.Reload_Middle = "vj_parr/par1/weapons/aks/AKS_IN.WAV"
SWEP.Reload_Finish = "vj_parr/par1/weapons/aks/AKS_01.WAV"

local math_random = math.random
local math_rand = math.Rand
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
    return VJ.PARR1_Effect_Impact(tr)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnDrawWorldModel()
    return !IsValid(self:GetOwner())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
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
    muz:Fire("SetParentAttachment", self.PrimaryEffects_MuzzleAttachment)
    muz:SetAngles(Angle(math_random(-100, 100), math_random(-100, 100), math_random(-100, 100)))
    muz:Spawn()
    muz:Activate()
    muz:Fire("Kill", "", 0.08)
    self.BaseClass.PrimaryAttackEffects(self, owner)
end