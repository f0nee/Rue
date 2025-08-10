-- style.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/9/25)
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

Style.ApplyStyle = function(instance, property)
    if instance and property then
        if property.BackgroundColor3 then
            __internal_SetColor(instance, "Frame", property.BackgroundColor3)
        else
            _G.__internal_debug("BackgroundColor3 not specified, using default color")
            __internal_SetColor(instance, "Frame", "gray-50")
        end

        if property.Font then
            instance.Font = Classes.Fonts[property.Font]
        else
            _G.__internal_debug("Font not specified, using default font")
            instance.Font = Enum.Font.SourceSans
        end

        if property.TextSize then
            instance.TextSize = property.TextSize
        else
            _G.__internal_debug("TextSize not specified, using default size")
            instance.TextSize = 14
        end

        if property.TextColor3 then
            __internal_SetColor(instance, "Text", "rose-500")
        else
            _G.__internal_debug("TextColor3 not specified, using default color")
            __internal_SetColor(instance, "Text", "rose-500")
        end

        if property.RichText ~= nil then
            instance.RichText = Classes.RichText[property.RichText]
        else
            _G.__internal_debug("RichText not specified, using default value")
            instance.RichText = Classes.RichText["richtext-off"]
        end

        if property.Text then
            instance.Text = property.Text
        else
            _G.__internal_debug("Text not specified, using default text")
            instance.Text = ""
        end

        if property.Position then
            instance.Position = Classes.Position[property.Position]
        else
            _G.__internal_debug("Position '" .. tostring(property.Position) .. "' not found in Classes.Position")
        end

        if property.AnchorPoint then
            instance.AnchorPoint = Classes.AnchorPoint[property.AnchorPoint]
        else
            _G.__internal_debug("AnchorPoint '" .. tostring(property.AnchorPoint) .. "' not found in Classes.AnchorPoint")
        end

        if property.Size then
            instance.Size = Classes.Size[property.Size]
        else
            _G.__internal_debug("Size '" .. tostring(property.Size) .. "' not found in Classes.Size")
        end
    else
        _G.__internal_debug("Instance or property is nil")
    end
end

return Style
