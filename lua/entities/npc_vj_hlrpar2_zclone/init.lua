include("entities/npc_vj_hlrpar2_zarmed/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/cut/soldier_clon_zombied.mdl"
ENT.StartHealth = 300
ENT.AnimTbl_CallForHelp = false
ENT.AnimTbl_TakingCover = ACT_CROUCHIDLE

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    self.Zombie_WepBG = 2
    self.Zombie_WepBGRemove = 2
    self:SetBodygroup(1, math_random(0, 1))
    if math_random(1, 2) == 1 then self:SetBodygroup(self.Zombie_WepBG, math_random(0, 1)) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "DeathAnim" then
        if math_random(1, 2) == 1 then
            self:DeathWeaponDrop(dmginfo, hitgroup)
            self:OnDeath(dmginfo, hitgroup, "Finish")
            return
        end
        timer.Simple(0.5, function()
            if IsValid(self) then
                self:DeathWeaponDrop(dmginfo, hitgroup)
                self:OnDeath(dmginfo, hitgroup, "Finish")
            end
        end)
    elseif status == "Finish" then
        -- Remove the weapon body groups and other objects
        self:SetBodygroup(self.Zombie_WepBG, self.Zombie_WepBGRemove)
    end
    baseclass.Get("npc_vj_hlrpar1_zombie").OnDeath(self, dmginfo, hitgroup, status)
end