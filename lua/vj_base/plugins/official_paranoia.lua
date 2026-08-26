/*--------------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
local parVersion = "0.7.0-Beta"

VJ.AddPlugin("Paranoia Resurgence", "NPC", parVersion)

VJ.HLR_VERSION = parVersion

local spawnCategory = "HL Resurgence: Paranoia"
VJ.AddCategoryInfo(spawnCategory, {Icon = "vj_parr/icons/paranoia.png"})
local subCategory = "Russians"
-- Civilians
VJ.AddNPC("Medic", "npc_vj_hlrpar1_medic", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Paulina Korolev", "npc_vj_hlrpar1_paulina", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Scientist", "npc_vj_hlrpar1_scientist", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Scientist (Female)", "npc_vj_hlrpar1_sci_fem", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Scientist (Hazmat)", "npc_vj_hlrpar1_sci_haz", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Worker", "npc_vj_hlrpar1_worker", spawnCategory, {SubCategory = subCategory})
-- Russian Military
VJ.AddNPC("Russian General", "npc_vj_hlrpar1_rus_general", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian GRU Soldier", "npc_vj_hlrpar1_rus_gru", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian Mil Mi-24", "npc_vj_hlrpar1_rus_mil", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian National Guard", "npc_vj_hlrpar1_rus_ng", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian Soldier", "npc_vj_hlrpar1_rus_soldier", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian Soldier (Early)", "npc_vj_hlrpar1_rus_soldier_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian Soldier (Early V2)", "npc_vj_hlrpar1_rus_soldier_early_v2", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian Spetsnaz Soldier", "npc_vj_hlrpar1_rus_alpha", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian Spetsnaz Soldier (Early)", "npc_vj_hlrpar1_rus_alpha_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian Spetsnaz Soldier (Early V2)", "npc_vj_hlrpar1_rus_alpha_early_v2", spawnCategory, {SubCategory = subCategory})
-- Terrorists
subCategory = "Terrorists"
VJ.AddNPC("Terrorist", "npc_vj_hlrpar1_terrorist", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Terrorist (Early)", "npc_vj_hlrpar1_ter_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Terrorist (Shahid)", "npc_vj_hlrpar1_ter_shahid", spawnCategory, {SubCategory = subCategory})
-- Saboteurs
subCategory = "Saboteurs"
VJ.AddNPC("Saboteur (Black Ops)", "npc_vj_hlrpar1_sab_blackops", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Saboteur", "npc_vj_hlrpar1_saboteur", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Saboteur Kamov Ka-50", "npc_vj_hlrpar1_sab_kamov", spawnCategory, {SubCategory = subCategory})
-- Clones
subCategory = "Clones"
VJ.AddNPC("Clone Soldier", "npc_vj_hlrpar1_clone", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Clone Soldier (Early)", "npc_vj_hlrpar1_clo_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Clone Heavy Soldier", "npc_vj_hlrpar1_clo_heavy", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Clone Heavy Soldier (Early)", "npc_vj_hlrpar1_clo_heavy_early", spawnCategory, {SubCategory = subCategory})
-- Zombies
subCategory = "Zombies"
VJ.AddNPC("Zombie", "npc_vj_hlrpar1_zombie", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie (Early)", "npc_vj_hlrpar1_zombie_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie 4-Handed Mutant", "npc_vj_hlrpar1_z4h", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie 4-Handed Mutant (Early)", "npc_vj_hlrpar1_z4h_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie 3-Handed Mutant", "npc_vj_hlrpar1_z3h", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie 3-Handed Mutant (Early)", "npc_vj_hlrpar1_z3h_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Clone", "npc_vj_hlrpar1_zclone", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Clone (Armed)", "npc_vj_hlrpar1_zclone_armed", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Clone (Early)", "npc_vj_hlrpar1_zclone_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Dog Mutant", "npc_vj_hlrpar1_zdog", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Hazmat Scientist", "npc_vj_hlrpar1_zhazmat", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Ceiling Mutant", "npc_vj_hlrpar1_zceiling", spawnCategory, {SubCategory = subCategory, OnCeiling = true, Offset = 0})
VJ.AddNPC("Zombie Ceiling Mutant (Early)", "npc_vj_hlrpar1_zceiling_early", spawnCategory, {SubCategory = subCategory, OnCeiling = true, Offset = 0})
VJ.AddNPC("Zombie Scientist", "npc_vj_hlrpar1_zscientist", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Scientist (Female)", "npc_vj_hlrpar1_zscientist_fem", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Spetsnaz Soldier", "npc_vj_hlrpar1_zalpha", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Spider Mutant", "npc_vj_hlrpar1_zspider", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Spider Mutant (Early V2)", "npc_vj_hlrpar1_zspider_early_v2", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Spider Mutant (Early)", "npc_vj_hlrpar1_zspider_early", spawnCategory, {SubCategory = subCategory})
-- Animals
VJ.AddNPC("Rat", "npc_vj_hlrpar1_rat", spawnCategory)
-- Spawners
VJ.AddNPC("Random Zombie", "sent_vj_hlrpar1_zombie", spawnCategory)
VJ.AddNPC("Random Zombie Spawner", "sent_vj_hlrpar1_zsp", spawnCategory)
VJ.AddNPC("Random Zombie Spawner (Single)", "sent_vj_hlrpar1_zsin", spawnCategory)

spawnCategory = "HL Resurgence: Paranoia 2: Savior"
VJ.AddCategoryInfo(spawnCategory, {Icon = "vj_parr/icons/paranoia2.png"})
subCategory = "Russians"
-- Civilians
VJ.AddNPC("Paulina Korolev", "npc_vj_hlrpar2_paulina", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Professor Pirogov", "npc_vj_hlrpar2_pirogov", spawnCategory, {SubCategory = subCategory})
-- Russian Military
VJ.AddNPC("Russian Soldier", "npc_vj_hlrpar2_rus_soldier", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Russian Spetsnaz Soldier", "npc_vj_hlrpar2_rus_alpha", spawnCategory, {SubCategory = subCategory})
-- Clones
subCategory = "Clones"
VJ.AddNPC("Clone Soldier", "npc_vj_hlrpar2_clone", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Clone Soldier (1.0)", "npc_vj_hlrpar2_clone_v1", spawnCategory, {SubCategory = subCategory})
-- Zombies
subCategory = "Zombies"
VJ.AddNPC("Zombie", "npc_vj_hlrpar2_zombie", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie (Early)", "npc_vj_hlrpar2_zombie_early", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Clone Soldier", "npc_vj_hlrpar2_zclone", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Elite Shooter", "npc_vj_hlrpar2_zarmed_elite", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Elite Officer Shooter", "npc_vj_hlrpar2_zarmed_officer", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Shooter", "npc_vj_hlrpar2_zarmed", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Shooter (1.0)", "npc_vj_hlrpar2_zarmed_v1", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie (Rotten)", "npc_vj_hlrpar2_zrotten", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Officer", "npc_vj_hlrpar2_zofficer", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Hazmat Scientist", "npc_vj_hlrpar2_zhazmat", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie RHB Soldier", "npc_vj_hlrpar2_zrhb", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Scientist", "npc_vj_hlrpar2_zscientist", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Scientist (Female)", "npc_vj_hlrpar2_zscientist_fem", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Scientist (Female) (1.0)", "npc_vj_hlrpar2_zscientist_fem_v1", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Spider", "npc_vj_hlrpar2_zspider", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Zombie Striker Mutant", "npc_vj_hlrpar2_zstriker", spawnCategory, {SubCategory = subCategory})
-- Animals
VJ.AddNPC("Rat", "npc_vj_hlrpar2_rat", spawnCategory)
-- Spawners
VJ.AddNPC("Random Zombie", "sent_vj_hlrpar2_zombie", spawnCategory)
VJ.AddNPC("Random Zombie Spawner", "sent_vj_hlrpar2_zsp", spawnCategory)
VJ.AddNPC("Random Zombie Spawner (Single)", "sent_vj_hlrpar2_zsin", spawnCategory)

-- Decals --
game.AddDecal("VJ_PARR1_Blood_Red", {"vj_parr/decals/parr1_blood01", "vj_parr/decals/parr1_blood02", "vj_parr/decals/parr1_blood03", "vj_parr/decals/parr1_blood04", "vj_parr/decals/parr1_blood05", "vj_parr/decals/parr1_blood06", "vj_parr/decals/parr1_blood07"})
game.AddDecal("VJ_PARR1_Blood_Red_Large", {"vj_parr/decals/parr1_bloodbigsplat", "vj_parr/decals/parr1_bloodbigsplat2"})
game.AddDecal("VJ_PARR1_Brains", "vj_parr/decals/parr1_brains")
game.AddDecal("VJ_PARR1_Impact", "vj_parr/decals/parr1_shot")
game.AddDecal("VJ_PARR1_Scorch", {"vj_parr/decals/parr1_scorch1", "vj_parr/decals/parr1_scorch2", "vj_parr/decals/parr1_scorch3"})
game.AddDecal("VJ_PARR2_Blood_Red", {"vj_parr/decals/parr2_blood1", "vj_parr/decals/parr2_blood2", "vj_parr/decals/parr2_blood3", "vj_parr/decals/parr2_blood4", "vj_parr/decals/parr2_blood5", "vj_parr/decals/parr2_blood6", "vj_parr/decals/parr2_blood7"})
game.AddDecal("VJ_PARR2_Impact", {"vj_parr/decals/parr2_shot1", "vj_parr/decals/parr2_shot2", "vj_parr/decals/parr2_shot3"})
game.AddDecal("VJ_PARR2_Scorch", {"vj_parr/decals/parr2_scorch1", "vj_parr/decals/parr2_scorch2", "vj_parr/decals/parr2_scorch3"})

-- Particles --
VJ.AddParticle("particles/vj_parr_blood.pcf", {
    "vj_parr1_blood_red",
    "vj_parr1_blood_red_large",
    "vj_parr1_blood_boob_red",
    "vj_parr2_blood_red",
    "vj_parr2_blood_red_large"
})

-- Add to paint tool
list.Add("PaintMaterials", "VJ_PARR1_Blood_Red")
list.Add("PaintMaterials", "VJ_PARR1_Blood_Red_Large")
list.Add("PaintMaterials", "VJ_PARR1_Brains")
list.Add("PaintMaterials", "VJ_PARR1_Impact")
list.Add("PaintMaterials", "VJ_PARR1_Scorch")
list.Add("PaintMaterials", "VJ_PARR2_Blood_Red")
list.Add("PaintMaterials", "VJ_PARR2_Impact")
list.Add("PaintMaterials", "VJ_PARR2_Scorch")

-- Weapon Sounds
local SNDLVL_GUNFIRE = 140
local PITCH_RANDOM = {90, 110}

-- Paranoia --
sound.Add({
    name = "VJ.PARR1_AK74.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par1/weapons/ak74/ak74-1.wav",
        "^vj_parr/par1/weapons/ak74/ak74-2.wav"
    }
})
sound.Add({
    name = "VJ.PARR1_AKS.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par1/weapons/aks/aks_fire1.wav",
        "^vj_parr/par1/weapons/aks/aks_fire2.wav",
        "^vj_parr/par1/weapons/aks/aks_fire3.wav"
    }
})
sound.Add({
    name = "VJ.PARR1_APS.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound =
        "^vj_parr/par1/weapons/aps/aps_fire.wav"
})
sound.Add({
    name = "VJ.PARR1_Glock17.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound =
        "^vj_parr/par1/weapons/glock/glock_fire.wav"
})
sound.Add({
    name = "VJ.PARR1_Groza.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par1/weapons/groza/groza_fire1.wav",
        "^vj_parr/par1/weapons/groza/groza_fire2.wav",
        "^vj_parr/par1/weapons/groza/groza_fire3.wav"
    }
})
sound.Add({
    name = "VJ.PARR1_MP5.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par1/weapons/mp5/hks1.wav",
        "^vj_parr/par1/weapons/mp5/hks2.wav"
    }
})
sound.Add({
    name = "VJ.PARR1_PKM.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par1/weapons/pkm/rpk_fire1.wav",
        "^vj_parr/par1/weapons/pkm/rpk_fire2.wav",
        "^vj_parr/par1/weapons/pkm/rpk_fire3.wav"
    }
})
sound.Add({
    name = "VJ.PARR1_SPAS12.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par1/weapons/spas12/spas12-1.wav",
        "^vj_parr/par1/weapons/spas12/spas12-2.wav"
    }
})
sound.Add({
    name = "VJ.PARR1_VAL.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par1/weapons/val/val_fire1.wav",
        "^vj_parr/par1/weapons/val/val_fire2.wav",
        "^vj_parr/par1/weapons/val/val_fire3.wav"
    }
})
sound.Add({
    name = "VJ.PARR1_MG.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound =
        "^vj_parr/par1/turret/tu_fire1.wav"
})
sound.Add({
    name = "VJ.PARR1_Explosion.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par1/weapons/explode3.wav",
        "^vj_parr/par1/weapons/explode4.wav",
        "^vj_parr/par1/weapons/explode5.wav"
    }
})
-- Paranoia 2: Savior --
sound.Add({
    name = "VJ.PARR2_AKS.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound =
        "^vj_parr/par2/weapons/aks/aks_fire1.wav"
})
sound.Add({
    name = "VJ.PARR2_AK74.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par2/weapons/ak74/ak74_fire1-inside.wav",
        "^vj_parr/par2/weapons/ak74/ak74_fire2-inside.wav"
    }
})
sound.Add({
    name = "VJ.PARR2_Groza.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound =
        "^vj_parr/par2/weapons/groza/groza-inside.wav"
})
sound.Add({
    name = "VJ.PARR2_PKM.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound =
        "^vj_parr/par2/weapons/pkm/pkm_outside.wav"
})
sound.Add({
    name = "VJ.PARR2_VAL.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound =
        "^vj_parr/par2/weapons/val/vss_fire1.wav"
})
sound.Add({
    name = "VJ.PARR2_Explosion.Single",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = SNDLVL_GUNFIRE,
    pitch = PITCH_RANDOM,
    sound = {
        "^vj_parr/par2/weapons/explode3.wav",
        "^vj_parr/par2/weapons/explode4.wav",
        "^vj_parr/par2/weapons/explode5.wav"
    }
})
---------------------------------------------------------------------------------------------------------------------------------------------
local excludedMats = {
    [MAT_ANTLION] = true,
    [MAT_ALIENFLESH] = true,
    [MAT_BLOODYFLESH] = true,
    [MAT_FLESH] = true
}
--
function VJ.PARR1_Effect_Impact(tr)
    if excludedMats[tr.MatType] then return end
    local effectData = EffectData()
    effectData:SetEntity(tr.Entity)
    effectData:SetStart(tr.StartPos)
    effectData:SetOrigin(tr.HitPos)
    effectData:SetNormal(tr.HitNormal)
    effectData:SetHitBox(tr.HitBox)
    effectData:SetSurfaceProp(tr.SurfaceProps)
    effectData:SetFlags(1)
    util.Effect("Impact_GMOD", effectData)
    util.Decal("VJ_PARR1_Impact", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
    return true
end

function VJ.PARR2_Effect_Impact(tr)
    if excludedMats[tr.MatType] then return end
    local effectData = EffectData()
    effectData:SetEntity(tr.Entity)
    effectData:SetStart(tr.StartPos)
    effectData:SetOrigin(tr.HitPos)
    effectData:SetNormal(tr.HitNormal)
    effectData:SetHitBox(tr.HitBox)
    effectData:SetSurfaceProp(tr.SurfaceProps)
    effectData:SetFlags(1)
    util.Effect("Impact_GMOD", effectData)
    util.Decal("VJ_PARR2_Impact", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
    return true
end

local bit_bor = bit.bor

-- ConVars --
VJ.AddConVar("VJ_HLRPAR_Clone_Ally", 0, bit_bor(FCVAR_ARCHIVE, FCVAR_NOTIFY))
VJ.AddConVar("VJ_HLRPAR_Terrorist_Hostile", 0, bit_bor(FCVAR_ARCHIVE, FCVAR_NOTIFY))

-- Main Configure Menu --
if CLIENT then
    hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_HLRPAR", function()
        spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Paranoia Resurgence", "Paranoia Resurgence", "", "", function(panel)
            if !game.SinglePlayer() && !LocalPlayer():IsAdmin() then
                panel:Help("#vjbase.menu.general.admin.not")
                panel:Help("#vjbase.menu.general.admin.only")
                return
            end
            panel:Help("#vjbase.menu.general.admin.only")
            panel:Help("#vjbase.menu.general.npc.note.future")
            panel:AddControl("Button", {Text = "#vjbase.menu.general.reset.everything", Command = "VJ_HLRPAR_Clone_Ally 0\nVJ_HLRPAR_Terrorist_Hostile 0"})
            panel:Help("Server-Side Options:")
            panel:CheckBox("Clones Are Allies?", "VJ_HLRPAR_Clone_Ally")
            panel:CheckBox("Terrorists Have Their Own Faction?", "VJ_HLRPAR_Terrorist_Hostile")
        end)
    end)
end