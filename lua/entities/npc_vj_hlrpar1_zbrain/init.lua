AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_base/projectiles/spit_acid_large.mdl"
ENT.StartHealth = 1
ENT.GodMode = true
ENT.HullType = HULL_HUMAN
ENT.SightAngle = 360
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Bleeds = false
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}

ENT.HasMeleeAttack = false

ENT.DeathAnimationDecreaseLengthAmount = -1
ENT.DeathCorpseEntityClass = "prop_vj_animatable"

ENT.HasSoundTrack = true

ENT.SoundTbl_SpawnZombies = {"vj_parr/par1/brain/deadsignal1.wav", "vj_parr/par1/brain/deadsignal2.wav", "vj_parr/par1/brain/deadsignal3.wav", "vj_parr/par1/brain/deadsignal4.wav", "vj_parr/par1/brain/deadsignal5.wav", "vj_parr/par1/brain/deadsignal6.wav"}
ENT.SoundTbl_SoundTrack = "vj_parr/par1/brain/track23.mp3"

ENT.MainSoundPitch = 100

ENT.AlertSoundLevel = 80

-- Custom
ENT.Brain_LostBodies = false
ENT.Brain_Buffing = false
ENT.Brain_BodyCount = 0
ENT.Brain_ZombieCount = 0
ENT.Brain_ZombieLimit = 8
ENT.Brain_NextZombieSpawnT = 0
ENT.Brain_NextBuffT = 0

local zombieList = {
    "npc_vj_hlrpar1_zombie",
    "npc_vj_hlrpar1_zombie_v1",
    "npc_vj_hlrpar1_zombie",
    "npc_vj_hlrpar1_zombie_v1",
    "npc_vj_hlrpar1_zombie",
    "npc_vj_hlrpar1_zombie_v1",
    "npc_vj_hlrpar1_z3h",
    "npc_vj_hlrpar1_z3h_v1",
    "npc_vj_hlrpar1_z3h",
    "npc_vj_hlrpar1_z3h_v1",
    "npc_vj_hlrpar1_z4h",
    "npc_vj_hlrpar1_z4h_v1",
    "npc_vj_hlrpar1_z4h",
    "npc_vj_hlrpar1_z4h_v1",
    "npc_vj_hlrpar1_zdog",
    "npc_vj_hlrpar1_zspider",
    "npc_vj_hlrpar1_zspider_v1",
    "npc_vj_hlrpar1_zspider_v2"
}
local CurTime = CurTime
local math_random = math.random
local math_rand = math.Rand
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self.Zombies = {}

    -- Spawn the body parts
    local myPos = self:GetPos()
    local myAng = self:GetAngles()
    local myForward = self:GetForward()
    local myRight = self:GetRight()

    local brainTree = ents.Create("npc_vj_hlrpar1_zbrain_tree")
    brainTree:SetPos(myPos)
    brainTree:SetAngles(myAng)
    brainTree:SetOwner(self)
    brainTree:SetParent(self)
    brainTree.PhysgunDisabled = true
    brainTree.VJ_NPC_Class = self.VJ_NPC_Class
    brainTree.Brain_Ent = self
    brainTree.DoNotDuplicate = true -- Otherwise you will have double body parts
    brainTree:Spawn()
    self:SetRelationshipMemory(brainTree, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    brainTree:SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    self.BrainTree = brainTree

    local brainBody = ents.Create("npc_vj_hlrpar1_zbrain_body")
    brainBody:SetModel("models/vj_parr/par1/brain_trup1.mdl")
    brainBody:SetPos(myPos + myForward * 20)
    brainBody:SetAngles(myAng)
    brainBody:SetOwner(self)
    brainBody:SetParent(self)
    brainBody.PhysgunDisabled = true
    brainBody.VJ_NPC_Class = self.VJ_NPC_Class
    brainBody.Brain_Ent = self
    brainBody.DoNotDuplicate = true -- Otherwise you will have double body parts
    brainBody:Spawn()
    self.Brain_BodyCount = self.Brain_BodyCount + 1
    self:SetRelationshipMemory(brainBody, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    brainBody:SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    self.BrainBody = brainBody

    local brainBody2 = ents.Create("npc_vj_hlrpar1_zbrain_body")
    brainBody2:SetModel("models/vj_parr/par1/brain_trup2.mdl")
    brainBody2:SetPos(myPos + myRight * -80)
    brainBody2:SetAngles(myAng)
    brainBody2:SetOwner(self)
    brainBody2:SetParent(self)
    brainBody2.PhysgunDisabled = true
    brainBody2.VJ_NPC_Class = self.VJ_NPC_Class
    brainBody2.Brain_Ent = self
    brainBody2.DoNotDuplicate = true -- Otherwise you will have double body parts
    brainBody2:Spawn()
    self.Brain_BodyCount = self.Brain_BodyCount + 1
    self:SetRelationshipMemory(brainBody2, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    brainBody2:SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    self.BrainBody2 = brainBody2

    local brainBody3 = ents.Create("npc_vj_hlrpar1_zbrain_body")
    brainBody3:SetModel("models/vj_parr/par1/brain_trup3.mdl")
    brainBody3:SetPos(myPos + myRight * 180)
    brainBody3:SetAngles(myAng)
    brainBody3:SetOwner(self)
    brainBody3:SetParent(self)
    brainBody3.PhysgunDisabled = true
    brainBody3.VJ_NPC_Class = self.VJ_NPC_Class
    brainBody3.Brain_Ent = self
    brainBody3.DoNotDuplicate = true -- Otherwise you will have double body parts
    brainBody3:Spawn()
    self.Brain_BodyCount = self.Brain_BodyCount + 1
    self:SetRelationshipMemory(brainBody3, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    brainBody3:SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    self.BrainBody3 = brainBody3

    local brainBody4 = ents.Create("npc_vj_hlrpar1_zbrain_body")
    brainBody4:SetModel("models/vj_parr/par1/brain_trup4.mdl")
    brainBody4:SetPos(myPos + myForward * -170)
    brainBody4:SetAngles(myAng)
    brainBody4:SetOwner(self)
    brainBody4:SetParent(self)
    brainBody4.PhysgunDisabled = true
    brainBody4.VJ_NPC_Class = self.VJ_NPC_Class
    brainBody4.Brain_Ent = self
    brainBody4.DoNotDuplicate = true -- Otherwise you will have double body parts
    brainBody4:Spawn()
    self.Brain_BodyCount = self.Brain_BodyCount + 1
    self:SetRelationshipMemory(brainBody4, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    brainBody4:SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    self.BrainBody4 = brainBody4

    local curTime = CurTime()
    self.Brain_NextBuffT = curTime + math_rand(5, 10)
    self:SetNoDraw(true)
    self:AddFlags(FL_NOTARGET)
    self:SetCollisionBounds(Vector(55, 55, 320), Vector(-55, -55, 0))
    //self:SetSurroundingBounds(Vector(250, 250, 500), Vector(-250, -250, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply, controlEnt)
    ply:ChatPrint("RELOAD: Buff Nearby Zombies")
    ply:ChatPrint("JUMP: Spawn Zombies")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
    if !self.GodMode && !self.Dead then self.GodMode = true end
    -- Make tree vulerable when we lose our 4 bodies
    if !self.Brain_LostBodies && self.Brain_BodyCount <= 0 && IsValid(self.BrainTree) then
        local brainTree = self.BrainTree
        self.Brain_LostBodies = true
        brainTree.GodMode = false
        brainTree:RemoveFlags(FL_NOTARGET)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = Color(130, 19, 10)
local beamEffectTbl = {material = "vj_hl/sprites/shockwave", framerate = 20, flags = 0}
--
function ENT:OnThinkActive()
    if self.Dead then return end
    local curTime = CurTime()
    local eneData = self.EnemyData
    local ene = eneData.Target
    local controlled = self.VJ_Controlled
    local ply = self.VJ_Controlled && self.VJ_Controller:GetPlayer()
    if IsValid(ene) && curTime > self.Brain_NextZombieSpawnT && ((!controlled) or (controlled && ply:KeyDown(IN_JUMP))) then
        for i = 1, 4 do
            if self.Brain_ZombieCount < self.Brain_ZombieLimit then
                local zombie = ents.Create(VJ.PICK(zombieList))
                local opSide = ((i % 2 == 0) && -150) or 150
                zombie:SetPos(self:GetPos() + self:GetForward() * (i <= 2 && -150 or (i <= 4 && 150 or 0)) + self:GetRight() * opSide + self:GetUp() * 15)
                zombie:SetAngles(self:GetAngles())
                zombie.VJ_NPC_Class = self.VJ_NPC_Class
                zombie.Brain_Ent = self
                zombie:Spawn()
                zombie:SetOwner(self)
                self.Brain_ZombieCount = self.Brain_ZombieCount + 1
                self.Zombies[#self.Zombies + 1] = zombie
                zombie:ForceSetEnemy(ene, true)
                self.Zombie = zombie
                self:PlaySoundSystem("Alert", self.SoundTbl_SpawnZombies)
                -- Fewer bodies, the faster it spawns zombies
                if self.Brain_BodyCount <= 0 then
                    self.Brain_NextZombieSpawnT = curTime + math_rand(2, 6)
                elseif self.Brain_BodyCount <= 1 then
                    self.Brain_NextZombieSpawnT = curTime + math_rand(4, 8)
                elseif self.Brain_BodyCount <= 2 then
                    self.Brain_NextZombieSpawnT = curTime + math_rand(6, 12)
                elseif self.Brain_BodyCount <= 3 then
                    self.Brain_NextZombieSpawnT = curTime + math_rand(8, 16)
                elseif self.Brain_BodyCount <= 4 then
                    self.Brain_NextZombieSpawnT = curTime + math_rand(10, 20)
                end
            end
        end
    end
    if curTime > self.Brain_NextBuffT && ((!controlled && math_random(1, 10) == 1) or (controlled && ply:KeyDown(IN_RELOAD))) then
        for _, v in pairs(ents.FindByClass("npc_vj_*")) do
            if IsValid(v) && v:Visible(self) && VJ.GetNearestDistance(self, v) <= 1000 && !v.Zombie_Buffed && !v.IsVJBaseBullseye then
                if VJ.HasValue(v.VJ_NPC_Class, "CLASS_ZOMBIE") then
                    self.Brain_Buffing = true
                    v.Zombie_Buffed = true
                    v:SetPlaybackRate(1.5)
                end
            end
        end
        if self.Brain_Buffing then
            local myPos = self:GetPos()
            self.Brain_Buffing = false
            self:PlaySoundSystem("Alert", self.SoundTbl_SpawnZombies)
            effects.BeamRingPoint(myPos, 0.3, 2, 1200, 48, 0, colorRed, beamEffectTbl)
            effects.BeamRingPoint(myPos, 0.3, 2, 1600, 64, 0, colorRed, beamEffectTbl)
            self.Brain_NextBuffT = curTime + math_rand(5, 10)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Brain_ZombieDeath()
    self.Brain_ZombieCount = self.Brain_ZombieCount - 1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Brain_BodyDeath()
    self.Brain_BodyCount = self.Brain_BodyCount - 1
end
---------------------------------------------------------------------------------------------------------------------------------------------
/*function ENT:OnDamaged(dmginfo, hitgroup, status)
    if status == "Init" then
        -- Make it immune to DMG_NERVEGAS, based on source code
        if dmginfo:IsDamageType(DMG_NERVEGAS) then
            dmginfo:SetDamage(0)
        end
    elseif status == "PreDamage" then
        -- Take 30% of bullet damage, based on source code
        if dmginfo:IsBulletDamage() then
            dmginfo:ScaleDamage(0.3)
        end
    elseif status == "PostDamage" then
        local myHP = self:Health()
        local myMaxHP = self:GetMaxHealth()
        local brainBody = self.BrainBody
        local brainBody2 = self.BrainBody2
        local brainBody3 = self.BrainBody3
        local brainBody4 = self.BrainBody4
        if myHP <= (myMaxHP * 0.8) && IsValid(brainBody) && brainBody.GodMode then
            brainBody.GodMode = false
            brainBody:TakeDamage(brainBody:Health(), brainBody, brainBody)
        end
        if myHP <= (myMaxHP * 0.6) && IsValid(brainBody2) && brainBody2.GodMode then
            brainBody2.GodMode = false
            brainBody2:TakeDamage(brainBody2:Health(), brainBody2, brainBody2)
        end
        if myHP <= (myMaxHP * 0.4) && IsValid(brainBody3) && brainBody3.GodMode then
            brainBody3.GodMode = false
            brainBody3:TakeDamage(brainBody3:Health(), brainBody3, brainBody3)
        end
        if myHP <= (myMaxHP * 0.2) && IsValid(brainBody4) && brainBody4.GodMode then
            brainBody4.GodMode = false
            brainBody4:TakeDamage(brainBody4:Health(), brainBody4, brainBody4)
        end
    end
end*/
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    if status == "Init" then
        -- Reset buff stats for zombies when killed
        for _, v in pairs(ents.FindByClass("npc_vj_*")) do
            if IsValid(v) && v.Zombie_Buffed then
                v.Zombie_Buffed = false
                v:SetPlaybackRate(self.AnimPlaybackRate)
            end
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    corpse:ResetSequence(self:GetSequence())
    corpse:SetCycle(1)
    corpse:SetMoveType(self:GetMoveType())
    corpse:SetCollisionGroup(self.DeathCorpseCollisionType)
    local minBounds, maxBounds = self:GetCollisionBounds()
    corpse:SetCollisionBounds(Vector(minBounds.x, maxBounds.y, 5), Vector(-minBounds.x, -maxBounds.y, 0))
    corpse:SetSurroundingBounds(Vector(minBounds.x * 100, maxBounds.y * 100, 5 * 100), Vector(-minBounds.x * 100, -maxBounds.y * 100, 0))

    local myPos = corpse:GetPos()
    local myAng = corpse:GetAngles()
    local myForward = corpse:GetForward()
    local myRight = corpse:GetRight()

    local brainTree = ents.Create("prop_vj_animatable")
    brainTree:SetModel("models/vj_parr/par1/brain_tree.mdl")
    brainTree:SetPos(myPos)
    brainTree:SetAngles(myAng)
    brainTree:SetParent(corpse)
    brainTree.PhysgunDisabled = true
    brainTree:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainTree:Spawn()
    brainTree:ResetSequence("die")
    brainTree:SetCycle(1)

    local brainBody = ents.Create("prop_vj_animatable")
    brainBody:SetModel("models/vj_parr/par1/brain_trup1.mdl")
    brainBody:SetPos(myPos + myForward * 20)
    brainBody:SetAngles(myAng)
    brainBody:SetParent(corpse)
    brainBody.PhysgunDisabled = true
    brainBody:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainBody:Spawn()
    brainBody:ResetSequence("die")
    brainBody:SetCycle(1)

    local brainBody2 = ents.Create("prop_vj_animatable")
    brainBody2:SetModel("models/vj_parr/par1/brain_trup2.mdl")
    brainBody2:SetPos(myPos + myRight * -80)
    brainBody2:SetAngles(myAng)
    brainBody2:SetParent(corpse)
    brainBody2.PhysgunDisabled = true
    brainBody2:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainBody2:Spawn()
    brainBody2:ResetSequence("die")
    brainBody2:SetCycle(1)

    local brainBody3 = ents.Create("prop_vj_animatable")
    brainBody3:SetModel("models/vj_parr/par1/brain_trup3.mdl")
    brainBody3:SetPos(myPos + myRight * 180)
    brainBody3:SetAngles(myAng)
    brainBody3:SetParent(corpse)
    brainBody3.PhysgunDisabled = true
    brainBody3:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainBody3:Spawn()
    brainBody3:ResetSequence("die")
    brainBody3:SetCycle(1)

    local brainBody4 = ents.Create("prop_vj_animatable")
    brainBody4:SetModel("models/vj_parr/par1/brain_trup4.mdl")
    brainBody4:SetPos(myPos + myForward * -170)
    brainBody4:SetAngles(myAng)
    brainBody4:SetParent(corpse)
    brainBody4.PhysgunDisabled = true
    brainBody4:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainBody4:Spawn()
    brainBody4:ResetSequence("die")
    brainBody4:SetCycle(1)

    VJ.HLR_ApplyCorpseSystem(self, corpse, nil, {Gibbable = false})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
    -- Remove zombies but not when killed
    if !self.Dead then
        for _, v in pairs(self.Zombies) do
            if IsValid(v) then v:Remove() end
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
hook.Add("AddNPCKill", "HideSpecificNPCKillfeed", function(npc, attacker, inflictor)
    if npc:GetClass() == "npc_vj_hlrpar1_zbrain" then
        return false
    end
end)