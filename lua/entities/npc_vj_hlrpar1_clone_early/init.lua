include("entities/npc_vj_hlrpar1_clone/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/early/soldier_colba.mdl"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self.SoundTbl_Death = {
        "vj_parr/par1/clone/cl_die1.wav",
        "vj_parr/par1/clone/cl_die2.wav",
        "vj_parr/par1/clone/cl_die3.wav",
        "vj_parr/par1/clone/cl_die4.wav",
        "vj_parr/par1/clone/cl_die5.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/clone/cl_pain1.wav",
        "vj_parr/par1/clone/cl_pain2.wav",
        "vj_parr/par1/clone/cl_pain3.wav",
        "vj_parr/par1/clone/cl_pain4.wav",
        "vj_parr/par1/clone/cl_pain5.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent) return end