include("entities/npc_vj_hlrpar2_zarmed/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par2/v1/monster_soldiershooter.mdl"
ENT.HasMeleeAttack = false

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.SoundTbl_Death = {
        "vj_parr/par2/clone/cl_die1.wav",
        "vj_parr/par2/clone/cl_die2.wav",
        "vj_parr/par2/clone/cl_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par2/clone/cl_pain1.wav",
        "vj_parr/par2/clone/cl_pain2.wav",
        "vj_parr/par2/clone/cl_pain3.wav",
        "vj_parr/par2/clone/cl_pain4.wav",
        "vj_parr/par2/clone/cl_pain5.wav"
    }
    self.Zombie_WepBG = 2
    self.Zombie_WepBGRemove = 1
end