ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"
ENT.PrintName = "Zombie Spider"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Category = "Paranoia Resurgence"

ENT.VJ_ID_Headcrab = true
ENT.VJ_ID_Undead = true

if CLIENT then
    if EmissiveSys then
        EmissiveSys:Add("models/vj_parr/par2/zombie/mutant_spider/m_spider", {
            Brightness = 1,
            Color = {0.5, 0.5, 0.5},
            Mask = "models/vj_parr/par2/zombie/mutant_spider/m_spider_luma"
        })
    end
end