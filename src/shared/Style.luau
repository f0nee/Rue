-- Style.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/11/25)

--[[

    Style - Rue Component Module
    Accessible via Components.new("Styler")
    Provides styling functionality for UI components in Rue.
    This module allows you to apply styles to UI elements such as TextButtons, Frames, etc

]] --

local Classes = require(script.Parent.Classes)

local function __internal_SetColor(instance, type, color)
	if color == "transparent" and (type == "Frame" or type == "Text") then
		instance.BackgroundTransparency = 1
	elseif Classes.Colors[color] and type == "Frame" then
		instance.BackgroundColor3 = Classes.Colors[color]
	elseif Classes.Colors[color] and type == "Text" then
		instance.TextColor3 = Classes.Colors[color]
	else
		if (type ~= "Frame") and (type ~= "Text") then
			_G.__internal_debug("Invalid type for color setting: " .. tostring(type))
		else
			_G.__internal_debug("Color " .. tostring(color) .. " not found in Classes.Colors")
		end
	end
end

local Style = {}

Style.applyStyle = function(instance, property)
	if instance and property then
		if property.BackgroundColor then
			__internal_SetColor(instance, "Frame", property.BackgroundColor)
		end

		if property.Font then
			instance.Font = Classes.Fonts[property.Font]
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

		if property.TextColor then
			__internal_SetColor(instance, "Text", property.TextColor)
		end

		if property.RichText ~= nil then
			instance.RichText = property.RichText
		end

		if property.Text then
			instance.Text = property.Text
		end

		if property.Position then
			instance.Position = Classes.Position[property.Position]
		end

		if property.AnchorPoint then
			instance.AnchorPoint = Classes.AnchorPoint[property.AnchorPoint]
		end

		if property.Size then
			instance.Size = Classes.Size[property.Size]
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
	else
		_G.__internal_debug("Instance or property is nil")
	end
end

return Style
