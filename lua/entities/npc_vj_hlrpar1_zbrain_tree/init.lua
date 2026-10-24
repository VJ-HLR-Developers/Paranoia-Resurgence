AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/brain_tree.mdl"
ENT.VJ_ID_Boss = true
ENT.StartHealth = 500
ENT.GodMode = true
ENT.HullType = HULL_HUMAN
ENT.SightAngle = 360
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.ControllerParams = {
    ThirdP_Offset = Vector(30, 25, -50),
    FirstP_Bone = "Bone01",
    FirstP_Offset = Vector(3, 0, 5)
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr1_blood_red"
ENT.BloodDecal = "VJ_PARR1_Blood_Red"
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}

ENT.HasMeleeAttack = false

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = ACT_DIESIMPLE

ENT.DeathAnimationDecreaseLengthAmount = -1
ENT.DeathCorpseEntityClass = "prop_vj_animatable"

ENT.SoundTbl_Breath = "vj_parr/par1/brain/deadsignal_goaway.wav"
ENT.SoundTbl_Death = {"vj_parr/par1/brain/brain_dead1.wav", "vj_parr/par1/brain/brain_dead2.wav", "vj_parr/par1/brain/brain_dead3.wav", "vj_parr/par1/brain/brain_dead4.wav"}
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}

ENT.MainSoundPitch = 100

ENT.BreathSoundLevel = 80
ENT.DeathSoundLevel = 80

-- Custom
ENT.Brain_Ent = NULL
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self:SetName("Zombie Brain Tree")
    self:AddFlags(FL_NOTARGET)
    self:SetCollisionBounds(Vector(50, 50, 320), Vector(-50, -50, 0))
    self:SetSurroundingBounds(Vector(250, 250, 500), Vector(-250, -250, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
    if status == "Init" then
        -- Make it immune to DMG_NERVEGAS, based on source code
        if dmginfo:IsDamageType(DMG_NERVEGAS) then
            dmginfo:SetDamage(0)
        end
    elseif status == "PreDamage" then
        -- Take 30% of bullet damage, based on source code
        if dmginfo:IsBulletDamage() then
            dmginfo:ScaleDamage(0.3)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    local brainEnt = self.Brain_Ent
    if status == "Init" && IsValid(brainEnt) then
        self:SetParent(NULL)
        self:SetPos(self:GetPos() + self:GetUp() * -4)
        timer.Simple(0, function() if IsValid(self) then self:SetParent(brainEnt) end end)
    elseif status == "Finish" && IsValid(brainEnt) then
        brainEnt.GodMode = false
        brainEnt:TakeDamage(brainEnt:Health(), brainEnt, brainEnt)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    corpse:ResetSequence(self:GetSequence())
    corpse:SetCycle(1)
    corpse:SetMoveType(self:GetMoveType())
    corpse:SetCollisionGroup(self.DeathCorpseCollisionType)
    local minBounds, maxBounds = self:GetCollisionBounds()
    corpse:SetCollisionBounds(Vector(minBounds.x, maxBounds.y, 5), Vector(-minBounds.x, -maxBounds.y, 0))
    corpse:SetSurroundingBounds(Vector(minBounds.x * 100, maxBounds.y * 100, 5 * 100), Vector(-minBounds.x * 100, -maxBounds.y * 100, 0))

    if IsValid(self.Brain_Ent) then
        corpse.Brain_Ent = self.Brain_Ent
        corpse:SetParent(corpse.Brain_Ent)
        corpse:SetPos(self:GetPos())
    end

    VJ.HLR_ApplyCorpseSystem(self, corpse, nil, {Gibbable = false})
end