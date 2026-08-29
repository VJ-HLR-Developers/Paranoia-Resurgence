/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "obj_vj_projectile_base"
ENT.PrintName = "40mm Grenade"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"

ENT.VJ_ID_Danger = true

if CLIENT then
    VJ.AddKillIcon("obj_vj_hlrpar2_grenade_40mm", ENT.PrintName, VJ.KILLICON_TYPE_ALIAS, "grenade_ar2")
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = "models/vj_parr/par2/weapons/grenade.mdl"
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY
ENT.DoesRadiusDamage = true
ENT.RadiusDamageRadius = 150
ENT.RadiusDamage = 100
ENT.RadiusDamageUseRealisticRadius = true
ENT.RadiusDamageType = DMG_BLAST
ENT.RadiusDamageForce = 90
ENT.CollisionDecal = "VJ_PARR2_Scorch"
ENT.SoundTbl_OnRemove = "VJ.PARR2_Explosion.Single"
ENT.OnRemoveSoundLevel = 100

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:InitPhys()
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:AddAngleVelocity(Vector(0, math_random(300, 400), 0))
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vecZ60 = Vector(0, 0, 50)
--
function ENT:OnDestroy(data, phys)
    local myPos = self:GetPos()

    local spr = ents.Create("env_sprite")
    spr:SetKeyValue("model", "vj_parr/sprites/fexplo.vmt")
    spr:SetKeyValue("GlowProxySize", "2.0")
    spr:SetKeyValue("HDRColorScale", "1.0")
    spr:SetKeyValue("renderfx", "14")
    spr:SetKeyValue("rendermode", "5")
    spr:SetKeyValue("renderamt", "255")
    spr:SetKeyValue("disablereceiveshadows", "0")
    spr:SetKeyValue("mindxlevel", "0")
    spr:SetKeyValue("maxdxlevel", "0")
    spr:SetKeyValue("framerate", "20.0")
    spr:SetKeyValue("spawnflags", "0")
    spr:SetKeyValue("scale", "2")
    spr:SetPos(myPos + vecZ60)
    spr:Spawn()
    spr:Fire("Kill", nil, 1.5)

    VJ.EmitSound(self, "vj_parr/par1/weapons/debris3.wav", 80, 100)
    util.ScreenShake(myPos, 100, 200, 1, 2500)

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "4")
    expLight:SetKeyValue("distance", "300")
    expLight:SetPos(myPos)
    expLight:Fire("Color", "255 150 0")
    expLight:Spawn()
    expLight:Activate()
    expLight:Fire("TurnOn")
    expLight:Fire("Kill", nil, 0.15)
end