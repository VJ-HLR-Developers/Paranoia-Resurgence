include("entities/npc_vj_hlrpar1_rus_alpha_offd/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/npc_officer_general.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Voice()
    self.SoundTbl_IdleDialogue = {
        "vj_parr/par1/npc/army/dermo2.wav",
        "vj_parr/par1/npc/army/gazmask1.wav",
        "vj_parr/par1/npc/army/gazmask2.wav",
        "vj_parr/par1/npc/army/gazmask3.wav",
        "vj_parr/par1/npc/army/gazmask5.wav",
        "vj_parr/par1/npc/army/gazmask6.wav"
    }
    self.SoundTbl_IdleDialogueAnswer = {
        "vj_parr/par1/general/work1.wav",
        "vj_parr/par1/general/work2.wav",
        "vj_parr/par1/general/work3.wav",
        "vj_parr/par1/general/work4.wav",
        "vj_parr/par1/general/work5.wav"
    }
    self.SoundTbl_Alert =
        "vj_parr/par1/npc/army/dermo1.wav"

    self.SoundTbl_OnPlayerSight =
        "vj_parr/par1/npc/army/gazmask4.wav"

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
function ENT:Civilian_Init()
    self:SetSkin(1)
end