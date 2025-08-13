-- Rue Loading Screen Example

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local shared = replicatedStorage:WaitForChild("Shared")
local rue = require(shared:WaitForChild("Rue"))
local components = rue.new("components")
local styler = rue.new("styler")

-- Create the main loading GUI
local gui = components.new("gui", localPlayer.PlayerGui)
gui.instance.Name = "RueLoadingGui"
gui.instance.ResetOnSpawn = false

-- Create a background frame
local bgFrame = gui.new("frame")
styler.applyStyle(bgFrame.instance, {
    BackgroundColor = "gray-900",
    AnchorPoint = "center",
    Position = "center",
    Size = {"anchored", 0.5, 0.4},
    BorderRadius = 24,
    Stroke = {"rose-500", 3}
})

-- Create a loading icon (image)
local loadingIcon = bgFrame.new("image")
styler.applyStyle(loadingIcon.instance, {
    BackgroundColor = "transparent",
    AnchorPoint = "center",
    Position = {"anchored", 0.5, 0.3},
    Size = {"anchored", 0.15, 0.35},
    BorderRadius = 12,
    Image = "rbxassetid://8932511161", -- Roblox loading icon
    ImageColor = "gray-50",
    Rotation = 0
})

-- Create a loading text label
local loadingText = bgFrame.new("button") -- Use button for easy styling, disable interaction
styler.applyStyle(loadingText.instance, {
    BackgroundColor = "transparent",
    Font = "source-sans",
    TextSize = 32,
    TextColor = "rose-50",
    RichText = true,
    Position = {"anchored", 0.5, 0.65},
    AnchorPoint = "center",
    Text = "<b>Loading Rue...</b>"
})
loadingText.instance.AutoButtonColor = false
loadingText.instance.Active = false

-- Optional: Add a subtext
local subText = bgFrame.new("button")
styler.applyStyle(subText.instance, {
    BackgroundColor = "transparent",
    Font = "source-sans",
    TextSize = 20,
    TextColor = "gray-300",
    RichText = true,
    Position = {"anchored", 0.5, 0.8},
    AnchorPoint = "center",
    Text = "Please wait while we prepare your experience."
})
subText.instance.AutoButtonColor = false
subText.instance.Active = false

-- Animate the loading icon (simple rotation)
local runService = game:GetService("RunService")
local rotation = 0
local connection
connection = runService.RenderStepped:Connect(function(dt)
    rotation = (rotation + 180 * dt) % 360
    loadingIcon.instance.Rotation = rotation
end)

-- Example: Hide loading screen after 3 seconds
--[[task.delay(3, function()
    if connection then connection:Disconnect() end
    gui.instance:Destroy() -- Remove the loading GUI
end)]]