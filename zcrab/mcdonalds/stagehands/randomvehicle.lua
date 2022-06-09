function init()
	local vehicles = config.getParameter("vehicles", {})
	if math.random() > 0.5 then
		local v = vehicles[math.random(1, #vehicles)]
		world.spawnVehicle(v, entity.position(), {ownerKey = sb.makeUuid()})
	end
	stagehand.die()
end