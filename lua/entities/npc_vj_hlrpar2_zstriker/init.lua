include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par2/monster_boss.mdl"
ENT.StartHealth = 800
ENT.ControllerParams.FirstP_Bone = "Bip02 Head"

ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTARM, Animation = ACT_FLINCH_LEFTARM}, {HitGroup = HITGROUP_RIGHTARM, Animation = ACT_FLINCH_RIGHTARM}}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.SoundTbl_Alert = {
        "vj_parr/par2/monsters/boss/striker_alert1.wav",
        "vj_parr/par2/monsters/boss/striker_alert2.wav"
    }
    self.SoundTbl_BeforeMeleeAttack = {
        "vj_parr/par2/monsters/boss/striker_attack1.wav",
        "vj_parr/par2/monsters/boss/striker_attack2.wav"
    }
    self.SoundTbl_Death =
        "vj_parr/par2/bes/bes_death.wav"

    self.SoundTbl_Pain = {
        "vj_parr/par2/monsters/boss/striker_pain1.wav",
        "vj_parr/par2/monsters/boss/striker_pain2.wav",
        "vj_parr/par2/monsters/boss/striker_pain3.wav"
    }
    self:SetCollisionBounds(Vector(35, 35, 110), Vector(-35, -35, 0))
end