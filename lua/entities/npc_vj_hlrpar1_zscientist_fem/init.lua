include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/savior/zombie_girl.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    -- Getting up animation
    if VJ_CVAR_AI_ENABLED && math_random(1, 3) == 1 then
        timer.Simple(0, function()
            if IsValid(self) then
                self:PlayAnim("slumprise_a", true, false)
                self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
            end
        end)
        timer.Simple(VJ.AnimDuration(self, "slumprise_a"), function()
            if IsValid(self) then
                self:SetState()
            end
        end)
    end
end