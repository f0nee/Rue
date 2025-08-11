-- button with Rue :)
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
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
	TextSize = "scaled",
	TextColor = "rose-50",
	RichText = true,
	Position = "center",
	AnchorPoint = "center",
	Text = "<b>Click Me!</b>",
})

button.instance.Size = UDim2.new(0, 200, 0, 50) -- set size manually for now

-- button effects
local tweenInfos = {
	hover = TweenInfo.new(0.2, Enum.EasingStyle.Sine),
	click = TweenInfo.new(0.1, Enum.EasingStyle.Sine)	
}
local info = {
	hover = UDim2.new(0, 250, 0, 75),
	leave = UDim2.new(0, 200, 0, 50),
	click = UDim2.new(0, 190, 0, 40)
}
local test = false

button.event("hover", function()
	test = true
	tweenService:Create(button.instance, tweenInfos.hover, {Size = info.hover}):Play()
end)
button.event("leave", function()
	test = false
	tweenService:Create(button.instance, tweenInfos.hover, {Size = info.leave}):Play()
end)
button.event("click", function()
	local x = tweenService:Create(button.instance, tweenInfos.click, {Size = info.click})
	x:Play()
	x.Completed:Connect(function()
		if test then
			tweenService:Create(button.instance, tweenInfos.hover, {Size = info.hover}):Play()
		else
			tweenService:Create(button.instance, tweenInfos.hover, {Size = info.leave}):Play()
		end
	end)
end)