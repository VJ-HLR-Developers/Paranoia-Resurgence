include("entities/npc_vj_hlrpar1_rus_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/vj_parr/par1/soldier_clon.mdl", "models/vj_parr/par1/soldier_clon_bio.mdl"}
ENT.StartHealth = 200
ENT.VJ_NPC_Class = {"CLASS_CLONE"}
ENT.AlliedWithPlayerAllies = false
ENT.BecomeEnemyToPlayer = false

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PreInit()
    if GetConVar("VJ_HLRPAR_Clone_Ally"):GetInt() == 1 then
        self.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN"}
        self.AlliedWithPlayerAllies = true
        self.BecomeEnemyToPlayer = 2
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self.SoundTbl_Death = {
        "vj_parr/par1/clone/cl_die1.wav",
        "vj_parr/par1/clone/cl_die2.wav",
        "vj_parr/par1/clone/cl_die3.wav",
        "vj_parr/par1/clone/cl_die4.wav",
        "vj_parr/par1/clone/cl_die5.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/clone/cl_pain1.wav",
        "vj_parr/par1/clone/cl_pain2.wav",
        "vj_parr/par1/clone/cl_pain3.wav",
        "vj_parr/par1/clone/cl_pain4.wav",
        "vj_parr/par1/clone/cl_pain5.wav"
    }
    if self:GetModel() != "models/vj_parr/par1/early/soldier_colba.mdl" then
        self:SetBodygroup(1, math_random(0, 1))
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent) return end