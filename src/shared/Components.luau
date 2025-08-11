-- Components.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/11/25)
local Style = require(script.Parent.Style)

local Components = {
    Templates = {
        Button = {
            Properties = {
                BackgroundColor = "gray-800",
                TextColor = "rose-50", -- white text
                Font = "source-sans",
                TextSize = 24,
                Text = "Smiley Button :)",
                AnchorPoint = "center",
                Position = "center"
            }
        },

        Frame = {
            Properties = {
                BackgroundColor = "gray-400",
                AnchorPoint = "center",
                Position = "center",
                BorderRadius = 16,
                Stroke = {"gray-900", 2}
            }
        }
    }
}

local CreatedUIs = {}

local function GetTemplate(Template)
    return Components.Templates[Template]
end

Components.event = function(instance, event, func)
    if typeof(func) ~= "function" then
        _G.__internal_debug("Function not supplied")
        return nil
    end

    if instance:IsA("GuiButton") then
        if event:lower() == "click" then
            instance.MouseButton1Click:Connect(function()
                func()
            end)

            return true
        end
    end

    if instance:IsA("GuiButton") or Instance:IsA("Frame") then
        if event:lower() == "hover" then
            instance.MouseEnter:Connect(function()
                func()
            end)

            return true
        elseif event:lower() == "leave" then
            instance.MouseLeave:Connect(function()
                func()
            end)

            return true
        end
    end

    _G.__internal_debug("Wrong argument")

    return nil
end

Components.new = function(type, parent)
    local Object = nil

    if type:lower() == "styler" then
        return Style
    elseif type:lower() == "button" then
        local Template = GetTemplate("Button")
        local Button = Instance.new("TextButton")

        Style.applyStyle(Button, Template.Properties)

        Object = Button
    elseif type:lower() == "gui" or type:lower() == "screengui" then
        local Gui = Instance.new("ScreenGui")

        Object = Gui
	elseif type:lower() == "frame" then 
        local Template = GetTemplate("Frame")
        local Frame = Instance.new("Frame")

        Style.applyStyle(Frame, Template.Properties)

        Object = Frame
    else
        _G.__internal_debug("Component type " .. tostring(type) .. " not found")
    end

    if Object then
        if parent then
            Object.Parent = parent
        else
            _G.__internal_debug("Parent not specified")
        end

        table.insert(CreatedUIs, Object)

        return {
            instance = Object,

            event = function(eventName, func)
                return Components.event(Object, eventName, func)
            end,

            new = function(typeNew)
                return Components.new(typeNew, Object)
            end
        }
    else
        _G.__internal_debug("Failed to create component of type " .. tostring(type))
        return nil
    end
end

Components.mount = function(instance, parent)
    if instance and parent then
        if not table.find(CreatedUIs, instance) then
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
