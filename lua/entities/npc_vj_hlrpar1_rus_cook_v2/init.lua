include("entities/npc_vj_hlrpar1_rus_cook/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/early/v2/npc_cooker.mdl"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Init()
    self:SetBodygroup(1, 1)
end