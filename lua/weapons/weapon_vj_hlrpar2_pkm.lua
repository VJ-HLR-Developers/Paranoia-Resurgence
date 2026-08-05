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
SWEP.WorldModel = "models/vj_parr/par2/weapons/world_pkm.mdl"
SWEP.HoldType = "ar2"
    -- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModelOffsetParams = {
    Enabled = true,
    Bone = "Bip01 R Hand",
    Pos = Vector(0, -8, -4.8),
    Ang = Angle(182, -25, 175)
}
    -- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 12
SWEP.Primary.ClipSize = 100
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Sound = "VJ.PARR2_PKM.Single"
SWEP.Primary.TracerType = "VJ_PARR_Tracer"
SWEP.PrimaryEffects_ShellType = "RifleShellEject"
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.DryFireSound = "vj_hlr/gsrc/wep/dryfire1.wav"

-- Custom
local validModels = {
    ["models/vj_parr/par2/monster_clonsoldier.mdl"] = true,
    ["models/vj_parr/par2/monster_soldiershooter.mdl"] = true,
    ["models/vj_parr/par2/monster_soldier_rhb.mdl"] = true,
    ["models/vj_parr/par2/cut/monster_himtrooper.mdl"] = true,
    ["models/vj_parr/par2/cut/soldier_clon_zombied.mdl"] = true,
    ["models/vj_parr/par2/v1/monster_clonsoldier.mdl"] = true,
    ["models/vj_parr/par2/v1/monster_soldiershooter.mdl"] = true
}
SWEP.Reload_Start = "vj_parr/par2/weapons/pkm/pkm_boxout.wav"
SWEP.Reload_Middle = "vj_parr/par2/weapons/pkm/pkm_boxin.wav"
SWEP.Reload_Finish = "vj_parr/par2/weapons/pkm/pkm_slideback1.wav"

local math_random = math.random
local math_rand = math.Rand
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
    timer.Simple(0.1, function()
        if IsValid(self) && IsValid(self:GetOwner()) && VJ.HLR_Weapon_CheckModel(self, validModels) then
            self.NPC_NextPrimaryFire = false
            local ownerMDL = self:GetOwner():GetModel()
            if ownerMDL == "models/vj_parr/par2/monster_soldiershooter.mdl" or ownerMDL == "models/vj_parr/par2/monster_soldier_rhb.mdl" or ownerMDL == "models/vj_parr/par2/v1/monster_soldiershooter.mdl" then
                self.WorldModelOffsetParams,Ang = Angle(182, -28, 175)
                self.WorldModelOffsetParams.Pos = Vector(0, -8, -5.5)
            elseif ownerMDL == "models/vj_parr/par2/v1/monster_clonsoldier.mdl" then
                self.WorldModelOffsetParams.Ang = Angle(180, -22.8, 180)
                self.WorldModelOffsetParams.Pos = Vector(0, -11, -4.8)
            elseif ownerMDL == "models/vj_parr/par2/cut/soldier_clon_zombied.mdl" then
                self.WorldModelOffsetParams.Ang = Angle(180, -20, 180)
                self.WorldModelOffsetParams.Pos = Vector(-1.2, -12, -2.8)
            end
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DoImpactEffect(tr, damageType)
    return VJ.PARR2_Effect_Impact(tr)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnDrawWorldModel()
    return !IsValid(self:GetOwner())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
    local muz = ents.Create("env_sprite")
    muz:SetKeyValue("model", "vj_parr/sprites/muzzleflash2.vmt")
    muz:SetKeyValue("scale", "" .. math_rand(0.2, 0.4))
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