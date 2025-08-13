-- Rue.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/13/25)

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

local function formatName(package)
	local revisedPackage = {}

	for i, v in pairs(package) do
		if typeof(v) == "string" then
			revisedPackage[i] = v:gsub(" ", "-"):lower()
		end
	end

	return revisedPackage.Creator .. "/" .. revisedPackage.Project .. "@" .. revisedPackage.Name .. "-" .. tostring(revisedPackage.Version)
end

local Init = {
	components = require(script.Parent.Components),
	classes = require(script.Parent.Classes),
}

-- Init --

local __RUE_BACKBURNER = {}
local __RUE_FOLDER = script.Parent
local __RUE_PACKAGES = __RUE_FOLDER.mods
local __RUE_PACKAGES_OFFICIAL = __RUE_PACKAGES.official
local __RUE_PACKAGES_THIRD_PARTY = __RUE_PACKAGES["third-party"]

local function __loadModule(mod)
	Init[mod.__RUE_INFO.Name:lower()] = mod
end

for _, v in pairs(__RUE_PACKAGES_OFFICIAL:GetChildren()) do
	if v:FindFirstChild("module") then
		local __RUE_MODULE = require(v.module)

		if (__RUE_MODULE.__RUE_INFO ~= nil) then
			if __RUE_MODULE.__RUE then
				__loadModule(__RUE_MODULE)
			end
		else
			table.insert(__RUE_BACKBURNER, __RUE_MODULE)
		end

		v.Name = formatName(__RUE_MODULE.__RUE_INFO)
	end
end

for _, v in pairs(__RUE_PACKAGES_THIRD_PARTY:GetChildren()) do
	if v:FindFirstChild("module") then
		local __RUE_MODULE = require(v.module)

		table.insert(__RUE_BACKBURNER, __RUE_MODULE)
		v.Name = formatName(__RUE_MODULE.__RUE_INFO)
	end
end

for _, v in pairs(__RUE_BACKBURNER) do
	__loadModule(v)
end

--[[
	ok u may be like "this isnt necessary" but it is
	we should be loading all the modules at the same time
	:)

	also the name thing is just for funsies ig??
]]--

-- Init --

Init.new = function(type)
	if Init[type:lower()] then
		return Init[type:lower()]
	else
		_G.__internal_debug("Type '" .. tostring(type:lower()) .. "' not found in Init")
		return nil
	end
end

return Init