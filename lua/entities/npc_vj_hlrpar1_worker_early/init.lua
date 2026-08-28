include("entities/npc_vj_hlrpar1_worker/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_parr/par1/early/worker2.mdl", "models/vj_parr/par1/early/npc_worker_old.mdl"}
ENT.Behavior = VJ_BEHAVIOR_AGGRESSIVE

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Init()
    local myMDL = self:GetModel()
    if myMDL == "models/vj_parr/par1/early/npc_worker_old.mdl" then
        self.Civilian_Type = 4
        self.Weapon_UnarmedBehavior = false
        self:SetBodygroup(3, math_random(0, 1))
        self:SetSkin(math_random(0, 1))
    end
    self:SetBodygroup(1, math_random(0, 2))
    self:SetBodygroup(2, math_random(0, 1))
    if myMDL != "models/vj_parr/par1/early/npc_worker_old.mdl" then self:SetBodygroup(3, math_random(0, 2)) end
end