include("entities/npc_vj_hlrpar1_zspider/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/early/spider_v1.mdl"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
    local npcState = self:GetNPCState()
    local speed = FrameTime() * 20
    local eyeParameter = self:GetPoseParameter("eye_move")
    if !self.Spider_EyeOpen && (npcState == NPC_STATE_ALERT or npcState == NPC_STATE_COMBAT) then
        self:SetPoseParameter("eye_move", Lerp(speed, eyeParameter, 90))
        timer.Simple(1, function() if IsValid(self) && !self.Spider_EyeOpen then self.Spider_EyeOpen = true end end)
    elseif self.Spider_EyeOpen && npcState == NPC_STATE_IDLE then
        self:SetPoseParameter("eye_move", Lerp(speed, eyeParameter, 0))
        timer.Simple(1, function() if IsValid(self) && self.Spider_EyeOpen then self.Spider_EyeOpen = false end end)
    end
end