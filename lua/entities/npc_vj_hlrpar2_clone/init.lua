include("entities/npc_vj_hlrpar1_clone/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/monster_clonsoldier.mdl"
ENT.BloodParticle = "vj_parr2_blood_red"
ENT.BloodDecal = "VJ_PARR2_Blood_Red"
ENT.AnimTbl_CallForHelp = ACT_SIGNAL2
ENT.GrenadeAttackEntity = "obj_vj_hlrpar2_grenade"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Voice()
    self.SoundTbl_Death = {
        "vj_parr/par2/clone/cl_die1.wav",
        "vj_parr/par2/clone/cl_die2.wav",
        "vj_parr/par2/clone/cl_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par2/clone/cl_pain1.wav",
        "vj_parr/par2/clone/cl_pain2.wav",
        "vj_parr/par2/clone/cl_pain3.wav",
        "vj_parr/par2/clone/cl_pain4.wav",
        "vj_parr/par2/clone/cl_pain5.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self:SetBodygroup(1, math_random(0, 1))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent) return end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKilledEnemy(ent, inflictor, wasLast)
    -- Play an animation upon killing a single known enemy
    if !VJ.AnimExists(self, "victory") then return end
    if wasLast && math_random(1, 3) == 1 then
        self:PlayAnim("victory", "LetAttacks", false, false, 0)
    end
end