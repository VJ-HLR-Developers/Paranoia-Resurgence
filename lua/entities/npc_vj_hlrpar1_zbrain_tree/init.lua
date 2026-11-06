AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/vj_parr/par1/brain_tree.mdl"
ENT.VJ_ID_Boss = true
ENT.StartHealth = 500
ENT.GodMode = true
ENT.HullType = HULL_HUMAN
ENT.SightAngle = 360
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.ControllerParams = {
    ThirdP_Offset = Vector(50, 25, -250),
    FirstP_Bone = "Bone39",
    FirstP_Offset = Vector(3, 0, 5),
    FirstP_ShrinkBone = false
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = "vj_parr1_blood_red"
ENT.BloodDecal = "VJ_PARR1_Blood_Red"
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}

ENT.HasMeleeAttack = false

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = ACT_DIESIMPLE

ENT.DeathAnimationDecreaseLengthAmount = -1
ENT.DeathCorpseEntityClass = "prop_vj_animatable"

ENT.HasSoundTrack = true

ENT.SoundTbl_Death = {"vj_parr/par1/brain/brain_dead1.wav", "vj_parr/par1/brain/brain_dead2.wav", "vj_parr/par1/brain/brain_dead3.wav", "vj_parr/par1/brain/brain_dead4.wav"}
ENT.SoundTbl_Impact = {"vj_parr/par1/shared/bullet_hit1.wav", "vj_parr/par1/shared/bullet_hit2.wav"}
ENT.SoundTbl_SoundTrack = "vj_parr/par1/brain/track23.mp3"

ENT.MainSoundPitch = 100

ENT.BreathSoundLevel = 80
ENT.AlertSoundLevel = 80
ENT.DeathSoundLevel = 80

-- Custom
ENT.Brain_Signaling = false
ENT.Brain_ZombieCount = 0
ENT.Brain_ZombieLimit = 8
ENT.Brain_NextZombieSpawnT = 0
ENT.Brain_NextSignalT = 0
ENT.Brain_Ent = NULL

local zombieList = {
    "npc_vj_hlrpar1_zombie",
    "npc_vj_hlrpar1_zombie_v1",
    "npc_vj_hlrpar1_zombie",
    "npc_vj_hlrpar1_zombie_v1",
    "npc_vj_hlrpar1_zombie",
    "npc_vj_hlrpar1_zombie_v1",
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
    "npc_vj_hlrpar1_zclone",
    "npc_vj_hlrpar1_zclone",
    "npc_vj_hlrpar1_zclone_v1",
    "npc_vj_hlrpar1_zclone_v1",
    "npc_vj_hlrpar1_zclone_armed",
    "npc_vj_hlrpar1_zdog",
    "npc_vj_hlrpar1_zscientist",
    "npc_vj_hlrpar1_zscientist",
    "npc_vj_hlrpar1_zscientist_fem",
    "npc_vj_hlrpar1_zscientist_fem",
    "npc_vj_hlrpar1_zhazmat",
    "npc_vj_hlrpar1_zhazmat",
    "npc_vj_hlrpar1_zalpha",
    "npc_vj_hlrpar1_zalpha",
    "npc_vj_hlrpar1_zspider",
    "npc_vj_hlrpar1_zspider_v1",
    "npc_vj_hlrpar1_zspider_v2"
}
local zombieList2 = {
    "npc_vj_hlrpar2_zombie",
    "npc_vj_hlrpar2_zclassic",
    "npc_vj_hlrpar2_zombie_v1",
    "npc_vj_hlrpar2_zombie",
    "npc_vj_hlrpar2_zclassic",
    "npc_vj_hlrpar2_zombie_v1",
    "npc_vj_hlrpar2_zombie",
    "npc_vj_hlrpar2_zclassic",
    "npc_vj_hlrpar2_zombie_v1",
    "npc_vj_hlrpar2_zombie",
    "npc_vj_hlrpar2_zclassic",
    "npc_vj_hlrpar2_zombie_v1",
    "npc_vj_hlrpar2_zombie",
    "npc_vj_hlrpar2_zclassic",
    "npc_vj_hlrpar2_zombie_v1",
    "npc_vj_hlrpar2_zombie",
    "npc_vj_hlrpar2_zclassic",
    "npc_vj_hlrpar2_zombie_v1",
    "npc_vj_hlrpar2_zclone",
    "npc_vj_hlrpar2_zdog",
    "npc_vj_hlrpar2_zgeneral",
    "npc_vj_hlrpar2_zarmed_elite",
    "npc_vj_hlrpar2_zarmed_officer",
    "npc_vj_hlrpar2_zarmed",
    "npc_vj_hlrpar2_zarmed_v1",
    "npc_vj_hlrpar2_zrotten",
    "npc_vj_hlrpar2_zrotten",
    "npc_vj_hlrpar2_zrhb",
    "npc_vj_hlrpar2_zscientist",
    "npc_vj_hlrpar2_zscientist",
    "npc_vj_hlrpar2_zscientist_fem",
    "npc_vj_hlrpar2_zscientist_fem_v1",
    "npc_vj_hlrpar2_zhazmat",
    "npc_vj_hlrpar2_zhazmat",
    "npc_vj_hlrpar2_zspider",
    "npc_vj_hlrpar2_zspider",
    "npc_vj_hlrpar2_zspider",
    "npc_vj_hlrpar2_zstriker"
}
local CurTime = CurTime
local math_random = math.random
local math_rand = math.Rand
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
    self.Zombies = {}

    self.SoundTbl_Breath = "vj_parr/par1/brain/deadsignal_goaway.wav"
    self.SoundTbl_SpawnZombies = {"vj_parr/par1/brain/deadsignal1.wav", "vj_parr/par1/brain/deadsignal2.wav", "vj_parr/par1/brain/deadsignal3.wav", "vj_parr/par1/brain/deadsignal4.wav", "vj_parr/par1/brain/deadsignal5.wav", "vj_parr/par1/brain/deadsignal6.wav"}

    local curTime = CurTime()
    self.Brain_NextSignalT = curTime + math_rand(5, 10)
    self:SetName("Zombie Brain Tree")
    self:AddFlags(FL_NOTARGET)
    self:SetCollisionBounds(Vector(50, 50, 320), Vector(-50, -50, 0))
    self:SetSurroundingBounds(Vector(250, 250, 500), Vector(-250, -250, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply, controlEnt)
    ply:ChatPrint("RELOAD: Buff Zombies/Control Clones")
    ply:ChatPrint("JUMP: Spawn Zombies")
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = Color(130, 19, 10)
local beamEffectTbl = {material = "vj_hl/sprites/shockwave", framerate = 20, flags = 0}
local ignoreNPCs = {["npc_vj_hlrpar1_zbrain"] = true, ["npc_vj_hlrpar1_zbrain_body"] = true, ["npc_vj_hlrpar1_zbrain_tree"] = true}
--
function ENT:OnThinkActive()
    if self.Dead then return end
    local curTime = CurTime()
    local eneData = self.EnemyData
    local ene = eneData.Target
    local controlled = self.VJ_Controlled
    local ply = self.VJ_Controlled && self.VJ_Controller:GetPlayer()
    -- Spawn zombies during combat
    if IsValid(ene) && !self.Dead && curTime > self.Brain_NextZombieSpawnT && ((!controlled) or (controlled && ply:KeyDown(IN_JUMP))) then
        for i = 1, 4 do
            if self.Brain_ZombieCount < self.Brain_ZombieLimit then
                local zombie = ents.Create((GetConVar("VJ_PARR_Brain_Par2"):GetInt() == 1 && math_random(2) == 1 && VJ.PICK(zombieList2)) or VJ.PICK(zombieList))
                local opSide = ((i % 2 == 0) && -150) or 150
                zombie:SetPos(self:GetPos() + self:GetForward() * (i <= 2 && -150 or (i <= 4 && 150 or 0)) + self:GetRight() * opSide + self:GetUp() * 10)
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
                local owner = self:GetOwner()
                if IsValid(owner) then
                    if owner.Brain_BodyCount <= 0 then
                        self.Brain_NextZombieSpawnT = curTime + math_rand(3, 6)
                    elseif owner.Brain_BodyCount <= 1 then
                        self.Brain_NextZombieSpawnT = curTime + math_rand(4, 8)
                    elseif owner.Brain_BodyCount <= 2 then
                        self.Brain_NextZombieSpawnT = curTime + math_rand(6, 12)
                    elseif owner.Brain_BodyCount <= 3 then
                        self.Brain_NextZombieSpawnT = curTime + math_rand(8, 16)
                    elseif owner.Brain_BodyCount <= 4 then
                        self.Brain_NextZombieSpawnT = curTime + math_rand(10, 20)
                    end
                end
            end
        end
    end
    -- Buff nearby zombies & control clones within valid distance
    if curTime > self.Brain_NextSignalT && ((!controlled && math_random(1, 10) == 1) or (controlled && ply:KeyDown(IN_RELOAD))) then
        for _, v in pairs(ents.FindByClass("npc_vj_*")) do
            if IsValid(v) /*&& v:Visible(self)*/ && VJ.GetNearestDistance(self, v) <= 2000 && !v.Dead && !ignoreNPCs[v:GetClass()] && !v.IsVJBaseBullseye then
                if (v.VJ_PARR_Zombie && !v.Zombie_Buffed) or (v.VJ_PARR_Clone && !v.Clone_Controlled) then
                    self.Brain_Signaling = true
                    if v.VJ_PARR_Zombie && !v.Zombie_Buffed then
                        v.Zombie_Buffed = true
                        if v:GetState() == VJ_STATE_NONE then v:PlayAnim(ACT_SMALL_FLINCH, true, false, false) end
                        v:SetPlaybackRate(1.5)
                        v:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
                        timer.Simple(VJ.AnimDuration(v, ACT_SMALL_FLINCH), function() if IsValid(v) then v:SetState() end end)
                    end
                    if v.VJ_PARR_Clone && !v.Clone_Controlled then
                        v.Clone_Controlled = true
                        v.VJ_NPC_Class = {"CLASS_ZOMBIE"}
                        v.AlliedWithPlayerAllies = false
                        if v:GetState() == VJ_STATE_NONE then v:PlayAnim((v.VJ_PARR2_NPC && ACT_SMALL_FLINCH) or ACT_STUNNED, true, false, false) end
                        v:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
                        timer.Simple(VJ.AnimDuration(v, ACT_STUNNED), function() if IsValid(v) then v:SetState() end end)
                    end
                end
            end
        end
        if self.Brain_Signaling then
            local myPos = self:GetPos()
            self.Brain_Signaling = false
            for _, v in ipairs(player.GetAll()) do
                VJ.CreateSound(v, self.SoundTbl_SpawnZombies, 100, 100)
            end
            effects.BeamRingPoint(myPos, 0.3, 2, 1200, 48, 0, colorRed, beamEffectTbl)
            effects.BeamRingPoint(myPos, 0.3, 2, 1600, 64, 0, colorRed, beamEffectTbl)
            self.Brain_NextSignalT = curTime + math_rand(5, 20)
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Brain_ZombieDeath()
    self.Brain_ZombieCount = self.Brain_ZombieCount - 1
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
function ENT:OnDamaged(dmginfo, hitgroup, status)
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
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
    local brainEnt = self.Brain_Ent
    if status == "Init" && IsValid(brainEnt) then
        -- Reset stats for zombies & clones when killed
        for _, v in pairs(ents.FindByClass("npc_vj_*")) do
            if IsValid(v) then
                if v.Zombie_Buffed then
                    v.Zombie_Buffed = false
                    if v:GetState() == VJ_STATE_NONE then v:PlayAnim(ACT_SMALL_FLINCH, true, false, false) end
                    v:SetPlaybackRate(self.AnimPlaybackRate)
                    v:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
                    timer.Simple(VJ.AnimDuration(v, ACT_SMALL_FLINCH), function() if IsValid(v) then v:SetState() end end)
                end
                if v.Clone_Controlled then
                    v.Clone_Controlled = false
                    v.VJ_NPC_Class = (GetConVar("VJ_PARR_Friendly_Clones"):GetInt() == 1 && {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN_FRIENDLY"}) or {"CLASS_CLONE"}
                    v.AlliedWithPlayerAllies = (GetConVar("VJ_PARR_Friendly_Clones"):GetInt() == 1 && true) or false
                    v:PlayAnim((self.VJ_PARR2_NPC && ACT_SMALL_FLINCH) or ACT_STUNNED, true, false, false)
                    v:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
                    timer.Simple(VJ.AnimDuration(v, ACT_STUNNED), function() if IsValid(v) then v:SetState() end end)
                end
            end
        end
        self:SetParent(NULL)
        self:SetPos(self:GetPos() + self:GetUp() * -4)
        timer.Simple(0, function() if IsValid(self) then self:SetParent(brainEnt) end end)
    elseif status == "Finish" && IsValid(brainEnt) then
        brainEnt.GodMode = false
        brainEnt:TakeDamage(brainEnt:Health(), brainEnt, brainEnt)
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

    if IsValid(self.Brain_Ent) then
        corpse.Brain_Ent = self.Brain_Ent
        corpse:SetParent(corpse.Brain_Ent)
        corpse:SetPos(self:GetPos())
    end

    VJ.HLR_ApplyCorpseSystem(self, corpse, nil, {Gibbable = false})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
    -- Reset stats for zombies & clones when killed
    for _, v in pairs(ents.FindByClass("npc_vj_*")) do
        if IsValid(v) then
            if v.Zombie_Buffed then
                v.Zombie_Buffed = false
                if v:GetState() == VJ_STATE_NONE then v:PlayAnim(ACT_SMALL_FLINCH, true, false, false) end
                v:SetPlaybackRate(self.AnimPlaybackRate)
                v:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
                timer.Simple(VJ.AnimDuration(v, ACT_SMALL_FLINCH), function() if IsValid(v) then v:SetState() end end)
            end
            if v.Clone_Controlled then
                v.Clone_Controlled = false
                v.VJ_NPC_Class = (GetConVar("VJ_PARR_Friendly_Clones"):GetInt() == 1 && {"CLASS_PLAYER_ALLY", "CLASS_RUSSIAN_FRIENDLY"}) or {"CLASS_CLONE"}
                v.AlliedWithPlayerAllies = (GetConVar("VJ_PARR_Friendly_Clones"):GetInt() == 1 && true) or false
                v:PlayAnim((self.VJ_PARR2_NPC && ACT_SMALL_FLINCH) or ACT_STUNNED, true, false, false)
                v:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
                timer.Simple(VJ.AnimDuration(v, ACT_STUNNED), function() if IsValid(v) then v:SetState() end end)
            end
        end
    end
    -- Remove zombies but not when killed
    if !self.Dead then
        for _, v in pairs(self.Zombies) do
            if IsValid(v) then v:Remove() end
        end
    end
end