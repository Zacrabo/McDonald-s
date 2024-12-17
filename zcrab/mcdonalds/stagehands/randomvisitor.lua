function update()
  script.setUpdateDelta(0)

  local chance = config.getParameter("spawnChance", 0.5)
  if sb.makeRandomSource():randf() > chance then
    return
  end

  local uniqueId = config.getParameter("teleporterUniqueId")
  local objectId = world.loadUniqueEntity(uniqueId)
  if not objectId or objectId == 0 then
    sb.logWarn("couldnt spawn mcdonalds visitor :(")
    return
  end

  local npcId = world.callScriptedEntity(objectId, "spawnNpc", false)
  if not npcId then
    return
  end

  world.callScriptedEntity(npcId, "mcontroller.setPosition", entity.position())
end
