ENT.Base = "npc_vj_tankg_base"
ENT.Type = "ai"
ENT.PrintName = "Russian BTR-80"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Category = "Paranoia Resurgence"

ENT.VJ_PARR1_NPC = false
ENT.VJ_PARR2_NPC = true

if CLIENT then
    VJ.AddKillIcon("npc_vj_hlrpar2_rus_btr80_gun", ENT.PrintName)
end