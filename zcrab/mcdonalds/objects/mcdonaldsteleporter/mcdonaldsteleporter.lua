require "/scripts/util.lua"
require "/scripts/vec2.lua"

function init()
  self.spawnInterval = config.getParameter("spawnInterval")
  self.spawnPosition = vec2.add(entity.position(), config.getParameter("spawnOffset"))
	
	local t = {}
	for _,npc in ipairs(config.getParameter("npctypes", {})) do
		if npcCheck(npc.type) then
			local s = {}
			
			for _,species in ipairs(npc.species) do
				if npcCheck(npc.type, species) then
					s[#s+1] = species
				end
			end
			
			if #s > 0 then
				npc.species = s
				t[#t+1] = npc
			end
		end
	end
	
	self.types = t
end

function update(dt)
  if not self.spawnTimer then
    self.spawnTimer = util.randomInRange(self.spawnInterval)
  end

  self.spawnTimer = math.max(0, self.spawnTimer - dt)
  if self.spawnTimer == 0 then
    local spawn = util.randomFromList(self.types)
    local species = util.randomFromList(spawn.species)
    local npcId = world.spawnNpc(self.spawnPosition, species, spawn.type, 1)
    world.callScriptedEntity(npcId, "status.addEphemeralEffect", "beamin")
    if spawn.displayNametag then
      world.callScriptedEntity(npcId, "npc.setDisplayNametag", true)
    end

    self.spawnTimer = nil
  end
end

function npcCheck(t, s)
	return pcall(function() root.npcVariant(s or "human", t or "base", 1) end)
end