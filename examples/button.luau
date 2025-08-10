-- Button with Rue :)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RueFolder = ReplicatedStorage:WaitForChild("Rue")
local Rue = require(RueFolder)
local Components = Rue.new("Components")
local Styler = Components.new("Styler")

-- This creates a Gui and stores it so exploiters cant use mount to parent themselves (just a little secure ig?)
local Gui = Components.new("Gui", LocalPlayer.PlayerGui)

-- Set properties as its a real Gui, as Components.new returns an instance or module
Gui.Name = "RueGui"
Gui.ResetOnSpawn = false

-- Create button and apply styles
local Button = Components.new("Button", Gui)
Styler.ApplyStyle(Button, { -- Rue's current sizing system is not perfect, so you may need to adjust sizes manually
    BackgroundColor3 = "blue-500",
    Font = "source-sans",
    TextSize = 18,
    TextColor3 = "white",
    RichText = true,
    Position = "center",
    AnchorPoint = "center",
    Text = "<b>Click Me!</b>",
})

Button.Size = UDim2.new(0, 200, 0, 50) -- Set size manually for now