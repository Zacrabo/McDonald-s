function update()
	script.setUpdateDelta(0)

	local randomSource = sb.makeRandomSource()
	local chance = config.getParameter("spawnChance", 0.5)
	if randomSource:randf() > chance then
		return
	end

	local list = config.getParameter("vehicles", {})
	local name = list[randomSource:randInt(1, #list)]
	local vehicleId = world.spawnVehicle(name, entity.position())

	local state = world.callScriptedEntity(vehicleId, "animator.animationState", "movement")
	if state == "warpInPart1" then
		world.callScriptedEntity(vehicleId, "animator.setAnimationState", "movement", "idle")
	end
end
