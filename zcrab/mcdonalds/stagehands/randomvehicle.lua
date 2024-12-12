function init()
	local chance = config.getParameter("vehicleChance", 0.5)
	if math.random() > chance then
		local list = config.getParameter("vehicles", {})
		local name = list[math.random(1, #list)]
		world.spawnVehicle(name, entity.position(), {ownerKey = sb.makeUuid()})
	end
	stagehand.die()
end
