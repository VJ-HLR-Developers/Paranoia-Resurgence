include("entities/npc_vj_hlrpar1_rus_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par1/terror.mdl"
ENT.StartHealth = 100
ENT.VJ_NPC_Class = {"CLASS_UNITED_STATES"}
ENT.AlliedWithPlayerAllies = false
ENT.BecomeEnemyToPlayer = false

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PreInit()
    if GetConVar("VJ_HLRPAR_Terrorist_Hostile"):GetInt() == 1 then
        self.VJ_NPC_Class = {"CLASS_TERRORIST"}
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Voice()
    self.SoundTbl_Idle = {
        "vj_parr/par1/terror/idle1.wav",
        "vj_parr/par1/terror/idle2.wav",
        "vj_parr/par1/terror/idle3.wav",
        "vj_parr/par1/terror/idle4.wav",
        "vj_parr/par1/terror/idle5.wav",
        "vj_parr/par1/terror/vrag1.wav",
        "vj_parr/par1/terror/vrag2.wav",
        "vj_parr/par1/terror/vrag3.wav"
    }
    self.SoundTbl_CombatIdle = {
        "vj_parr/par1/terror/allah_akbar1.wav",
        "vj_parr/par1/terror/allah_akbar2.wav",
        "vj_parr/par1/terror/allah_akbar3.wav",
        "vj_parr/par1/terror/allah_akbar4.wav",
        "vj_parr/par1/terror/allah_akbar5.wav",
        "vj_parr/par1/terror/sdavaysa1.wav",
        "vj_parr/par1/terror/sdavaysa2.wav",
        "vj_parr/par1/terror/sdavaysa3.wav",
        "vj_parr/par1/terror/yruss1.wav",
        "vj_parr/par1/terror/yruss2.wav"
    }
    self.SoundTbl_Investigate = {
        "vj_parr/par1/terror/aha1.wav",
        "vj_parr/par1/terror/aha2.wav"
    }
    self.SoundTbl_Alert = {
        "vj_parr/par1/terror/allah_akbar1.wav",
        "vj_parr/par1/terror/allah_akbar2.wav",
        "vj_parr/par1/terror/allah_akbar3.wav",
        "vj_parr/par1/terror/allah_akbar4.wav",
        "vj_parr/par1/terror/allah_akbar5.wav",
        "vj_parr/par1/terror/sdavaysa1.wav",
        "vj_parr/par1/terror/sdavaysa2.wav",
        "vj_parr/par1/terror/sdavaysa3.wav",
        "vj_parr/par1/terror/yruss1.wav",
        "vj_parr/par1/terror/yruss2.wav"
    }
    self.SoundTbl_KilledEnemy =
        "vj_parr/par1/terror/yahoo.wav"

    self.SoundTbl_LostEnemy = {
        "vj_parr/par1/terror/taunt1.wav",
        "vj_parr/par1/terror/taunt2.wav",
        "vj_parr/par1/terror/taunt3.wav",
        "vj_parr/par1/terror/taunt4.wav",
        "vj_parr/par1/terror/taunt5.wav",
        "vj_parr/par1/terror/taunt6.wav",
        "vj_parr/par1/terror/taunt8.wav"
    }
    self.SoundTbl_GrenadeAttack = {
        "vj_parr/par1/terror/brosokgranata1.wav",
        "vj_parr/par1/terror/brosokgranata2.wav",
        "vj_parr/par1/terror/brosokgranata3.wav"
    }
    self.SoundTbl_GrenadeSight = {
        "vj_parr/par1/terror/granata1.wav",
        "vj_parr/par1/terror/granata2.wav"
    }
    self.SoundTbl_DangerSight = {
        "vj_parr/par1/terror/ykritie1.wav",
        "vj_parr/par1/terror/ykritie2.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par1/terror/ter_die1.wav",
        "vj_parr/par1/terror/ter_die2.wav",
        "vj_parr/par1/terror/ter_die3.wav",
        "vj_parr/par1/terror/ter_die4.wav",
        "vj_parr/par1/terror/ter_die5.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par1/terror/ter_pain1.wav",
        "vj_parr/par1/terror/ter_pain2.wav",
        "vj_parr/par1/terror/ter_pain3.wav",
        "vj_parr/par1/terror/ter_pain4.wav",
        "vj_parr/par1/terror/ter_pain5.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Soldier_Init()
    self:SetBodygroup(1, math_random(0, 4))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateSound(sdData, sdFile)
    if VJ.HasValue(self.SoundTbl_Breath, sdFile) then return end
    self.Soldier_NextMouthMove = CurTime() + SoundDuration(sdFile)

    VJ.EmitSound(self, "vj_parr/par1/terror/clik.wav")
    timer.Simple(SoundDuration(sdFile), function() if IsValid(self) && sdData:IsPlaying() then VJ.EmitSound(self, "vj_parr/par1/terror/clik.wav") end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdAlertMonster = {"vj_parr/par1/terror/shaitan1.wav", "vj_parr/par1/terror/shaitan2.wav", "vj_parr/par1/terror/shaitan3.wav"}
--
function ENT:OnAlert(ent)
    if math_random(1, 3) == 1 then
        if (ent.IsVJBaseSNPC_Creature or ent.VJ_ID_Undead) && !ent.VJ_ID_Vehicle && !ent.VJ_ID_Aircraft then -- Monster sounds
            self:PlaySoundSystem("Alert", sdAlertMonster)
            return
        end
    end
end