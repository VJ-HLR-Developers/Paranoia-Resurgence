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
SWEP.WorldModel = "models/vj_parr/par2/weapons/world_akm.mdl"
SWEP.HoldType = "ar2"
    -- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModelOffsetParams = {
    Enabled = true,
    Bone = "Bip01 R Hand",
    Pos = Vector(2.085, 1.85, 2.341),
    Ang = Angle(-9.128, 24.328, 80.398)
}
    -- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 14
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Sound = "VJ.PARR2_AK74.Single"
SWEP.Primary.TracerType = "VJ_PARR_Tracer"
SWEP.PrimaryEffects_ShellType = "RifleShellEject"
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.DryFireSound = "vj_hlr/gsrc/wep/dryfire1.wav"

-- Custom
local validModels = {
    ["models/vj_parr/par2/monster_soldiershooter.mdl"] = true,
    ["models/vj_parr/par2/monster_soldier_rhb.mdl"] = true,
    ["models/vj_parr/par2/soldier.mdl"] = true,
    ["models/vj_parr/par2/cut/monster_himtrooper.mdl"] = true,
    ["models/vj_parr/par2/cut/monster_himtrooper2.mdl"] = true,
    ["models/vj_parr/par2/cut/soldier_clon_zombied.mdl"] = true,
    ["models/vj_parr/par2/v1/monster_soldiershooter.mdl"] = true
}
SWEP.Reload_Start = "vj_parr/par2/weapons/ak74/ak74_out.wav"
SWEP.Reload_Middle = "vj_parr/par2/weapons/ak74/ak74_in.wav"
SWEP.Reload_Finish = "vj_parr/par2/weapons/ak74/ak74_boltpull.wav"

local math_random = math.random
local math_rand = math.Rand
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
    timer.Simple(0.1, function()
        if IsValid(self) && IsValid(self:GetOwner()) && VJ.HLR_Weapon_CheckModel(self, validModels) then
            self.NPC_NextPrimaryFire = false
            local ownerMDL = self:GetOwner():GetModel()
            if ownerMDL == "models/vj_parr/par2/cut/monster_himtrooper.mdl" or ownerMDL == "models/vj_parr/par2/cut/monster_himtrooper2.mdl" then
                self.WorldModelOffsetParams.Ang = Angle(-9.128, 24.328, 80.398)
                self.WorldModelOffsetParams.Pos = Vector(4.101, 1.808, 0.47)
            elseif ownerMDL == "models/vj_parr/par2/cut/soldier_clon_zombied.mdl" then
                self.WorldModelOffsetParams.Ang = Angle(-9.391, 20.284, 86.549)
                self.WorldModelOffsetParams.Pos = Vector(7.456, 1.984, 2.584)
            elseif ownerMDL == "models/vj_parr/par2/soldier.mdl" then
                self.WorldModelOffsetParams.Bone = "bip01_r_hand"
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
    muz:Fire("Kill", nil, 0.08)
    self.BaseClass.PrimaryAttackEffects(self, owner)
end