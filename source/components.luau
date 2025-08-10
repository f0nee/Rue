-- components.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/9/25)

local Style = require(script.Parent.Style)

local Components = {
    Templates = {
        Button = {
            Properties = {
                BackgroundColor3 = "red-100"
            }
        }
    }
}

local CreatedUIs = {}

local function GetTemplate(Template)
    return Components.Templates[Template]
end

Components.new = function(type)
    if type:lower() == "styler" then
        return Style
    elseif type:lower() == "button" then
        local Template = GetTemplate("Button")
        local Button = Instance.new("TextButton")
        
        Style.ApplyStyle(Button, Template.Properties)

        return Button
    elseif type:lower() == "gui" or type:lower() == "screengui" then
        local Gui = Instance.new("ScreenGui")

        table.insert(CreatedUIs, Gui)

        return Gui
    else
        _G.__internal_debug("Component type " .. tostring(type) .. " not found")
        return nil
    end
end

Components.mount = function(instance, parent)
    if instance and parent then
        if table.find(CreatedUIs, instance) then
            _G.__internal_debug("Instance not created by Rue, cannot mount")
            return nil
        else
            instance.Parent = parent
            return instance
        end
    else
        _G.__internal_debug("Instance or parent is nil")
        return nil
    end
end

return Components