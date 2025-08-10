-- style.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/9/25)

local Classes = require(script.Parent.Classes)

local Style = {}

Style.ApplyStyle = function(instance, styling, property)
    if instance and property then
        if property.color ~= nil then
            if property.color == Classes.Colors[property.color] then
                instance[styling] = Classes.Colors[property.color]
            else
                _G.__internal_debug("Color " .. tostring(property.color) .. " not found in Classes.Colors")
            end 
        else
            _G.__internal_debug("Property 'color' is nil")
        end
    else
        _G.__internal_debug("Instance or property is nil")
    end
end

return Style