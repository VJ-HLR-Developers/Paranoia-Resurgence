include("entities/npc_vj_hlrpar1_worker/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/early/v1/hazmat.mdl"
ENT.ControllerParams.FirstP_Bone = "bip01_head"
ENT.BloodParticle = "vj_parr2_blood_red"
ENT.BloodDecal = "VJ_PARR2_Blood_Red"
ENT.MainSoundPitch = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Init() return end