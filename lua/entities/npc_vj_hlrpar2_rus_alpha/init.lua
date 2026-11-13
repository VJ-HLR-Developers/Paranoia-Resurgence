include("entities/npc_vj_hlrpar1_rus_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/soldier_alpha.mdl"
ENT.ControllerParams.FirstP_Bone = "bip01_head"
ENT.BloodParticle = "vj_parr2_blood_red"
ENT.BloodDecal = "VJ_PARR2_Blood_Red"
ENT.GrenadeAttackEntity = "obj_vj_hlrpar2_grenade"
ENT.AnimTbl_TakingCover = ACT_CROUCHIDLE
ENT.Weapon_SecondaryFireTime = 0.2
-- Custom
ENT.Soldier_CanHurtWalk = false

local math_random = math.random

function ENT:Soldier_Voice()
    local pickVoice = math_random(1, 2)
    if pickVoice == 1 then
        self.SoundTbl_Idle = {
            "vj_parr/par2/alpha/kulak/kulak_use1.wav",
            "vj_parr/par2/alpha/kulak/kulak_use4.wav",
            "vj_parr/par2/alpha/kulak/kulak_use5.wav",
            "vj_parr/par2/alpha/kulak/kulak_use6.wav",
            "vj_parr/par2/alpha/kulak/kulak_use7.wav",
            "vj_parr/par2/alpha/kulak/kulak_use9.wav"
        }
        self.SoundTbl_IdleDialogue = {
            "vj_parr/par2/alpha/kulak/kulak_stare1.wav",
            "vj_parr/par2/alpha/kulak/kulak_use2.wav",
            "vj_parr/par2/alpha/kulak/kulak_use3.wav",
            "vj_parr/par2/alpha/kulak/kulak_use8.wav"
        }
        self.SoundTbl_IdleDialogueAnswer = {
            "vj_parr/par1/alpha/alpha_ok0.wav",
            "vj_parr/par1/alpha/alpha_ok1.wav",
            "vj_parr/par1/alpha/alpha_ok3.wav",
            "vj_parr/par1/alpha/alpha_ok4.wav",
            "vj_parr/par1/alpha/alpha_ok5.wav",
            "vj_parr/par1/alpha/alpha_ok6.wav",
            "vj_parr/par1/alpha/alpha_yes0.wav",
            "vj_parr/par1/alpha/alpha_yes1.wav",
            "vj_parr/par1/alpha/alpha_yes2.wav",
            "vj_parr/par1/alpha/alpha_yes3.wav"
        }
        self.SoundTbl_Busy = {
            "vj_parr/par2/alpha/kulak/kulak_stare1.wav",
            "vj_parr/par2/alpha/kulak/kulak_use1.wav",
            "vj_parr/par2/alpha/kulak/kulak_use2.wav",
            "vj_parr/par2/alpha/kulak/kulak_use3.wav",
            "vj_parr/par2/alpha/kulak/kulak_use4.wav",
            "vj_parr/par2/alpha/kulak/kulak_use5.wav",
            "vj_parr/par2/alpha/kulak/kulak_use6.wav",
            "vj_parr/par2/alpha/kulak/kulak_use7.wav",
            "vj_parr/par2/alpha/kulak/kulak_use8.wav",
            "vj_parr/par2/alpha/kulak/kulak_use9.wav"
        }
        self.SoundTbl_CombatIdle = {
            "vj_parr/par2/alpha/kulak/kulak_enemy11.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy12.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy13.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy14.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy15.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy16.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy17.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy18.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy19.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy20.wav"
        }
        self.SoundTbl_ReceiveOrder = {
            "vj_parr/par1/alpha/alpha_ok0.wav",
            "vj_parr/par1/alpha/alpha_ok1.wav",
            "vj_parr/par1/alpha/alpha_ok3.wav",
            "vj_parr/par1/alpha/alpha_ok4.wav",
            "vj_parr/par1/alpha/alpha_ok5.wav",
            "vj_parr/par1/alpha/alpha_ok6.wav",
            "vj_parr/par1/alpha/alpha_yes0.wav",
            "vj_parr/par1/alpha/alpha_yes1.wav",
            "vj_parr/par1/alpha/alpha_yes2.wav",
            "vj_parr/par1/alpha/alpha_yes3.wav",
            "vj_parr/par1/npc/bunk/kulak_za_mnoy.wav",
            "vj_parr/par1/npc/indust/7shluz_meet4.wav"
        }
        self.SoundTbl_Investigate = {
            "vj_parr/par1/alpha/alpha_wait0.wav",
            "vj_parr/par1/npc/indust/7shluz_get_ready.wav",
            "vj_parr/par1/npc/bunk/kulak_mozg3.wav"
        }
        self.SoundTbl_Alert = {
            "vj_parr/par2/alpha/kulak/kulak_enemy1.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy2.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy3.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy4.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy5.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy6.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy7.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy8.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy9.wav",
            "vj_parr/par2/alpha/kulak/kulak_enemy10.wav"
        }
        self.SoundTbl_AlertMonster = {
            "vj_parr/par1/npc/bunk/kulak_ih_mnogo.wav",
            "vj_parr/par1/npc/bunk/kulak_boss2.wav",
            "vj_parr/par1/npc/bunk/kulak_wtf2.wav"
        }
        self.SoundTbl_OnPlayerSight = {
            "vj_parr/par1/npc/bunk/kulak_introlab1.wav",
            "vj_parr/par1/npc/bunk/kulak_mayor!.wav",
            "vj_parr/par1/npc/indust/mayor!.wav"
        }
        self.SoundTbl_YieldToPlayer = {
            "vj_parr/par2/alpha/kulak/kulak_block0.wav",
            "vj_parr/par2/alpha/kulak/kulak_block1.wav",
            "vj_parr/par2/alpha/kulak/kulak_block2.wav",
            "vj_parr/par2/alpha/kulak/kulak_block3.wav",
            "vj_parr/par2/alpha/kulak/kulak_block4.wav",
            "vj_parr/par2/alpha/kulak/kulak_block5.wav",
            "vj_parr/par2/alpha/kulak/kulak_block6.wav",
            "vj_parr/par2/alpha/kulak/kulak_block7.wav",
            "vj_parr/par2/alpha/kulak/kulak_block8.wav"
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
            "vj_parr/par1/alpha/alpha_grenade4.wav",
            "vj_parr/par1/npc/indust/7shluz_underfire.wav"
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
            "vj_parr/par1/alpha/alpha_pain6.wav",
            "vj_parr/par1/alpha/alpha_wounded1.wav",
            "vj_parr/par1/alpha/alpha_wounded2.wav",
            "vj_parr/par1/alpha/alpha_wounded3.wav"
        }
    elseif pickVoice == 2 then
        self.SoundTbl_Idle = {
            "vj_parr/par2/alpha/soldier/soldier_use1.wav",
            "vj_parr/par2/alpha/soldier/soldier_use2.wav",
            "vj_parr/par2/alpha/soldier/soldier_use6.wav",
            "vj_parr/par2/alpha/soldier/soldier_use7.wav",
            "vj_parr/par2/alpha/soldier/soldier_use8.wav"
        }
        self.SoundTbl_IdleDialogue = {
            "vj_parr/par2/alpha/soldier/soldier_use3.wav",
            "vj_parr/par2/alpha/soldier/soldier_use4.wav",
            "vj_parr/par2/alpha/soldier/soldier_use5.wav",
            "vj_parr/par2/alpha/soldier/soldier_use9.wav"
        }
        self.SoundTbl_IdleDialogueAnswer = {
            "vj_parr/par2/alpha/soldier/soldier_use10.wav",
            "vj_parr/par2/alpha/soldier/soldier_use11.wav",
            "vj_parr/par2/alpha/soldier/soldier_use12.wav",
            "vj_parr/par2/alpha/soldier/soldier_use13.wav",
            "vj_parr/par2/alpha/soldier/soldier_use14.wav"
        }
        self.SoundTbl_Busy = {
            "vj_parr/par2/alpha/soldier/soldier_use1.wav",
            "vj_parr/par2/alpha/soldier/soldier_use2.wav",
            "vj_parr/par2/alpha/soldier/soldier_use6.wav",
            "vj_parr/par2/alpha/soldier/soldier_use7.wav",
            "vj_parr/par2/alpha/soldier/soldier_use8.wav",
            "vj_parr/par2/alpha/soldier/soldier_use3.wav",
            "vj_parr/par2/alpha/soldier/soldier_use4.wav",
            "vj_parr/par2/alpha/soldier/soldier_use5.wav",
            "vj_parr/par2/alpha/soldier/soldier_use9.wav",
            "vj_parr/par2/alpha/soldier/soldier_use10.wav",
            "vj_parr/par2/alpha/soldier/soldier_use11.wav",
            "vj_parr/par2/alpha/soldier/soldier_use12.wav",
            "vj_parr/par2/alpha/soldier/soldier_use13.wav",
            "vj_parr/par2/alpha/soldier/soldier_use14.wav"
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
        self.SoundTbl_Death = {
            "vj_parr/par1/military/mil_die1.wav",
            "vj_parr/par1/military/mil_die2.wav",
            "vj_parr/par1/military/mil_die3.wav"
        }
        self.SoundTbl_Pain = {
            "vj_parr/par1/military/mil_pain1.wav",
            "vj_parr/par1/military/mil_pain2.wav",
            "vj_parr/par1/military/mil_pain3.wav",
            "vj_parr/par1/military/mil_pain4.wav",
            "vj_parr/par1/military/mil_pain5.wav"
        }
    end
end