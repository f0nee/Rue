-- button with Rue :)
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local shared = replicatedStorage:WaitForChild("Shared")
local rue = require(shared:WaitForChild("Rue"))
local components = rue.new("components")
local styler = components.new("styler")

-- this creates a Gui and stores it so exploiters cant use mount to parent themselves (just a little secure ig?)
local gui = components.new("gui", localPlayer.PlayerGui)

-- you will need to use object.instance
gui.instance.Name = "RueGui"
gui.instance.ResetOnSpawn = false

-- create button and apply styles
local button = gui.new("button")
styler.applyStyle(button.instance, { -- rue's current sizing system is not perfect, so you may need to adjust sizes manually
	BackgroundColor = "rose-500",
	Font = "source-sans",
	TextSize = 18,
	TextColor = "rose-50",
	RichText = true,
	Position = "center",
	AnchorPoint = "center",
	Text = "<b>Click Me!</b>",
})
button.event("click", function() 
	print("this should print to client :eyes:")
end)

button.Size = UDim2.new(0, 200, 0, 50) -- set size manually for now