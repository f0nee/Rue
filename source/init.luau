-- init.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/9/25)

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
    Components = require(script.Parent.components),
    Classes = require(script.Parent.classes),
}

Init.new = function(type)
    if Init[type] then
        return Init[type]
    else
        _G.__internal_debug("Type '" .. tostring(type) .. "' not found in Init")
        return nil
    end
end

return Init