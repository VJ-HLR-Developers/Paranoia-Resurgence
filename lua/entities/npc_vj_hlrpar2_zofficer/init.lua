include("entities/npc_vj_hlrpar2_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/cut/monster_superofficer.mdl"
ENT.StartHealth = 300

ENT.HasRangeAttack = true
ENT.RangeAttackProjectiles = "obj_vj_hlr1_gonomegut"
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
ENT.RangeAttackMaxDistance = 784
ENT.RangeAttackMinDistance = 200
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.NextRangeAttackTime = 6

ENT.HasLeapAttack = true
ENT.LeapAttackDamage = 30
ENT.AnimTbl_LeapAttack = ACT_SPECIAL_ATTACK1
ENT.LeapAttackMaxDistance = 200
ENT.LeapAttackMinDistance = 100
ENT.LeapAttackDamageDistance = 100
ENT.TimeUntilLeapAttackDamage = 0.4
ENT.TimeUntilLeapAttackVelocity = 0
ENT.NextLeapAttackTime = 1
ENT.NextAnyAttackTime_Leap = 1
ENT.LeapAttackStopOnHit = true

ENT.FlinchHitGroupMap = false

ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIESIMPLE}

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self:SetBodygroup(1, math_random(0, 3))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    -- Hurt Walking
    if act == ACT_WALK then
        if self:Health() <= (self:GetMaxHealth() / 2.2) then
            return ACT_WALK_HURT
        end
    end
    return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjPos(projectile)
    return self:GetAttachment(self:LookupAttachment("mouth")).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjVel(projectile)
    return VJ.CalculateTrajectory(self, self:GetEnemy(), "Curve", projectile:GetPos(), 1, 10)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnLeapAttack(status, enemy)
    if status == "Jump" then
        return VJ.CalculateTrajectory(self, enemy, "Curve", self:GetPos() + self:OBBCenter(), enemy:GetPos() + enemy:OBBCenter(), 25) + self:GetForward() * 80
    end
end