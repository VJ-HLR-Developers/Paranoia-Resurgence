ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"
ENT.PrintName = "Saboteur Kamov Ka-50"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Category = "Half-Life Resurgence"

ENT.VJ_ID_Vehicle = true
ENT.VJ_ID_Aircraft = true

if CLIENT then
    ENT.Apache_NextSmoke = 0
    function ENT:Draw()
        self:DrawModel()
        if IsValid(self) && CurTime() > self.Apache_NextSmoke then
            local lvl = self:GetNW2Int("Heli_SmokeLevel")
            self.Apache_NextSmoke = CurTime() + 0.1
            if lvl > 0 then
                local emitter = ParticleEmitter(self:GetPos())
                if lvl == 2 then
                    local smoke = emitter:Add("vj_hl/sprites/steam1", self:GetAttachment(self:LookupAttachment("rotor")).Pos)
                    smoke:SetVelocity(self:GetUp() * 100 + VectorRand(-30, 30))
                    smoke:SetDieTime(2)
                    smoke:SetStartSize(50)
                    smoke:SetEndSize(50 + math.random(0, 9))
                    smoke:SetRoll(math.Rand(-2, 2))
                    smoke:SetEndAlpha(0)
                end
                emitter:Finish()
            end
        end
    end
end