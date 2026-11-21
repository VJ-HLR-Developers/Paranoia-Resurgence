ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"
ENT.PrintName = "Saboteur Kamov Ka-50 (V1)"
ENT.Author = "Darkborn"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Information = "Attack helicopters from the foreign sabotage group."
ENT.Category = "Paranoia Resurgence"

local CurTime = CurTime
local math_random = math.random
local math_rand = math.Rand

if CLIENT then
    ENT.Heli_NextSmoke = 0
    function ENT:Draw()
        self:DrawModel()
        local curTime = CurTime()
        if IsValid(self) and curTime > self.Heli_NextSmoke then
            local lvl = self:GetNW2Int("Heli_SmokeLevel")
            self.Heli_NextSmoke = curTime + 0.1
            if lvl > 0 then
                local emitter = ParticleEmitter(self:GetPos())
                local smoke1 = emitter:Add("vj_hl/sprites/steam1", self:GetAttachment(self:LookupAttachment("rotor_tail")).Pos)
                smoke1:SetVelocity(self:GetUp() * 100 + VectorRand(-30, 30))
                smoke1:SetDieTime(2)
                smoke1:SetStartSize(30)
                smoke1:SetEndSize(30 + math_random(0, 9))
                smoke1:SetRoll(math_rand(-2, 2))
                smoke1:SetEndAlpha(0)
                if lvl == 2 then
                    local smoke2 = emitter:Add("vj_hl/sprites/steam1", self:GetAttachment(self:LookupAttachment("rotor")).Pos)
                    smoke2:SetVelocity(self:GetUp() * 100 + VectorRand(-30, 30))
                    smoke2:SetDieTime(2)
                    smoke2:SetStartSize(50)
                    smoke2:SetEndSize(50 + math_random(0, 9))
                    smoke2:SetRoll(math_rand(-2, 2))
                    smoke2:SetEndAlpha(0)
                end
                emitter:Finish()
            end
        end
    end
end