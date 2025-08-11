-- components.luau
-- created by @autogostupid
-- last edited by @autogostupid (8/9/25)

local Style = require(script.Parent.Style)

local Components = {
	Templates = {
		Button = {
			Properties = {
				BackgroundColor3 = "grey-800",
				TextColor3 = "rose-50", -- white text
				Font = "source-sans",
				TextSize = 14,
				Text = "Hello, World!"
			}
		},

		Frame = {

		}
	}
}

local CreatedUIs = {}

local function GetTemplate(Template)
	return Components.Templates[Template]
end

Components.new = function(type, parent)
	local Object = nil

	if type:lower() == "styler" then
		Object = Style
	elseif type:lower() == "button" then
		local Template = GetTemplate("Button")
		local Button = Instance.new("TextButton")

		Style.ApplyStyle(Button, Template.Properties)

		Object = Button
	elseif type:lower() == "gui" or type:lower() == "screengui" then
		local Gui = Instance.new("ScreenGui")

		table.insert(CreatedUIs, Gui)

		Object = Gui
	else
		_G.__internal_debug("Component type " .. tostring(type) .. " not found")
	end

	if Object then
		if parent then
			Object.Parent = parent
		else
			_G.__internal_debug("Parent not specified")
		end

		return Object
	else
		_G.__internal_debug("Failed to create component of type " .. tostring(type))
		return nil
	end
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
		elseif event:lower() == "hover" then
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