AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/cut/td_t90_gun.mdl"
ENT.StartHealth = 0
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN_FRIENDLY"}
ENT.AlliedWithPlayerAllies = true
ENT.BecomeEnemyToPlayer = 2
ENT.HasOnPlayerSight = true
ENT.HasDeathCorpse = true

-- Tank Base
ENT.Tank_SoundTbl_Turning = "vj_hlr/gsrc/npc/tanks/bradley_turret_rot.wav"
ENT.Tank_SoundTbl_ReloadShell = "vj_hlr/gsrc/npc/tanks/tank_reload.wav"
ENT.Tank_SoundTbl_FireShell = "vj_hlr/gsrc/npc/tanks/shoot.wav"

ENT.Tank_Shell_SpawnPos = Vector(152, 1.5, 9)
ENT.Tank_Shell_Entity = "obj_vj_hlrpar1_rocket"
ENT.Tank_Shell_VelocitySpeed = 3000
ENT.Tank_Shell_MuzzleFlashPos = Vector(200, 1.5, 9)
ENT.Tank_Shell_ParticlePos = Vector(200, 1.5, 9)