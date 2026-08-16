include("entities/npc_vj_hlrpar1_zombie/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/z_3h.mdl"
ENT.ControllerParams.FirstP_Bone = "Bone09"

ENT.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Init()
    if self:GetModel() == "models/vj_parr/par1/early/zombie.mdl" then
        self.CanFlinch = false
        self.HasDeathAnimation = false
    end
end