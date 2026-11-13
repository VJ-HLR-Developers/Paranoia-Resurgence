include("entities/npc_vj_hlrpar1_zbrain_tree/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/brain_trup1.mdl"
ENT.StartHealth = 200
ENT.GodMode = false
ENT.HasSoundTrack = false

function ENT:Init()
    self:SetName("Zombie Brain Tree Body")
    self:SetCollisionBounds(Vector(13, 13, 5), Vector(-13, -13, 0))
    self:SetSurroundingBounds(Vector(100, 100, 90), Vector(-100, -100, 0))
end

function ENT:Controller_Initialize(ply, controlEnt) return end

function ENT:OnThinkActive() return end

function ENT:OnDeath(dmginfo, hitgroup, status)
    local brainEnt = self.Brain_Ent
    if status == "Init" and IsValid(brainEnt) then
        self:SetParent(NULL)
        self:SetPos(self:GetPos() + self:GetUp() * -4)
        brainEnt:Brain_BodyDeath()
        timer.Simple(0, function() if IsValid(self) then self:SetParent(brainEnt) end end)
    end
end

function ENT:CustomOnRemove() return end