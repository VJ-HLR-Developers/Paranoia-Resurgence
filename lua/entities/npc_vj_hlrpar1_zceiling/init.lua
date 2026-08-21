include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/zombie_c.mdl"
ENT.StartHealth = 300
ENT.ControllerParams.FirstP_Bone = "Bip01 Head"

ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTARM, Animation = ACT_FLINCH_LEFTARM}, {HitGroup = HITGROUP_RIGHTARM, Animation = ACT_FLINCH_RIGHTARM}}

ENT.SoundTbl_FootStep = {"vj_parr/par1/player/pl_wood_scr1.wav", "vj_parr/par1/player/pl_wood_scr2.wav", "vj_parr/par1/player/pl_wood_scr3.wav", "vj_parr/par1/player/pl_wood_scr4.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Voice()
    self.SoundTbl_Alert = {
        "vj_parr/par1/potolo4nik/zo_alert10.wav",
        "vj_parr/par1/potolo4nik/zo_alert20.wav",
        "vj_parr/par1/potolo4nik/zo_alert30.wav"
    }
    self.SoundTbl_BeforeMeleeAttack = {
        "vj_parr/par1/potolo4nik/zo_attack1.wav",
        "vj_parr/par1/potolo4nik/zo_attack2.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/potolo4nik/zo_pain1.wav",
        "vj_parr/par1/potolo4nik/zo_pain2.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/potolo4nik/zo_pain1.wav",
        "vj_parr/par1/potolo4nik/zo_pain2.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self:SetCollisionBounds(Vector(18, 18, 80), Vector(-18, -18, 0))
end