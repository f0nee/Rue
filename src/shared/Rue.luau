-- Rue.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/11/25)

--[[

    Rue - Initialization Module
    This module initializes the Rue framework and sets up global functions.
    It is responsible for loading necessary components and styles.

]]--

_G.__internal_debug = function(message) 
	if _G.debug then
		warn("[Rue]: " .. message .. " (At Time: " .. os.time() .. ")")
	end
end

local Init = {
	components = require(script.Parent.Components),
	classes = require(script.Parent.Classes),
}

Init.new = function(type)
	if Init[type:lower()] then
		return Init[type:lower()]
	else
		_G.__internal_debug("Type '" .. tostring(type:lower()) .. "' not found in Init")
		return nil
	end
end

return Init