/*-----------------------------------------------
    *** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
AddCSLuaFile()

ENT.Base = "obj_vj_spawner_base"
ENT.Type = "anim"
ENT.PrintName = "Random Zombie Spawner"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Category = "Paranoia Resurgence"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

local entsList = {
    "npc_vj_hlrpar2_zombie",
    "npc_vj_hlrpar2_zclone:20",
    "npc_vj_hlrpar2_zarmed_elite:15",
    "npc_vj_hlrpar2_zarmed_officer:15",
    "npc_vj_hlrpar2_zarmed:10",
    "npc_vj_hlrpar2_zarmed_v1:10",
    "npc_vj_hlrpar2_zrotten:5",
    "npc_vj_hlrpar2_zofficer:20",
    "npc_vj_hlrpar2_zhazmat:5",
    "npc_vj_hlrpar2_zrhb:10",
    "npc_vj_hlrpar2_zscientist:5",
    "npc_vj_hlrpar2_zscientist_fem:5",
    "npc_vj_hlrpar2_zscientist_fem_v1:5",
    "npc_vj_hlrpar2_zspider:15",
    "npc_vj_hlrpar2_zstriker:25"
}
ENT.EntitiesToSpawn = {
    {SpawnPosition = Vector(), Entities = entsList},
    {SpawnPosition = Vector(50, 50, 0), Entities = entsList},
    {SpawnPosition = Vector(50, -50, 0), Entities = entsList},
    {SpawnPosition = Vector(-50, 50, 0), Entities = entsList},
    {SpawnPosition = Vector(-50, -50, 0), Entities = entsList},
}