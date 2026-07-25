include("entities/npc_vj_hlrpar1_worker/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/npc_medic.mdl"

ENT.Civilian_Type = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Init()
    self.SoundTbl_Idle = {
        "vj_parr/par1/medic/monologue1.wav",
        "vj_parr/par1/medic/monologue2.wav",
        "vj_parr/par1/medic/monologue3.wav",
        "vj_parr/par1/medic/monologue4.wav",
        "vj_parr/par1/medic/monologue5.wav",
        "vj_parr/par1/medic/monologue6.wav",
        "vj_parr/par1/medic/monologue7.wav"
    }
    self.SoundTbl_IdleDialogueAnswer = {
        "vj_parr/par1/medic/ok1.wav",
        "vj_parr/par1/medic/ok2.wav",
        "vj_parr/par1/medic/ok3.wav",
        "vj_parr/par1/medic/ok4.wav",
        "vj_parr/par1/medic/ok5.wav",
        "vj_parr/par1/medic/work1.wav",
        "vj_parr/par1/medic/work2.wav",
        "vj_parr/par1/medic/work3.wav",
        "vj_parr/par1/medic/work4.wav",
        "vj_parr/par1/medic/work5.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/medic/fear1.wav",
        "vj_parr/par1/medic/fear2.wav",
        "vj_parr/par1/medic/fear3.wav",
        "vj_parr/par1/medic/fear4.wav",
        "vj_parr/par1/medic/fear5.wav"
    }
    self.SoundTbl_OnPlayerSight = {
        "vj_parr/par1/medic/hello1.wav",
        "vj_parr/par1/medic/hello2.wav",
        "vj_parr/par1/medic/hello3.wav"
    }
    self.SoundTbl_YieldToPlayer = {
        "vj_parr/par1/medic/blocked1.wav",
        "vj_parr/par1/medic/blocked2.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par1/medic/fear1.wav",
        "vj_parr/par1/medic/fear2.wav",
        "vj_parr/par1/medic/fear3.wav",
        "vj_parr/par1/medic/fear4.wav",
        "vj_parr/par1/medic/fear5.wav"
    }
    self.SoundTbl_Death =
        "vj_parr/par1/polina/scream.wav"

    self.SoundTbl_Pain = {
        "vj_parr/par1/medic/hit1.wav",
        "vj_parr/par1/medic/hit2.wav",
        "vj_parr/par1/medic/hit3.wav"
    }
end