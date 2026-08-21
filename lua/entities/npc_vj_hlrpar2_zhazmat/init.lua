include("entities/npc_vj_hlrpar2_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/monster_deadhazmat.mdl"
ENT.FlinchHitGroupMap = false

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self:SetSkin(math_random(0, 1))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    local npcState = self:GetNPCState()
    if act == ACT_IDLE && (npcState == NPC_STATE_ALERT or npcState == NPC_STATE_COMBAT) then
        return ACT_IDLE_ANGRY
    end
    return self.BaseClass.TranslateActivity(self, act)
end