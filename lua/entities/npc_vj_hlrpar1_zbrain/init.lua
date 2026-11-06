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
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr1_blood_red"
ENT.BloodDecal = "VJ_PARR1_Blood_Red"
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}

ENT.HasMeleeAttack = false

ENT.DeathAnimationDecreaseLengthAmount = -1
ENT.DeathCorpseEntityClass = "prop_vj_animatable"

-- Custom
ENT.Brain_LostBodies = false
ENT.Brain_BodyCount = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    local myPos = self:GetPos()
    local myAng = self:GetAngles()
    local myForward = self:GetForward()
    local myRight = self:GetRight()

    -- Alternative solution to fixing hitboxes on bodies not working correctly due to model size from the tree
    local brainTree = ents.Create("npc_vj_hlrpar1_zbrain_tree")
    brainTree:SetPos(myPos)
    brainTree:SetAngles(myAng)
    brainTree:SetOwner(self)
    brainTree:SetParent(self)
    brainTree.PhysgunDisabled = true
    brainTree.VJ_NPC_Class = self.VJ_NPC_Class
    brainTree.Brain_Ent = self
    brainTree.DoNotDuplicate = true -- Otherwise you will have double trees
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
    brainBody.DoNotDuplicate = true -- Otherwise you will have double bodies
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
    brainBody2.DoNotDuplicate = true -- Otherwise you will have double bodies
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
    brainBody3.DoNotDuplicate = true -- Otherwise you will have double bodies
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
    brainBody4.DoNotDuplicate = true -- Otherwise you will have double bodies
    brainBody4:Spawn()
    self.Brain_BodyCount = self.Brain_BodyCount + 1
    self:SetRelationshipMemory(brainBody4, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    brainBody4:SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI) -- In case relation class is changed dynamically!
    self.BrainBody4 = brainBody4

    self:SetNoDraw(true)
    self:AddFlags(FL_NOTARGET)
    self:SetCollisionBounds(Vector(55, 55, 320), Vector(-55, -55, 0))
    //self:SetSurroundingBounds(Vector(250, 250, 500), Vector(-250, -250, 0))
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
function ENT:Brain_BodyDeath()
    self.Brain_BodyCount = self.Brain_BodyCount - 1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnBleed(dmginfo, hitgroup)
    -- Spawn a unique decal from headshots, based on source code
    if hitgroup == HITGROUP_HEAD then
        self.BloodDecal = "VJ_PARR1_Brains"
    else
        self.BloodDecal = (self.VJ_PARR2_NPC && "VJ_PARR2_Blood_Red") or "VJ_PARR1_Blood_Red"
    end
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
        self.Bleeds = true
        -- Reset buff stats for zombies when killed
        for _, v in pairs(ents.FindByClass("npc_vj_*")) do
            if IsValid(v) && v.Zombie_Buffed then
                v.Zombie_Buffed = false
                v:SetPlaybackRate(v.AnimPlaybackRate)
            end
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
    corpse:SetModel("models/vj_parr/par1/brain_tree.mdl")
    corpse:ResetSequence("die")
    corpse:SetCycle(1)
    corpse:SetMoveType(self:GetMoveType())
    corpse:SetCollisionGroup(self.DeathCorpseCollisionType)
    local minBounds, maxBounds = self:GetCollisionBounds()
    corpse:SetCollisionBounds(Vector(minBounds.x, maxBounds.y, maxBounds.z), Vector(-minBounds.x, -maxBounds.y, 0))
    corpse:SetSurroundingBounds(Vector(minBounds.x * 100, maxBounds.y * 100, 5 * 100), Vector(-minBounds.x * 100, -maxBounds.y * 100, 0))

    local myPos = corpse:GetPos()
    local myAng = corpse:GetAngles()
    local myForward = corpse:GetForward()
    local myRight = corpse:GetRight()
    local myUp = corpse:GetUp()

    corpse:SetPos(myPos + myUp * -4)

    local brainBody = ents.Create("prop_vj_animatable")
    brainBody:SetModel("models/vj_parr/par1/brain_trup1.mdl")
    brainBody:SetPos(myPos + myForward * 20 + myUp * -4)
    brainBody:SetAngles(myAng)
    brainBody:SetParent(corpse)
    brainBody.PhysgunDisabled = true
    brainBody:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainBody:Spawn()
    brainBody:ResetSequence("die")
    brainBody:SetCycle(1)

    local brainBody2 = ents.Create("prop_vj_animatable")
    brainBody2:SetModel("models/vj_parr/par1/brain_trup2.mdl")
    brainBody2:SetPos(myPos + myRight * -80 + myUp * -4)
    brainBody2:SetAngles(myAng)
    brainBody2:SetParent(corpse)
    brainBody2.PhysgunDisabled = true
    brainBody2:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainBody2:Spawn()
    brainBody2:ResetSequence("die")
    brainBody2:SetCycle(1)

    local brainBody3 = ents.Create("prop_vj_animatable")
    brainBody3:SetModel("models/vj_parr/par1/brain_trup3.mdl")
    brainBody3:SetPos(myPos + myRight * 180 + myUp * -4)
    brainBody3:SetAngles(myAng)
    brainBody3:SetParent(corpse)
    brainBody3.PhysgunDisabled = true
    brainBody3:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainBody3:Spawn()
    brainBody3:ResetSequence("die")
    brainBody3:SetCycle(1)

    local brainBody4 = ents.Create("prop_vj_animatable")
    brainBody4:SetModel("models/vj_parr/par1/brain_trup4.mdl")
    brainBody4:SetPos(myPos + myForward * -170 + myUp * -4)
    brainBody4:SetAngles(myAng)
    brainBody4:SetParent(corpse)
    brainBody4.PhysgunDisabled = true
    brainBody4:SetCollisionGroup(self.DeathCorpseCollisionType)
    brainBody4:Spawn()
    brainBody4:ResetSequence("die")
    brainBody4:SetCycle(1)

    VJ.HLR_ApplyCorpseSystem(self, corpse, nil, {Gibbable = false})
end