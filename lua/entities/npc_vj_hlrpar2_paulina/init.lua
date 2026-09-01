include("entities/npc_vj_hlrpar1_medic/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/char_polina.mdl"
ENT.BloodParticle = "vj_parr2_blood_red"
ENT.BloodDecal = "VJ_PARR2_Blood_Red"
ENT.IsMedic = false
ENT.HasDeathAnimation = true
ENT.MainSoundPitch = 100
-- Custom
ENT.Civilian_Type = 2
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Voice()
    self.SoundTbl_Idle = {
        "vj_parr/par2/scenaric/polina/polina_krot17_1b.wav",
        "vj_parr/par2/scenaric/polina/polina_lift_sav18.wav",
        "vj_parr/par2/scenaric/polina/polina_monologue_0.wav",
        "vj_parr/par2/scenaric/polina/polina_monologue_1.wav",
        "vj_parr/par2/scenaric/polina/polina_monologue_4.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par2/scenaric/polina/polina_crying.wav",
        "vj_parr/par2/scenaric/polina/polina_monologue_2.wav",
        "vj_parr/par2/scenaric/polina/polina_monologue_3.wav",
        "vj_parr/par2/scenaric/polina/polina_monologue_5.wav"
    }
    self.SoundTbl_OnPlayerSight =
        "vj_parr/par2/scenaric/polina/polina_krot17_1.wav"

    self.SoundTbl_Death =
        "vj_parr/par2/scenaric/polina/scream.wav"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Init() return end