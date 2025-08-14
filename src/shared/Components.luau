-- Components.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/13/25)

local Style = require(script.Parent.mods.official["rue-project@styler"].module) -- workaround because i cant require Rue (cyclic dependency)

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
                Position = {"anchored", 0.5, 0.5},
                Size = {"anchored", 0.4, 0.3}
            }
        },

        ImageButton = {
            Properties = {
                BackgroundColor = "gray-800",
                Image = "rbxasset://textures/face.png",
                ImageColor = "red-500",
                AnchorPoint = "center",
                Position = {"anchored", 0.5, 0.5},
                Size = {"anchored", 0.4, 0.3}
            }
        },

        Frame = {
            Properties = {
                BackgroundColor = "gray-400",
                AnchorPoint = "center",
                Position = {"anchored", 0.5, 0.5},
                BorderRadius = 16,
                Stroke = {"gray-900", 2},
                Size = {"anchored", 0.4, 0.2}
            }
        },

        Image = {
            Properties = {
                BackgroundColor = "transparent",
                AnchorPoint = "center",
                Position = {"anchored", 0.2, 0.8},
                Size = {"anchored", 0.2, 0.15},
                BorderRadius = 8,
                Image = "rbxasset://textures/face.png",
                ImageColor = "red-500",
                Rotation = 40
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

    if instance:IsA("GuiButton") or Instance:IsA("Frame") or Instance:IsA("ImageLabel") then
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

    if type:lower() == "button" then
        Object = Instance.new("TextButton")
    elseif type:lower() == "gui" then
        Object = Instance.new("ScreenGui")
	elseif type:lower() == "frame" then 
        Object = Instance.new("Frame")
    elseif type:lower() == "image" then 
        Object = Instance.new("ImageLabel")
    elseif type:lower() == "imagebutton" then
        Object = Instance.new("ImageButton")
	elseif type:lower() == "text" then
		Object = Instance.new("TextLabel")
	elseif type:lower() == "textbox" then
		Object = Instance.new("TextBox")
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
            end,

            setAspectRatio = function(ratio, wh: Enum.DominantAxis, at: Enum.AspectType)
                local Ratio = Instance.new("UIAspectRatioConstraint")

                Ratio.AspectRatio = ratio
                Ratio.AspectType = at or Enum.AspectType.FitWithinMaxSize
                Ratio.DominantAxis = wh or Enum.DominantAxis.Width

                Ratio.Parent = Object
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