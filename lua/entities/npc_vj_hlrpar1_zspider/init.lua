include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/vj_parr/par1/spider.mdl", "models/vj_parr/par1/early/spider_v2.mdl"}
ENT.StartHealth = 400
ENT.ControllerParams.FirstP_Bone = "Bone64"

ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTARM, Animation = ACT_FLINCH_LEFTARM}, {HitGroup = HITGROUP_RIGHTARM, Animation = ACT_FLINCH_RIGHTARM}}

ENT.SoundTbl_FootStep = {"vj_parr/par1/player/pl_wood_scr1.wav", "vj_parr/par1/player/pl_wood_scr2.wav", "vj_parr/par1/player/pl_wood_scr3.wav", "vj_parr/par1/player/pl_wood_scr4.wav"}

-- Custom
ENT.Spider_EyeOpen = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.SoundTbl_BeforeMeleeAttack = {
        "vj_parr/par1/spider/zo_attack1.wav",
        "vj_parr/par1/spider/zo_attack2.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/spider/zo_pain1.wav",
        "vj_parr/par1/spider/zo_pain2.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/spider/zo_pain1.wav",
        "vj_parr/par1/spider/zo_pain2.wav"
    }
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/early/spider_v1.mdl" or myMDL == "models/vj_parr/par1/early/spider_v2.mdl" then
        self.AnimTbl_Death = ACT_DIEBACKWARD
    elseif myMDL == "models/vj_parr/par1/early/spider_v1.mdl" then
        self.CanFlinch = false
    end
    self:SetCollisionBounds(Vector(20, 20, 75), Vector(-20, -20, 0))
end