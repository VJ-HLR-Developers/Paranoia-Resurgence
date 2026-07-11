include("entities/npc_vj_hlrpar1_rus_alpha/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/vj_parr/par1/diversant.mdl", "models/vj_parr/par1/diversant_pistol.mdl"}
ENT.StartHealth = 100
ENT.VJ_NPC_Class = {"CLASS_UNITED_STATES"}
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
    self:SetBodygroup(2, math.random(0, 4))
    self:SetBodygroup(4, math.random(0, 1))

    local myBG = self:GetBodygroup(2)
    if myBG == 0 or myBG == 3 then
        self:SetBodygroup(5, 0)
    else
        self:SetBodygroup(5, 1)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateSound(sdData, sdFile)
    if VJ.HasValue(self.SoundTbl_Breath, sdFile) then return end
    self.Soldier_NextMouthMove = CurTime() + SoundDuration(sdFile)

    VJ.EmitSound(self, "vj_parr/par1/diversant/radio_start.wav")
    timer.Simple(SoundDuration(sdFile), function() if IsValid(self) && sdData:IsPlaying() then VJ.EmitSound(self, "vj_parr/par1/diversant/radio_end.wav") end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdAlertMonster = {"vj_parr/par1/diversant/dv_monst1.wav", "vj_parr/par1/diversant/dv_monst2.wav"}
--
function ENT:OnAlert(ent)
    if math.random(1, 3) == 1 then
        if ent.IsVJBaseSNPC_Creature && !ent.VJ_ID_Vehicle && !ent.VJ_ID_Aircraft then -- Monster sounds
            self:PlaySoundSystem("Alert", sdAlertMonster)
            return
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnWeaponAttack()
    if self.VJ_IsBeingControlled or self.IsGuard then return end
    if CurTime() > self.Soldier_NextRunT then
        timer.Simple(0.8, function()
            if IsValid(self) && self.AttackType != VJ.ATTACK_TYPE_GRENADE && !self:IsMoving() && !self.Dead then
                self:SCHEDULE_COVER_ENEMY("TASK_RUN_PATH")
            end
        end)
        self.Soldier_NextStrafeT = CurTime() + 8
        self.Soldier_NextRunT = CurTime() + 12
    end
end