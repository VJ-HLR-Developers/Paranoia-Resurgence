include("entities/npc_vj_hlrpar1_medic/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/cut/medic_old.mdl"
ENT.Medic_TimeUntilHeal = false
ENT.AnimTbl_Medic_GiveHealth = ACT_OPEN_DOOR
ENT.HasDeathAnimation = true