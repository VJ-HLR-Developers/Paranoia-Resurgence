include("entities/npc_vj_hlrpar1_terrorist/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/cut/terror_shahid.mdl"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self.SoundTbl_Idle = {
        "vj_parr/par1/terror/idle1.wav",
        "vj_parr/par1/terror/idle2.wav",
        "vj_parr/par1/terror/idle3.wav",
        "vj_parr/par1/terror/idle4.wav",
        "vj_parr/par1/terror/idle5.wav",
        "vj_parr/par1/terror/vrag1.wav",
        "vj_parr/par1/terror/vrag2.wav",
        "vj_parr/par1/terror/vrag3.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/terror/allah_akbar1.wav",
        "vj_parr/par1/terror/allah_akbar2.wav",
        "vj_parr/par1/terror/allah_akbar3.wav",
        "vj_parr/par1/terror/allah_akbar4.wav",
        "vj_parr/par1/terror/allah_akbar5.wav",
        "vj_parr/par1/terror/sdavaysa1.wav",
        "vj_parr/par1/terror/sdavaysa2.wav",
        "vj_parr/par1/terror/sdavaysa3.wav",
        "vj_parr/par1/terror/yruss1.wav",
        "vj_parr/par1/terror/yruss2.wav"
    }
    self.SoundTbl_Investigate = {
        "vj_parr/par1/terror/aha1.wav",
        "vj_parr/par1/terror/aha2.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par1/terror/allah_akbar1.wav",
        "vj_parr/par1/terror/allah_akbar2.wav",
        "vj_parr/par1/terror/allah_akbar3.wav",
        "vj_parr/par1/terror/allah_akbar4.wav",
        "vj_parr/par1/terror/allah_akbar5.wav",
        "vj_parr/par1/terror/sdavaysa1.wav",
        "vj_parr/par1/terror/sdavaysa2.wav",
        "vj_parr/par1/terror/sdavaysa3.wav",
        "vj_parr/par1/terror/yruss1.wav",
        "vj_parr/par1/terror/yruss2.wav"
    }
    self.SoundTbl_KilledEnemy =
        "vj_parr/par1/terror/yahoo.wav"

    self.SoundTbl_LostEnemy = {
        "vj_parr/par1/terror/taunt1.wav",
        "vj_parr/par1/terror/taunt2.wav",
        "vj_parr/par1/terror/taunt3.wav",
        "vj_parr/par1/terror/taunt4.wav",
        "vj_parr/par1/terror/taunt5.wav",
        "vj_parr/par1/terror/taunt6.wav",
        "vj_parr/par1/terror/taunt8.wav"
    }
    self.SoundTbl_GrenadeAttack = {
        "vj_parr/par1/terror/brosokgranata1.wav",
        "vj_parr/par1/terror/brosokgranata2.wav",
        "vj_parr/par1/terror/brosokgranata3.wav"
    }
    self.SoundTbl_GrenadeSight = {
        "vj_parr/par1/terror/granata1.wav",
        "vj_parr/par1/terror/granata2.wav"
    }
    self.SoundTbl_DangerSight = {
        "vj_parr/par1/terror/ykritie1.wav",
        "vj_parr/par1/terror/ykritie2.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/terror/ter_die1.wav",
        "vj_parr/par1/terror/ter_die2.wav",
        "vj_parr/par1/terror/ter_die3.wav",
        "vj_parr/par1/terror/ter_die4.wav",
        "vj_parr/par1/terror/ter_die5.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/terror/ter_pain1.wav",
        "vj_parr/par1/terror/ter_pain2.wav",
        "vj_parr/par1/terror/ter_pain3.wav",
        "vj_parr/par1/terror/ter_pain4.wav",
        "vj_parr/par1/terror/ter_pain5.wav"
    }
end