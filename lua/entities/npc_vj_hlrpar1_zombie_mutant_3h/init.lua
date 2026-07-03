include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/z_3h.mdl"

ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.SoundTbl_Alert = {
        "vj_parr/par1/zombie/zo_alert10.wav",
        "vj_parr/par1/zombie/zo_alert20.wav",
        "vj_parr/par1/zombie/zo_alert30.wav"
    }
    self.SoundTbl_BeforeMeleeAttack = {
        "vj_parr/par1/zombie/zo_attack1.wav",
        "vj_parr/par1/zombie/zo_attack2.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/zombie/zo_pain1.wav",
        "vj_parr/par1/zombie/zo_pain2.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/zombie/zo_pain1.wav",
        "vj_parr/par1/zombie/zo_pain2.wav"
    }
end