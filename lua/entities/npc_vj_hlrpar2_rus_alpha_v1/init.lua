include("entities/npc_vj_hlrpar2_rus_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/early/v1/player2.mdl"
ENT.GrenadeAttackAttachment = "lhand"
ENT.AnimTbl_TakingCover = ACT_CROUCHIDLE
ENT.AnimTbl_Flinch = false
ENT.FlinchHitGroupMap = false
ENT.HasDeathAnimation = false
ENT.SoundTbl_MeleeAttackExtra = {"vj_parr/par1/weapons/machete_hit1.wav", "vj_parr/par1/weapons/machete_hit2.wav", "vj_parr/par1/weapons/machete_hit3.wav", "vj_parr/par1/weapons/machete_hit4.wav"}