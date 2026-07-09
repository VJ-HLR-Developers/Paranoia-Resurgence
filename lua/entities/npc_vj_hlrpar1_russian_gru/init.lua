include("entities/npc_vj_hlrpar1_russian_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/cut/soldier_gru.mdl"

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self.SoundTbl_Idle = {
        "vj_parr/par1/alpha/alpha_clear0.wav",
        "vj_parr/par1/alpha/alpha_clear1.wav",
        "vj_parr/par1/alpha/alpha_clear2.wav",
        "vj_parr/par1/alpha/alpha_clear3.wav",
        "vj_parr/par1/alpha/alpha_clear4.wav",
        "vj_parr/par1/alpha/alpha_idle0.wav",
        "vj_parr/par1/alpha/alpha_idle1.wav",
        "vj_parr/par1/alpha/alpha_idle2.wav",
        "vj_parr/par1/alpha/alpha_idle3.wav",
        "vj_parr/par1/alpha/alpha_idle4.wav",
        "vj_parr/par1/alpha/alpha_idle5.wav",
        "vj_parr/par1/alpha/alpha_idle6.wav",
        "vj_parr/par1/alpha/alpha_idle7.wav",
        "vj_parr/par1/alpha/alpha_idle8.wav",
        "vj_parr/par1/alpha/alpha_idle9.wav"
    }
    self.SoundTbl_IdleDialogue = {
        "vj_parr/par1/alpha/alpha_ok0.wav",
        "vj_parr/par1/alpha/alpha_ok1.wav",
        "vj_parr/par1/alpha/alpha_ok3.wav",
        "vj_parr/par1/alpha/alpha_ok4.wav",
        "vj_parr/par1/alpha/alpha_ok5.wav",
        "vj_parr/par1/alpha/alpha_ok6.wav"
    }
    self.SoundTbl_IdleDialogueAnswer = {
        "vj_parr/par1/alpha/alpha_yes0.wav",
        "vj_parr/par1/alpha/alpha_yes1.wav",
        "vj_parr/par1/alpha/alpha_yes2.wav",
        "vj_parr/par1/alpha/alpha_yes3.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/alpha/alpha_enemy1.wav",
        "vj_parr/par1/alpha/alpha_enemy2.wav",
        "vj_parr/par1/alpha/alpha_enemy3.wav"
    }
    self.SoundTbl_ReceiveOrder = {
        "vj_parr/par1/alpha/alpha_yes0.wav",
        "vj_parr/par1/alpha/alpha_yes1.wav",
        "vj_parr/par1/alpha/alpha_yes2.wav",
        "vj_parr/par1/alpha/alpha_yes3.wav"
    }
    self.SoundTbl_Investigate =
        "vj_parr/par1/alpha/alpha_wait0.wav"

    self.SoundTbl_Alert = {
        "vj_parr/par1/alpha/alpha_enemy1.wav",
        "vj_parr/par1/alpha/alpha_enemy2.wav",
        "vj_parr/par1/alpha/alpha_enemy3.wav"
    }
    self.SoundTbl_KilledEnemy = {
        "vj_parr/par1/alpha/alpha_enemydown0.wav",
        "vj_parr/par1/alpha/alpha_enemydown1.wav",
        "vj_parr/par1/alpha/alpha_enemydown2.wav",
        "vj_parr/par1/alpha/alpha_enemydown3.wav",
        "vj_parr/par1/alpha/alpha_enemydown4.wav"
    }
    self.SoundTbl_GrenadeAttack = {
        "vj_parr/par1/alpha/alpha_grenade0.wav",
        "vj_parr/par1/alpha/alpha_grenade1.wav",
        "vj_parr/par1/alpha/alpha_grenade2.wav",
        "vj_parr/par1/alpha/alpha_grenade3.wav",
        "vj_parr/par1/alpha/alpha_grenade4.wav"
    }
    self.SoundTbl_GrenadeSight = {
        "vj_parr/par1/alpha/alpha_grenade0.wav",
        "vj_parr/par1/alpha/alpha_grenade1.wav",
        "vj_parr/par1/alpha/alpha_grenade2.wav",
        "vj_parr/par1/alpha/alpha_grenade3.wav",
        "vj_parr/par1/alpha/alpha_grenade4.wav"
    }
    self.SoundTbl_AllyDeath = {
        "vj_parr/par1/alpha/alpha_teammatedown1.wav",
        "vj_parr/par1/alpha/alpha_teammatedown2.wav",
        "vj_parr/par1/alpha/alpha_teammatedown3.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/alpha/alpha_die1.wav",
        "vj_parr/par1/alpha/alpha_die2.wav",
        "vj_parr/par1/alpha/alpha_die3.wav",
        "vj_parr/par1/alpha/alpha_die4.wav",
        "vj_parr/par1/alpha/alpha_die5.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/alpha/alpha_pain1.wav",
        "vj_parr/par1/alpha/alpha_pain2.wav",
        "vj_parr/par1/alpha/alpha_pain3.wav",
        "vj_parr/par1/alpha/alpha_pain4.wav",
        "vj_parr/par1/alpha/alpha_pain5.wav",
        "vj_parr/par1/alpha/alpha_pain6.wav"
    }
    self:SetBodygroup(1, math_random(0, 5))
end