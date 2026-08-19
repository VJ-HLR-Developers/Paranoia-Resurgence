AddCSLuaFile()

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "PKM"
SWEP.Author = "Darkborn"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category = "Paranoia Resurgence"
    -- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = false
SWEP.NPC_ReloadSound = "vj_hlr/null.wav"
SWEP.NPC_CanBePickedUp = false
    -- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly = true
SWEP.WorldModel = "models/vj_parr/par1/weapons/w_rpk.mdl"
SWEP.HoldType = "ar2"
    -- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModelOffsetParams = {
    Enabled = true,
    Bone = "Bip01 R Hand",
    Pos = Vector(5.383, 4.496, -6.619),
    Ang = Angle(14.165, 19.62, 4.986)
}
    -- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 12
SWEP.Primary.ClipSize = 100
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Sound = "VJ.PARR1_PKM.Single"
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
    ["models/vj_parr/par1/cut/terror_shahid.mdl"] = true,
    ["models/vj_parr/par1/early/soldier_clon_heavy.mdl"] = true,
    ["models/vj_parr/par1/early/soldier_colba.mdl"] = true,
    ["models/vj_parr/par1/early/terror_old.mdl"] = true
}
SWEP.Reload_Start = "vj_parr/par1/weapons/pkm/pkm_boxout.wav"
SWEP.Reload_Middle = "vj_parr/par1/weapons/pkm/pkm_boxin.wav"
SWEP.Reload_Finish = "vj_parr/par1/weapons/pkm/pkm_slideback1.wav"

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
    muz:Fire("Kill", nil, 0.08)
    self.BaseClass.PrimaryAttackEffects(self, owner)
end