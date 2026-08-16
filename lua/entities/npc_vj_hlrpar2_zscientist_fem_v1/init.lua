include("entities/npc_vj_hlrpar2_zscientist_fem/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/vj_parr/par2/v1/scientist_female_zombie1.mdl", "models/vj_parr/par2/v1/scientist_female_zombie_fresh.mdl"}
ENT.CanFlinch = false
ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIE_HEADSHOT, ACT_DIESIMPLE}