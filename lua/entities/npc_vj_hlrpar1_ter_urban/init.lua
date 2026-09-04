include("entities/npc_vj_hlrpar1_terrorist/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/cut/vts_urban_terrorist.mdl"
ENT.GrenadeAttackAttachment = "lhand"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init() return end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKilledEnemy(ent, inflictor, wasLast)
    -- Play an animation upon killing a single known enemy
    if wasLast && math_random(1, 3) == 1 then
        self:PlayAnim("victorydance", "LetAttacks", false, false, 0)
    end
end