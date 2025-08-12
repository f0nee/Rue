-- created by @autogostupid
-- last edited by @autogostupid (8/12/25)

--[[

    Style - Rue Component Module
    Accessible via Components.new("Styler")
    Provides styling functionality for UI components in Rue.
    This module allows you to apply styles to UI elements such as TextButtons, Frames, etc

]] --

local RueBase = script.Parent.Parent
local Classes = require(script.Parent.Classes)

local function __internal_SetColor(instance, type, color)
	if color == "transparent" and (type == "Frame" or type == "Text") then
		instance.BackgroundTransparency = 1
	elseif Classes.Colors[color] and type == "Frame" then
		instance.BackgroundColor3 = Classes.Colors[color]
	elseif Classes.Colors[color] and type == "Text" then
		instance.TextColor3 = Classes.Colors[color]
	elseif Classes.Colors[color] and type == "Image" then
		instance.ImageColor3 = Classes.Colors[color]
	else
		if (type ~= "Frame") and (type ~= "Text") then
			_G.__internal_debug("Invalid type for color setting: " .. tostring(type))
		else
			_G.__internal_debug("Color " .. tostring(color) .. " not found in Classes.Colors")
		end
	end
end

local Style = {
	__RUE_INFO = {
		Creator = "Rue",
		Project = "Rue Project",
		Name = "Styler",
		Version = 1.0,
		Link = "https://github.com/f0nee/Rue/main/src/shared/mods/official/rue-project@styler/",
		Description = [[
			No need for a bunch of .instance in your code, use Styler!
			Styler is indeed limited right now so for now if we dont support anything you want then use object.instance
		]]
	},

	__RUE = true -- is Official/Base RUE Module? Load immediately or put on backburner (Rue.luau communicates)
}

Style.applyStyle = function(instance, property)
	if instance and property then
		if property.BackgroundColor then
			__internal_SetColor(instance, "Frame", property.BackgroundColor)
		end

		if property.Font and Classes.Fonts[property.Font] then
			instance.Font = Classes.Fonts[property.Font]
		elseif property.Font and not Classes.Fonts[property.Font] then
			_G.__internal_debug("Invalid font '" .. property.Font .. "' not found in Classes.luau")
		end

		if property.TextSize then
			if typeof(property.TextSize) ~= "number" then
				if property.TextSize == "scaled" then 
					instance.TextScaled = true
				end
			else
				instance.TextSize = property.TextSize
			end
		end

		if property.TextColor and Classes.Colors[property.TextColor] then
			__internal_SetColor(instance, "Text", property.TextColor)
		elseif property.TextColor and not Classes.Colors[property.TextColor] then
			_G.__internal_debug("Invalid color '" .. property.TextColor .. "' not found in Classes.luau")
		end

		if property.RichText ~= nil then
			instance.RichText = property.RichText
		end

		if property.Text then
			instance.Text = property.Text
		end

		if property.Position then
			if typeof(property.Position) == "table" then
				if property.Position[1] == "anchored" then
					instance.Position = UDim2.new(property.Position[2], 0, property.Position[3], 0)
				elseif property.Position[1] == "normal" then
					instance.Position = UDim2.new(property.Position[2], property.Position[3], property.Position[4], property.Position[5])
				else
					_G.__internal_debug("Invalid mode '" .. property.Position[1] .. "' in position table")
				end
			elseif Classes.Position[property.Position] then
				instance.Position = Classes.Position[property.Position]
			else
				_G.__internal_debug("Invalid position class '" .. property.Position .. "' not found in Classes.luau")
			end
		end

		if property.AnchorPoint and Classes.AnchorPoint[property.AnchorPoint] then
			instance.AnchorPoint = Classes.AnchorPoint[property.AnchorPoint]
		elseif property.AnchorPoint and not Classes.AnchorPoint[property.AnchorPoint] then
			_G.__internal_debug("Invalid anchor point '" .. property.AnchorPoint .. "' not found in Classes.luau")
		end

		if property.Size then
			if typeof(property.Size) == "table" then
				if property.Size[1] == "anchored" then
					instance.Size = UDim2.new(property.Size[2], 0, property.Size[3], 0)
				elseif property.Size[1] == "normal" then
					instance.Size = UDim2.new(property.Size[2], property.Size[3], property.Size[4], property.Size[5])
				else
					_G.__internal_debug("Invalid mode '" .. property.Size[1] .. "' in size table")
				end
			elseif Classes.Size[property.Size] then
				instance.Size = Classes.Size[property.Size]
			else
				_G.__internal_debug("Invalid size class '" .. property.Size .. "' not found in Classes.luau")
			end
		end

		if property.BorderRadius then
			local UICorner = Instance.new("UICorner")
			
			UICorner.CornerRadius = UDim.new(0, property.BorderRadius)
			UICorner.Parent = instance
		end

		if property.Stroke then
			local UIStroke = Instance.new("UIStroke")

			UIStroke.Thickness = property.Stroke[2]
			UIStroke.Color = Classes.Colors[property.Stroke[1]]

			UIStroke.Parent = instance
		end

		if property.ImageColor and Classes.Colors[property.ImageColor] then
			__internal_SetColor(instance, "Image", property.ImageColor)
		elseif property.ImageColor and not Classes.Colors[property.ImageColor] then
			_G.__internal_debug("Invalid image color '" .. property.ImageColor .. "' not found in Classes.luau")
		end

		if property.Image then
			instance.Image = property.Image
		end

		if property.Rotation then
			instance.Rotation = property.Rotation
		end
	else
		_G.__internal_debug("Instance or property is nil")
	end
end

return Style