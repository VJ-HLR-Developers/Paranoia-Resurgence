/*--------------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
local parVersion = "0.5.0-Beta"

VJ.AddPlugin("Paranoia Resurgence", "NPC", parVersion)

VJ.HLR_VERSION = parVersion

local spawnCategory = "HL Resurgence: Paranoia"
VJ.AddCategoryInfo(spawnCategory, {Icon = "vj_parr/icons/paranoia.png"})
-- Civilians
VJ.AddNPC("Medic", "npc_vj_hlrpar1_medic", spawnCategory)
VJ.AddNPC("Paulina Korolev", "npc_vj_hlrpar1_scientist_paulina", spawnCategory)
VJ.AddNPC("Scientist", "npc_vj_hlrpar1_scientist", spawnCategory)
VJ.AddNPC("Scientist (Female)", "npc_vj_hlrpar1_scientist_female", spawnCategory)
VJ.AddNPC("Scientist (Hazmat)", "npc_vj_hlrpar1_scientist_hazmat", spawnCategory)
VJ.AddNPC("Worker", "npc_vj_hlrpar1_civilian", spawnCategory)
-- Russian Military
VJ.AddNPC("Russian Mil Mi-24", "npc_vj_hlrpar1_russian_mil", spawnCategory)
VJ.AddNPC("Russian GRU Soldier", "npc_vj_hlrpar1_russian_gru", spawnCategory)
VJ.AddNPC("Russian National Guard", "npc_vj_hlrpar1_russian_ng", spawnCategory)
VJ.AddNPC("Russian Soldier", "npc_vj_hlrpar1_russian_army", spawnCategory)
VJ.AddNPC("Russian Spetsnaz Soldier", "npc_vj_hlrpar1_russian_alpha", spawnCategory)
VJ.AddNPC("Russian Spetsnaz Soldier (Savior)", "npc_vj_hlrpar1_russian_alphasav", spawnCategory)
-- Terrorists
VJ.AddNPC("Terrorist", "npc_vj_hlrpar1_terrorist", spawnCategory)
VJ.AddNPC("Terrorist (Early)", "npc_vj_hlrpar1_terrorist_early", spawnCategory)
VJ.AddNPC("Terrorist (Shahid)", "npc_vj_hlrpar1_terrorist_shahid", spawnCategory)
-- Saboteurs
VJ.AddNPC("Black Ops Soldier", "npc_vj_hlrpar1_blackops", spawnCategory)
VJ.AddNPC("Saboteur", "npc_vj_hlrpar1_saboteur", spawnCategory)
VJ.AddNPC("Saboteur Kamov Ka-50", "npc_vj_hlrpar1_saboteur_kamov", spawnCategory)
-- Clones
VJ.AddNPC("Clone Soldier", "npc_vj_hlrpar1_clone", spawnCategory)
VJ.AddNPC("Clone Soldier (Early)", "npc_vj_hlrpar1_clone_early", spawnCategory)
VJ.AddNPC("Clone Heavy Soldier", "npc_vj_hlrpar1_clone_heavy", spawnCategory)
VJ.AddNPC("Clone Heavy Soldier (Early)", "npc_vj_hlrpar1_clone_heavy_early", spawnCategory)
-- Zombies
VJ.AddNPC("Zombie", "npc_vj_hlrpar1_zombie", spawnCategory)
VJ.AddNPC("Zombie (Early)", "npc_vj_hlrpar1_zombie_early", spawnCategory)
VJ.AddNPC("Zombie Clone", "npc_vj_hlrpar1_zombie_clone", spawnCategory)
VJ.AddNPC("Zombie Clone (Armed)", "npc_vj_hlrpar1_zombie_clone_armed", spawnCategory)
VJ.AddNPC("Zombie Hazmat Scientist", "npc_vj_hlrpar1_zombie_hazmat", spawnCategory)
VJ.AddNPC("Zombie Mutant", "npc_vj_hlrpar1_zombie_mutant", spawnCategory)
VJ.AddNPC("Zombie Mutant (Early)", "npc_vj_hlrpar1_zombie_mutant", spawnCategory)
VJ.AddNPC("Zombie Mutant (3-Handed)", "npc_vj_hlrpar1_zombie_mutant_3h", spawnCategory)
VJ.AddNPC("Zombie Mutant (Ceiling)", "npc_vj_hlrpar1_zombie_mutant_ceiling", spawnCategory)
VJ.AddNPC("Zombie Mutant (Spider)", "npc_vj_hlrpar1_zombie_mutant_spider", spawnCategory)
VJ.AddNPC("Zombie Mutant (Spider) (Early)", "npc_vj_hlrpar1_zombie_mutant_spider_early", spawnCategory)
-- Animals
VJ.AddNPC("Rat", "npc_vj_hlrpar1_rat", spawnCategory)

-- Decals --
game.AddDecal("VJ_PARR_Blood_Red", {"vj_parr/decals/parr_blood01", "vj_parr/decals/parr_blood02", "vj_parr/decals/parr_blood03", "vj_parr/decals/parr_blood04", "vj_parr/decals/parr_blood05", "vj_parr/decals/parr_blood06", "vj_parr/decals/parr_blood07"})
game.AddDecal("VJ_PARR_Scorch", {"vj_parr/decals/scorch0", "vj_parr/decals/scorch1", "vj_parr/decals/scorch2", "vj_parr/decals/scorch3"})

-- Particles --
VJ.AddParticle("particles/vj_parr_blood.pcf", {
    "vj_parr_blood_red",
    "vj_parr_blood_red_large",
    "vj_parr_blood_boob_red"
})

-- Add to paint tool
list.Add("PaintMaterials", "VJ_PARR_Blood_Red")
list.Add("PaintMaterials", "VJ_PARR_Scorch")

-- Weapon Sounds
local SNDLVL_GUNFIRE = 140
local PITCH_RANDOM = {90, 110}

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