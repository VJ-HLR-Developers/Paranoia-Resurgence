include("entities/npc_vj_hlrpar2_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/moster_scientist_male.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    -- Getting up animation
    if VJ_CVAR_AI_ENABLED && math_random(1, 3) == 1 then
        local anim = VJ.PICK({"scen_eating_out", "scen_holeoff"})
        timer.Simple(0, function()
            if IsValid(self) then
                self:PlayAnim(anim, true, false)
                self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
            end
        end)
        timer.Simple(VJ.AnimDuration(self, anim), function()
            if IsValid(self) then
                self:SetState()
            end
        end)
    end
    //self.CanEat = true
    self:SetBodygroup(1, math_random(0, 1))
end