include("entities/npc_vj_hlrpar1_civilian/init.lua")
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
function ENT:Civilian_Init()
    self.SoundTbl_Idle = {
        "vj_parr/par1/npc/bunk/prof_idle1.wav",
        "vj_parr/par1/npc/bunk/prof_idle2.wav",
        "vj_parr/par1/npc/bunk/prof_idle3.wav",
        "vj_parr/par1/npc/bunk/prof_idle4.wav",
        "vj_parr/par1/npc/bunk/prof_idle5.wav",
        "vj_parr/par1/npc/bunk/prof_idle6.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/npc/indust/worker0.wav",
        "vj_parr/par1/npc/indust/worker1.wav",
        "vj_parr/par1/npc/indust/worker2.wav",
        "vj_parr/par1/npc/indust/worker3.wav",
        "vj_parr/par1/npc/indust/worker4.wav",
        "vj_parr/par1/npc/indust/worker5.wav"
    }
    self.SoundTbl_OnPlayerSight = {
        "vj_parr/par1/npc/bunk/prof_hello1.wav",
        "vj_parr/par1/npc/bunk/prof_hello2.wav",
        "vj_parr/par1/npc/bunk/prof_hello3.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par1/npc/indust/worker0.wav",
        "vj_parr/par1/npc/indust/worker1.wav",
        "vj_parr/par1/npc/indust/worker2.wav",
        "vj_parr/par1/npc/indust/worker3.wav",
        "vj_parr/par1/npc/indust/worker4.wav",
        "vj_parr/par1/npc/indust/worker5.wav"
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
    self:SetSkin(math_random(0, 3))
end