AddCSLuaFile()

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "AKS"
SWEP.Author = "Darkborn"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category = "Paranoia Resurgence"
    -- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = false
SWEP.NPC_ReloadSound = "vj_hlr/null.wav"
SWEP.NPC_CanBePickedUp = false
    -- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly = true
SWEP.WorldModel = "models/vj_parr/par2/weapons/world_aks.mdl"
SWEP.HoldType = "ar2"
    -- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(190, -25, 80)
SWEP.WorldModel_CustomPositionOrigin = Vector(1.5, -12.5, 0.5)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"
    -- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 12
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Sound = "VJ.PARR2_AKS.Single"
SWEP.Primary.TracerType = "VJ_PARR_Tracer"
SWEP.PrimaryEffects_ShellType = "RifleShellEject"
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.DryFireSound = "vj_hlr/gsrc/wep/dryfire1.wav"

-- Custom
local validModels = {
    ["models/vj_parr/par2/monster_clonsoldier.mdl"] = true,
    ["models/vj_parr/par2/soldier_alpha.mdl"] = true,
    ["models/vj_parr/par2/v1/monster_clonsoldier.mdl"] = true
}
SWEP.Reload_Start = "vj_parr/par2/weapons/aks/aks_out.wav"
SWEP.Reload_Middle = "vj_parr/par2/weapons/aks/aks_in.wav"
SWEP.Reload_Finish = "vj_parr/par2/weapons/aks/aks_boltpull.wav"

local math_random = math.random
local math_rand = math.Rand
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
    timer.Simple(0.1, function()
        if IsValid(self) && IsValid(self:GetOwner()) && VJ.HLR_Weapon_CheckModel(self, validModels) then
            self.NPC_NextPrimaryFire = false
            local ownerMDL = self:GetOwner():GetModel()
            if ownerMDL == "models/vj_parr/par2/v1/monster_clonsoldier.mdl" then
                self.WorldModel_CustomPositionAngle = Vector(190, -23, 85)
                self.WorldModel_CustomPositionOrigin = Vector(1, -14, 0)
            elseif ownerMDL == "models/vj_parr/par2/soldier.mdl" or ownerMDL == "models/vj_parr/par2/soldier_alpha.mdl" then
                self.WorldModel_CustomPositionBone = "bip01_r_hand"
            end
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