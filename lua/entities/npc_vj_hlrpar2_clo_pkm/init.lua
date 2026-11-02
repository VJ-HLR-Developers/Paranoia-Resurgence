include("entities/npc_vj_hlrpar2_rus_pkm/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/mgun_clone.mdl"
ENT.VJ_NPC_Class = {"CLASS_CLONE"}
ENT.AlliedWithPlayerAllies = false
ENT.BecomeEnemyToPlayer = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PreInit()
    if GetConVar("VJ_PARR_Friendly_Clones"):GetInt() == 1 then
        self.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN_FRIENDLY"}
        self.AlliedWithPlayerAllies = true
        self.BecomeEnemyToPlayer = 2
    end
end