-- button with Rue :)
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local rueFolder = replicatedStorage:WaitForChild("Rue")
local rue = require(rueFolder:WaitForChild("Init"))
local components = rue.new("components")
local styler = components.new("styler")

-- this creates a Gui and stores it so exploiters cant use mount to parent themselves (just a little secure ig?)
local gui = components.new("gui", localPlayer.PlayerGui)

-- set properties as its a real Gui, as components.new returns an instance or module
gui.Name = "RueGui"
gui.ResetOnSpawn = false

-- create button and apply styles
local button = components.new("button", gui)
styler.applyStyle(button, { -- rue's current sizing system is not perfect, so you may need to adjust sizes manually
	BackgroundColor = "rose-500",
	Font = "source-sans",
	TextSize = 18,
	TextColor = "rose-50",
	RichText = true,
	Position = "center",
	AnchorPoint = "center",
	Text = "<b>Click Me!</b>",
})
components.event(button, "click", function() 
	print("this should print to client :eyes:")
end)

button.Size = UDim2.new(0, 200, 0, 50) -- set size manually for now