include("entities/npc_vj_hlrpar1_clone/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/early/soldier_colba.mdl"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent) return end