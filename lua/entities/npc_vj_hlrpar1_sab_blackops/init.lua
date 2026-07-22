include("entities/npc_vj_hlrpar1_saboteur/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/cut/blackop.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/diversant/dv_charge1.wav",
        "vj_parr/par1/diversant/dv_charge2.wav",
        "vj_parr/par1/diversant/dv_charge3.wav",
        "vj_parr/par1/diversant/dv_charge4.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par1/diversant/dv_alert1.wav",
        "vj_parr/par1/diversant/dv_alert2.wav",
        "vj_parr/par1/diversant/dv_alert3.wav",
        "vj_parr/par1/diversant/dv_alert4.wav",
        "vj_parr/par1/diversant/dv_alert5.wav"
    }
    self.SoundTbl_LostEnemy = {
        "vj_parr/par1/diversant/dv_taunt1.wav",
        "vj_parr/par1/diversant/dv_taunt2.wav"
    }
    self.SoundTbl_GrenadeAttack = {
        "vj_parr/par1/diversant/dv_throw1.wav",
        "vj_parr/par1/diversant/dv_throw2.wav"
    }
    self.SoundTbl_GrenadeSight = {
        "vj_parr/par1/diversant/dv_gren1.wav",
        "vj_parr/par1/diversant/dv_gren2.wav",
        "vj_parr/par1/diversant/dv_gren3.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/diversant/gr_die1.wav",
        "vj_parr/par1/diversant/gr_die2.wav",
        "vj_parr/par1/diversant/gr_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/diversant/dv_cover1.wav",
        "vj_parr/par1/diversant/dv_cover2.wav",
        "vj_parr/par1/diversant/dv_cover3.wav",
        "vj_parr/par1/diversant/dv_cover4.wav",
        "vj_parr/par1/diversant/gr_pain1.wav",
        "vj_parr/par1/diversant/gr_pain2.wav",
        "vj_parr/par1/diversant/gr_pain3.wav",
        "vj_parr/par1/diversant/gr_pain4.wav",
        "vj_parr/par1/diversant/gr_pain5.wav",
        "vj_parr/par1/diversant/gr_pain6.wav"
    }
    self:SetBodygroup(1, math_random(0, 1))
    self:SetBodygroup(3, math_random(0, 1))

    if self:GetBodygroup(1) == 0 then
        self:SetBodygroup(4, 0)
    else
        self:SetBodygroup(4, 1)
    end
end