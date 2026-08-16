include("entities/npc_vj_hlrpar1_medic/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/npc_fsceint.mdl"

ENT.MainSoundPitch = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Voice()
    self.SoundTbl_Idle = {
        "vj_parr/par1/polina/monologue1.wav",
        "vj_parr/par1/polina/monologue2.wav",
        "vj_parr/par1/polina/monologue3.wav",
        "vj_parr/par1/polina/monologue4.wav",
        "vj_parr/par1/polina/monologue5.wav"
    }
    self.SoundTbl_CombatIdle =
        "vj_parr/par1/polina/crying.wav"

    self.SoundTbl_OnPlayerSight = {
        "vj_parr/par1/npc/bunk/polina01.wav",
        "vj_parr/par1/npc/bunk/polina02.wav"
    }
    self.SoundTbl_Death =
        "vj_parr/par1/polina/scream.wav"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Init()
    self:SetBodygroup(1, 1)
end