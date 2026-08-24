/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
AddCSLuaFile()

ENT.Base = "obj_vj_spawner_base"
ENT.Type = "anim"
ENT.PrintName = "Random Zombie Spawner (Single)"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Category = "Paranoia Resurgence"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

local entsList = {
    "npc_vj_hlrpar1_zombie",
    "npc_vj_hlrpar1_zombie_early",
    "npc_vj_hlrpar1_z4h_early:10",
    "npc_vj_hlrpar1_z3h:15",
    "npc_vj_hlrpar1_z3h_early:15",
    "npc_vj_hlrpar1_zclone:10",
    "npc_vj_hlrpar1_zclone_early:10",
    "npc_vj_hlrpar1_zclone_armed:15",
    "npc_vj_hlrpar1_zdog:20",
    "npc_vj_hlrpar1_zhazmat:5",
    "npc_vj_hlrpar1_zscientist:5",
    "npc_vj_hlrpar1_zscientist_fem:5",
    "npc_vj_hlrpar1_zalpha:10",
    "npc_vj_hlrpar1_zspider:25",
    "npc_vj_hlrpar1_zspider_early_v2:25",
    "npc_vj_hlrpar1_zspider_early:25"
}
ENT.EntitiesToSpawn = {
    {SpawnPosition = Vector(), Entities = entsList},
}