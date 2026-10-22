include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_parr/par2/monster_soldierguard.mdl"
ENT.BloodParticle = "vj_parr2_blood_red"
ENT.BloodDecal = "VJ_PARR2_Blood_Red"
ENT.FlinchHitGroupMap = {{HitGroup = HITGROUP_LEFTARM, Animation = ACT_FLINCH_LEFTARM}, {HitGroup = HITGROUP_RIGHTARM, Animation = ACT_FLINCH_RIGHTARM}}

local math_random = math.random
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Voice()
    /*self.SoundTbl_Breath =
        "vj_parr/par2/shared/hungrysoldier.wav"*/

    self.SoundTbl_Alert = {
        "vj_parr/par2/zombie/zo_alert10.wav",
        "vj_parr/par2/zombie/zo_alert20.wav",
        "vj_parr/par2/zombie/zo_alert30.wav"
    }
    self.SoundTbl_BeforeMeleeAttack = {
        "vj_parr/par2/zombie/zo_attack1.wav",
        "vj_parr/par2/zombie/zo_attack2.wav"
    }
    self.SoundTbl_Death = {
        "vj_parr/par2/zombie/zo_pain1.wav",
        "vj_parr/par2/zombie/zo_pain2.wav"
    }
    self.SoundTbl_Pain = {
        "vj_parr/par2/zombie/zo_pain1.wav",
        "vj_parr/par2/zombie/zo_pain2.wav"
    }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    -- Spawn animation
    if VJ_CVAR_AI_ENABLED && (math_random(1, 3) == 1 or self.Zombie_Turned) then
        local anim = VJ.PICK({"scen_eating_out", "scen_holeoff"})
        timer.Simple(0, function()
            if IsValid(self) then
                self:PlayAnim(anim, true, false)
                self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
            end
        end)
        timer.Simple(VJ.AnimDuration(self, anim), function()
            if IsValid(self) then
                self:SetState()
            end
        end)
    end
    //self.CanEat = true
    self:SetBodygroup(1, math_random(0, 3))
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ.Color2Byte(Color(130, 19, 10))
local cloneList = {["npc_vj_hlrpar1_clone"] = true, ["npc_vj_hlrpar1_clo_v1"] = true, ["npc_vj_hlrpar1_clo_heavy"] = true, ["npc_vj_hlrpar1_clo_heavy_v1"] = true, ["npc_vj_hlrpar2_clone"] = true, ["npc_vj_hlrpar2_clone_v1"] = true}
local hazmatSciList = {["npc_vj_hlrpar1_sci_haz"] = true, ["npc_vj_hlrpar2_pirogov"] = true}
local sciFemaleList = {["npc_vj_hlrpar1_sci_fem"] = true, ["npc_vj_hlrpar1_paulina"] = true, ["npc_vj_hlrpar2_paulina"] = true}
local spetsnazList = {["npc_vj_hlrpar1_rus_alpha"] = true, ["npc_vj_hlrpar1_rus_alpha_savior"] = true, ["npc_vj_hlrpar1_rus_alpha_v1"] = true, ["npc_vj_hlrpar1_rus_alpha_v2"] = true, ["npc_vj_hlrpar1_rus_alpha_offd"] = true, ["npc_vj_hlrpar1_rus_alpha_offd_v1"] = true, ["npc_vj_hlrpar1_rus_alpha_offd_v2"] = true, ["npc_vj_hlrpar2_rus_alpha"] = true, ["npc_vj_hlrpar2_rus_alpha_v1"] = true}
--
function ENT:OnKilledEnemy(ent, inflictor, wasLast)
    if GetConVar("VJ_PARR_Zombie_Infection"):GetInt() == 0 then return end
    if ent.VJ_ID_Undead or !ent.IsVJBaseSNPC_Human or (self.IsVJBaseSNPC_Human && self.WeaponAttackState != VJ.WEP_ATTACK_STATE_NONE) or (self.AttackType != VJ.ATTACK_TYPE_MELEE && self.AttackType != VJ.ATTACK_TYPE_LEAP) or (self.AttackType == VJ.ATTACK_TYPE_RANGE && self.Zombie_Type == 5) then return end
    if math_random(1, 3) == 1 && (ent:LookupBone("Bip01 Pelvis") or ent:LookupBone("Bip02 Pelvis") or ent:LookupBone("bip01_pelvis") or ent:LookupBone("ValveBiped.Bip01_Pelvis")) then
        local findPos = ent:GetPos()
        local findMDL = ent:GetModel()
        timer.Simple(0, function()
            for _, v in pairs(ents.FindInSphere(findPos, 1)) do
                if IsValid(v) && GetConVar("ai_serverragdolls"):GetInt() == 1 && v:GetClass() == "prop_ragdoll" && v:GetModel() == findMDL then
                    v:Remove()
                end
            end
        end)
        if IsValid(ent:GetParent()) then
            ent:SetPos(ent:GetParent():GetAttachment(ent:GetParentAttachment()).Pos)
            ent:SetParent(NULL)
        end
        if ent.IsVJBaseSNPC then
            ent.HasDeathCorpse = false
            ent.DeathAnimationTime = 5
            //ent.DeathDelayTime = 5
            ent.CanGib = false
        end
        if ent.IsDrGNextbot then
            ent.RagdollOnDeath = false
        end
        if ent:IsPlayer() then
            local plyRag = ent:GetRagdollEntity()
            if IsValid(plyRag) then
                plyRag:Remove()
            end
        end
        if ent:IsNPC() or ent:IsNextBot() then
            if ent:IsNPC() && !ent.IsVJBaseSNPC then
                local wep = ent:GetActiveWeapon()
                if IsValid(wep) then
                    wep:Remove()
                end
            end
            ent.HasRagdoll = false
        end
        local entDeath = VJ.PICK(ent.AnimTbl_Death)
        timer.Simple(0, function() if IsValid(ent) then ent:PlayAnim(entDeath, true, false) end end)
        timer.Simple(VJ.AnimDuration(ent, entDeath), function()
            if IsValid(ent) then
                local entClass = ent:GetClass()
                local entPos = ent:GetPos()
                local zomList = VJ.PICK({"npc_vj_hlrpar2_zombie", "npc_vj_hlrpar2_zombie_v1", "npc_vj_hlrpar2_zclassic"})
                local zomCloneList = VJ.PICK({"npc_vj_hlrpar1_zclone", "npc_vj_hlrpar1_zclone_v1", "npc_vj_hlrpar1_zclone_armed"})
                local zombie = ents.Create(
                    (cloneList[entClass] && zomCloneList) or (spetsnazList[entClass] && "npc_vj_hlrpar1_zalpha")
                    or (entClass == "npc_vj_hlrpar1_scientist" && "npc_vj_hlrpar2_zscientist") or (sciFemaleList[entClass] && "npc_vj_hlrpar2_zscientist_fem") or (hazmatSciList[entClass] && "npc_vj_hlrpar2_zhazmat") or zomList
                )
                if ent.VJ_ID_Living then
                    zombie:SetPos(entPos)
                    zombie:SetAngles(ent:GetAngles())
                    zombie.Zombie_Turned = true
                    zombie.GodMode = true
                    zombie:Spawn()
                    undo.ReplaceEntity(ent, zombie)
                end
                if ent:IsPlayer() then
                    ent:Spectate(OBS_MODE_CHASE)
                    ent:SpectateEntity(zombie)
                end
                ent:PlaySoundSystem("Gib", "vj_parr/par1/shared/bodysplat.wav")
                if ent.HasGibOnDeathEffects then
                    local effectData = EffectData()
                    effectData:SetOrigin(entPos + ent:OBBCenter())
                    effectData:SetColor(colorRed)
                    effectData:SetScale(80)
                    util.Effect("VJ_Blood1", effectData)
                    effectData:SetScale(8)
                    effectData:SetFlags(3)
                    effectData:SetColor(0)
                    util.Effect("bloodspray", effectData)
                    util.Effect("bloodspray", effectData)
                end
                timer.Simple(1, function()
                    if IsValid(zombie) then
                        zombie.GodMode = false
                        if timer.Exists("timer_melee_bleed" .. zombie:EntIndex()) then timer.Remove("timer_melee_bleed" .. zombie:EntIndex()) end
                    end
                end)
                local wepEnt = ent.WeaponEntity
                if IsValid(wepEnt) then wepEnt:Remove() end
                ent:Remove()
            end
        end)
    end
end