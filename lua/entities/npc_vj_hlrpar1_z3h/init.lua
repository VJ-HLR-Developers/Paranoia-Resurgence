include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/z_3h.mdl"
ENT.ControllerParams.FirstP_Bone = "Bone09"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    if self:GetModel() == "models/vj_parr/par1/early/zombie.mdl" then
        self.CanFlinch = false
        self.HasDeathAnimation = false
    end
end