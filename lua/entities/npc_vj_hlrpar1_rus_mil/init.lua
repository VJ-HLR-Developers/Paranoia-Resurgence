include("entities/npc_vj_hlrpar1_sab_kamov/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/mi24.mdl"
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN"}
ENT.AlliedWithPlayerAllies = true
ENT.BecomeEnemyToPlayer = 2