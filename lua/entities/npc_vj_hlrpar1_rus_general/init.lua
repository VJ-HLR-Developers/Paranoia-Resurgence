include("entities/npc_vj_hlrpar1_rus_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/cut/general_pistol.mdl"
ENT.StartHealth = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self.SoundTbl_IdleDialogue =
        "vj_parr/par1/npc/army/dermo2.wav"

    self.SoundTbl_IdleDialogueAnswer = {
        "vj_parr/par1/general/work1.wav",
        "vj_parr/par1/general/work2.wav",
        "vj_parr/par1/general/work3.wav",
        "vj_parr/par1/general/work4.wav",
        "vj_parr/par1/general/work5.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par1/npc/army/dermo1.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/military/mil_die1.wav",
        "vj_parr/par1/military/mil_die2.wav",
        "vj_parr/par1/military/mil_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/npc/army/dermo1.wav",
        "vj_parr/par1/military/mil_pain1.wav",
        "vj_parr/par1/military/mil_pain2.wav",
        "vj_parr/par1/military/mil_pain3.wav",
        "vj_parr/par1/military/mil_pain4.wav",
        "vj_parr/par1/military/mil_pain5.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent) return end