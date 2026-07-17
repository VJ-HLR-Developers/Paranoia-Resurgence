include("entities/npc_vj_hlrpar2_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par2/moster_scientist_male.mdl"
local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.SoundTbl_Alert = {
        "vj_parr/par2/zombie/zo_alert10.wav",
        "vj_parr/par2/zombie/zo_alert20.wav",
        "vj_parr/par2/zombie/zo_alert30.wav"
    }
    self.SoundTbl_BeforeMeleeAttack = {
        "vj_parr/par2/zombie/zo_attack1.wav",
        "vj_parr/par2/zombie/zo_attack2.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par2/zombie/zo_pain1.wav",
        "vj_parr/par2/zombie/zo_pain2.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par2/zombie/zo_pain1.wav",
        "vj_parr/par2/zombie/zo_pain2.wav"
    }
    self:SetBodygroup(1, math_random(0, 1))
end