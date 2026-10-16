ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"
ENT.PrintName = "Zombie"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Category = "Paranoia Resurgence"

ENT.VJ_PARR1_NPC = false
ENT.VJ_PARR2_NPC = true

if CLIENT then
    if EmissiveSys then
        EmissiveSys:Add("models/vj_parr/par2/zombie/zsoldier_head2x1", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/zsoldier_head2x1_luma"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/scientist/monster_proff", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/scientist/monster_proff_luma"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/scientist/monster_proff", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/scientist/monster_proff_luma"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/rotten/geo_rotten_eye", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/rotten/geo_rotten_eye"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/rotten/geo_rotten_eye", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/rotten/geo_rotten_eye"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/armed/shootersoldier_head2x1", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/zsoldier_head2x1_luma"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/armed/shootersoldier_headx1", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/armed/shootersoldier_headx1_luma"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/officer/mons_officer_headx1", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/armed/shootersoldier_headx1_luma"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/officer/mons_officer_headx3", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/zsoldier_head2x1_luma"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/mutant_striker/bes", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/mutant_striker/bes_luma"
        })
        EmissiveSys:Add("models/vj_parr/par2/zombie/mutant_striker/bes", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/mutant_striker/bes_luma"
        })
    end
end