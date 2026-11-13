include("entities/npc_vj_hlrpar1_rus_btr90/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/elb_btr80.mdl"

ENT.SoundTbl_Breath = "vj_parr/par2/tanks/elb_engine_loop.wav"
ENT.SoundTbl_Death = "VJ.PARR2_Explosion.Single"

ENT.Tank_GunnerENT = "npc_vj_hlrpar2_rus_btr80_gun"
ENT.Tank_DeathDriverCorpse = {"models/vj_parr/par2/soldier.mdl", "models/vj_parr/par2/early/v1/soldier.mdl"}
ENT.Tank_DeathDecal = "VJ_PARR2_Scorch"

function ENT:Tank_Init()
    self.SoundTbl_Idle = {
        "vj_parr/par2/alpha/soldier/soldier_use1.wav",
        "vj_parr/par2/alpha/soldier/soldier_use2.wav",
        "vj_parr/par2/alpha/soldier/soldier_use6.wav",
        "vj_parr/par2/alpha/soldier/soldier_use7.wav",
        "vj_parr/par2/alpha/soldier/soldier_use8.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par2/alpha/soldier/soldier_enemy11.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy12.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy13.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy14.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy15.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy16.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy17.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy18.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy19.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy20.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy21.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy22.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par2/alpha/soldier/soldier_enemy1.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy2.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy3.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy4.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy5.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy6.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy7.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy8.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy9.wav",
        "vj_parr/par2/alpha/soldier/soldier_enemy10.wav"
    }
    self.SoundTbl_KilledEnemy = {
        "vj_parr/par2/alpha/soldier/soldier_victory1.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory2.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory3.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory4.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory5.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory6.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory7.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory8.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory9.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory10.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory11.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory12.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory13.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory14.wav",
        "vj_parr/par2/alpha/soldier/soldier_victory15.wav"
    }
    self.BTR_Soldiers = {}
end

function ENT:Tank_GunnerSpawnPosition()
    return self:GetPos() + self:GetForward() * 27 + self:GetUp() * 75 + self:GetRight() * 0.5
end

function ENT:Tank_UpdateMoveParticles()
    local spawnPos = self:GetPos() + self:GetForward() * -130
    local effectData = EffectData()
    effectData:SetScale(1)
    effectData:SetEntity(self)
    effectData:SetOrigin(spawnPos + self:GetRight() * 50)
    util.Effect("VJ_VehicleMove", effectData, true, true)
    effectData:SetOrigin(spawnPos + self:GetRight() * -50)
    util.Effect("VJ_VehicleMove", effectData, true, true)
end