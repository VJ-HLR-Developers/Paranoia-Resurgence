include("entities/npc_vj_hlrpar1_worker/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/npc_himik.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Voice()
    self.SoundTbl_Idle = {
        "vj_parr/par1/npc/bunk/suit0.wav",
        "vj_parr/par1/npc/bunk/suit1.wav",
        "vj_parr/par1/npc/bunk/suit2.wav",
        "vj_parr/par1/npc/bunk/suit3.wav",
        "vj_parr/par1/npc/bunk/suit4.wav",
        "vj_parr/par1/npc/bunk/suit5.wav",
        "vj_parr/par1/npc/bunk/suit6.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/military/mil_die1.wav",
        "vj_parr/par1/military/mil_die2.wav",
        "vj_parr/par1/military/mil_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/military/mil_pain1.wav",
        "vj_parr/par1/military/mil_pain2.wav",
        "vj_parr/par1/military/mil_pain3.wav",
        "vj_parr/par1/military/mil_pain4.wav",
        "vj_parr/par1/military/mil_pain5.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Civilian_Init()
    self:SetSkin(math_random(0, 3))
end