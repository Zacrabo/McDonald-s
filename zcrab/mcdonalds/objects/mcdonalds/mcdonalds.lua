interactFunctions = {}

function init()
	interactAction = config.getParameter("interactAction", "OpenMerchantInterface")
end

function onInteraction(args)
	local data = config.getParameter("interactData", {})
	
	for _,f in pairs(interactFunctions) do
		f(args, data)
	end
	
	return { interactAction, data }
end