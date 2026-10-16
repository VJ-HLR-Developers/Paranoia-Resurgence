ENT.Base = "npc_vj_human_base"
ENT.Type = "ai"
ENT.PrintName = "Clone Soldier"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Category = "Paranoia Resurgence"

ENT.VJ_PARR1_NPC = false
ENT.VJ_PARR2_NPC = true

if CLIENT then
    if EmissiveSys then
        EmissiveSys:Add("models/vj_parr/par2/clone/char_clone_visor", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/clone/char_clone_visor_luma"
        })
    end
end