include("entities/npc_vj_hlrpar2_rus_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/soldier.mdl"
ENT.StartHealth = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Voice()
    self.SoundTbl_Idle = {
        "vj_parr/par2/alpha/soldier/soldier_use1.wav",
        "vj_parr/par2/alpha/soldier/soldier_use2.wav",
        "vj_parr/par2/alpha/soldier/soldier_use6.wav",
        "vj_parr/par2/alpha/soldier/soldier_use7.wav",
        "vj_parr/par2/alpha/soldier/soldier_use8.wav"
    }
    self.SoundTbl_IdleDialogue = {
        "vj_parr/par2/alpha/soldier/soldier_use3.wav",
        "vj_parr/par2/alpha/soldier/soldier_use4.wav",
        "vj_parr/par2/alpha/soldier/soldier_use5.wav",
        "vj_parr/par2/alpha/soldier/soldier_use9.wav"
    }
    self.SoundTbl_IdleDialogueAnswer = {
        "vj_parr/par2/alpha/soldier/soldier_use10.wav",
        "vj_parr/par2/alpha/soldier/soldier_use11.wav",
        "vj_parr/par2/alpha/soldier/soldier_use12.wav",
        "vj_parr/par2/alpha/soldier/soldier_use13.wav",
        "vj_parr/par2/alpha/soldier/soldier_use14.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par2/alpha/soldier/soldier_enemy11.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy12.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy13.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy14.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy15.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy16.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy17.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy18.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy19.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy20.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy21.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy22.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par2/alpha/soldier/soldier_enemy1.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy2.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy3.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy4.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy5.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy6.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy7.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy8.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy9.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy10.wav"
    }
    self.SoundTbl_KilledEnemy = {
        "vj_parr/par2/alpha/soldier/soldier_victory1.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory2.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory3.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory4.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory5.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory6.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory7.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory8.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory9.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory10.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory11.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory12.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory13.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory14.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory15.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/military/mil_die1.wav",
        "vj_parr/par1/military/mil_die2.wav",
        "vj_parr/par1/military/mil_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/military/mil_pain1.wav",
        "vj_parr/par1/military/mil_pain2.wav",
        "vj_parr/par1/military/mil_pain3.wav",
        "vj_parr/par1/military/mil_pain4.wav",
        "vj_parr/par1/military/mil_pain5.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent) return end