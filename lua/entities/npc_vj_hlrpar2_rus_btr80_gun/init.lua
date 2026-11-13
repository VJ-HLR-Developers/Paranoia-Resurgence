include("entities/npc_vj_hlrpar1_rus_btr90_gun/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/elb_btr80_gun.mdl"
ENT.StartHealth = 0
ENT.HasDeathCorpse = false

ENT.Tank_Shell_SpawnPos = Vector(56, 0, 7)
ENT.Tank_Shell_VelocitySpeed = 3000
ENT.Tank_Shell_MuzzleFlashPos = Vector(56, 0, 7)
ENT.Tank_Shell_ParticlePos = Vector(56, 0, 7)

function ENT:Tank_Init() return end

function ENT:Tank_OnThinkActive() return end

function ENT:DoImpactEffect(tr, damageType)
    return VJ.PARR2_Effect_Impact(tr)
end