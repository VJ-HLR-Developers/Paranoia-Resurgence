include("entities/npc_vj_hlrpar2_zarmed/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/v1/monster_soldiershooter.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.Zombie_WepBG = 2
    self.Zombie_WepBGRemove = 2
    if math_random(1, 2) == 1 then self:SetBodygroup(self.Zombie_WepBG, math_random(0, 1)) end
end