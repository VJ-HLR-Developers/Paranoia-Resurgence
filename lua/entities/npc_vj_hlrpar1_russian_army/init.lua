include("entities/npc_vj_hlrpar1_russian_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/soldier.mdl"
ENT.StartHealth = 100

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self.SoundTbl_Idle = {
        "vj_parr/par1/soldier/bolnoy1.wav",
        "vj_parr/par1/soldier/bolnoy2.wav",
        "vj_parr/par1/soldier/bolnoy3.wav",
        "vj_parr/par1/soldier/rest1.wav",
        "vj_parr/par1/soldier/rest2.wav",
        "vj_parr/par1/soldier/rest3.wav",
        "vj_parr/par1/soldier/rest4.wav",
        "vj_parr/par1/soldier/sleep.wav",
        "vj_parr/par1/alpha/monologue7.wav"
    }
    self.SoundTbl_IdleDialogue = {
        "vj_parr/par1/soldier/monologue1.wav",
        "vj_parr/par1/soldier/monologue2.wav",
        "vj_parr/par1/soldier/monologue3.wav",
        "vj_parr/par1/soldier/monologue4.wav",
        "vj_parr/par1/soldier/monologue5.wav",
        "vj_parr/par1/soldier/monologue6.wav",
        "vj_parr/par1/alpha/monologue1.wav",
        "vj_parr/par1/alpha/monologue2.wav",
        "vj_parr/par1/alpha/monologue3.wav",
        "vj_parr/par1/alpha/monologue4.wav",
        "vj_parr/par1/alpha/monologue5.wav",
        "vj_parr/par1/alpha/monologue6.wav",
        "vj_parr/par1/alpha/monologue8.wav"
    }
    self.SoundTbl_IdleDialogueAnswer = {
        "vj_parr/par1/soldier/no1.wav",
        "vj_parr/par1/soldier/ok1.wav",
        "vj_parr/par1/soldier/ok2.wav",
        "vj_parr/par1/soldier/ok3.wav",
        "vj_parr/par1/soldier/work1.wav",
        "vj_parr/par1/soldier/no10.wav",
        "vj_parr/par1/soldier/yes1.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/npc/army/karaul1.wav",
        "vj_parr/par1/npc/army/karaul2.wav",
        "vj_parr/par1/npc/army/karaul3.wav",
        "vj_parr/par1/npc/army/karaul4.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par1/npc/army/karaul1.wav",
        "vj_parr/par1/npc/army/karaul2.wav",
        "vj_parr/par1/npc/army/karaul3.wav",
        "vj_parr/par1/npc/army/karaul4.wav"
    }
    self.SoundTbl_OnPlayerSight = {
        "vj_parr/par1/soldier/hello2.wav",
        "vj_parr/par1/soldier/hello3.wav",
        "vj_parr/par1/soldier/hello4.wav",
        "vj_parr/par1/soldier/hello5.wav",
        "vj_parr/par1/alpha/hello1.wav",
        "vj_parr/par1/alpha/hello2.wav",
        "vj_parr/par1/alpha/hello3.wav",
        "vj_parr/par1/alpha/hello4.wav",
        "vj_parr/par1/alpha/hello5.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/military/mil_die1.wav",
        "vj_parr/par1/military/mil_die2.wav",
        "vj_parr/par1/military/mil_die3.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/alpha/hit1.wav",
        "vj_parr/par1/alpha/hit2.wav",
        "vj_parr/par1/alpha/hit3.wav",
        "vj_parr/par1/alpha/hit4.wav",
        "vj_parr/par1/alpha/hit5.wav",
        "vj_parr/par1/military/mil_pain1.wav",
        "vj_parr/par1/military/mil_pain2.wav",
        "vj_parr/par1/military/mil_pain3.wav",
        "vj_parr/par1/military/mil_pain4.wav",
        "vj_parr/par1/military/mil_pain5.wav"
    }
    self:SetBodygroup(1, math_random(0, 5))
    self:SetBodygroup(3, math_random(0, 1))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent) return end