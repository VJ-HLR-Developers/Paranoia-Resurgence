/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "obj_vj_grenade"
ENT.PrintName = "Grenade"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"

if CLIENT then
    VJ.AddKillIcon("obj_vj_hlrpar1_grenade", ENT.PrintName, VJ.KILLICON_GRENADE)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = "models/vj_parr/par1/weapons/w_grenade.mdl"
ENT.CollisionDecal = "VJ_PARR1_Scorch"
ENT.SoundTbl_OnCollide = {"vj_parr/par1/weapons/grenade_hit1.wav", "vj_parr/par1/weapons/grenade_hit2.wav", "vj_parr/par1/weapons/grenade_hit3.wav"}
ENT.SoundTbl_OnRemove = "VJ.PARR1_Explosion.Single"
ENT.OnRemoveSoundLevel = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCollision(data, phys)
    local getVel = phys:GetVelocity()
    local curVelSpeed = getVel:Length()
    phys:SetVelocity(getVel * 0.5)

    if curVelSpeed > 100 then -- If the grenade is going faster than 100, then play the touch sound
        self:PlaySound("OnCollide")
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vezZ90 = Vector(0, 0, 90)
local vecZ4 = Vector(0, 0, 4)
local vezZ100 = Vector(0, 0, 100)
--
function ENT:OnDestroy()
    local selfPos = self:GetPos()

    local spr = ents.Create("env_sprite")
    spr:SetKeyValue("model", "vj_parr/sprites/zerogxplode.vmt")
    spr:SetKeyValue("GlowProxySize", "2.0")
    spr:SetKeyValue("HDRColorScale", "1.0")
    spr:SetKeyValue("renderfx", "14")
    spr:SetKeyValue("rendermode", "5")
    spr:SetKeyValue("renderamt", "255")
    spr:SetKeyValue("disablereceiveshadows", "0")
    spr:SetKeyValue("mindxlevel", "0")
    spr:SetKeyValue("maxdxlevel", "0")
    spr:SetKeyValue("framerate", "15.0")
    spr:SetKeyValue("spawnflags", "0")
    spr:SetKeyValue("scale", "2")
    spr:SetPos(selfPos + vezZ90)
    spr:Spawn()
    spr:Fire("Kill", nil, 1)
    timer.Simple(0.9, function() if IsValid(spr) then spr:Remove() end end)

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "4")
    expLight:SetKeyValue("distance", "300")
    expLight:SetLocalPos(selfPos)
    expLight:SetLocalAngles(self:GetAngles())
    expLight:Fire("Color", "255 150 0")
    //expLight:SetParent(self)
    expLight:Spawn()
    expLight:Activate()
    expLight:Fire("TurnOn")
    expLight:Fire("Kill", nil, 0.1)
    //self:DeleteOnRemove(expLight)
    util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)

    self:SetLocalPos(selfPos + vecZ4) -- Because the entity is too close to the ground
    local tr = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() - vezZ100,
        filter = self
    })
    util.Decal(VJ.PICK(self.CollisionDecal), tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

    self:DealDamage()
    VJ.EmitSound(self, "vj_parr/par1/weapons/debris3.wav", 80, 100)
end