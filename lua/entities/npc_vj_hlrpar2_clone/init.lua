include("entities/npc_vj_hlrpar1_clone/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par2/monster_clonsoldier.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
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
    self:SetBodygroup(1, math_random(0, 1))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent) return end