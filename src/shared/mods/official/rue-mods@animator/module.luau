-- created by @autogostupid
-- last edited by @autogostupid (8/13/25)

--[[

    Animator - Rue Component Module
    Accessible via Rue.new("Styler")
    Provides Pre-Made Tween Animations for UI components in Rue.
    This module allows you to apply animations to UI elements such as Frames, Buttons, etc.

]] --


local Animator = {
	__RUE_INFO = {
		Creator = "Rue",
		Project = "Rue Project",
		Name = "Styler",
		Version = 1.0,
		Link = "https://github.com/f0nee/Rue/main/src/shared/mods/official/rue-project@styler/",
		Description = [[
			No need for a bunch of .instance in your code, use Styler!
			Styler is indeed limited right now so for now if we dont support anything you want then use object.instance
		]]
	},

	__RUE = true -- is Official/Base RUE Module? Load immediately or put on backburner (Rue.luau communicates)
}

local TweenService = game:GetService("TweenService")

Animator.applyAnimation = function(instance, animationType, properties)
    if instance and animationType and properties then
        local tweenInfo = TweenInfo.new(properties.time or 0.5, properties.easingStyle or Enum.EasingStyle.Linear, properties.easingDirection or Enum.EasingDirection.InOut)
        local tween = TweenService:Create(instance, tweenInfo, properties)

        tween:Play()

        if properties.onComplete then
            tween.Completed:Connect(function()
                properties.onComplete()
            end)
        end
    else
        _G.__internal_debug("Invalid parameters for Animator.applyAnimation")
    end
end

Animator.Preset = {}

Animator.Preset.FadeIn = function(instance, duration, onComplete)
    instance.Visible = true
    instance.BackgroundTransparency = 1
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.5), {BackgroundTransparency = 0})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.FadeOut = function(instance, duration, onComplete)
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.5), {BackgroundTransparency = 1})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(function()
            instance.Visible = false
            onComplete()
        end)
    else
        tween.Completed:Connect(function()
            instance.Visible = false
        end)
    end
end

Animator.Preset.PopIn = function(instance, duration, onComplete)
    local scaleObj = instance:FindFirstChildOfClass("UIScale")
    if not scaleObj then
        scaleObj = Instance.new("UIScale")
        scaleObj.Scale = 0.5
        scaleObj.Parent = instance
    else
        scaleObj.Scale = 0.5
    end
    local tween = TweenService:Create(scaleObj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.PopOut = function(instance, duration, onComplete)
    local scaleObj = instance:FindFirstChildOfClass("UIScale")
    if not scaleObj then
        scaleObj = Instance.new("UIScale")
        scaleObj.Scale = 1
        scaleObj.Parent = instance
    end
    local tween = TweenService:Create(scaleObj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.5})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.SlideInLeft = function(instance, duration, onComplete)
    local originalPos = instance.Position
    instance.Position = UDim2.new(-1, 0, originalPos.Y.Scale, originalPos.Y.Offset)
    instance.Visible = true
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = originalPos})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.SlideOutLeft = function(instance, duration, onComplete)
    local originalPos = instance.Position
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(-1, 0, originalPos.Y.Scale, originalPos.Y.Offset)})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.SlideInRight = function(instance, duration, onComplete)
    local originalPos = instance.Position
    instance.Position = UDim2.new(2, 0, originalPos.Y.Scale, originalPos.Y.Offset)
    instance.Visible = true
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = originalPos})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.SlideOutRight = function(instance, duration, onComplete)
    local originalPos = instance.Position
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(2, 0, originalPos.Y.Scale, originalPos.Y.Offset)})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.SlideInBottom = function(instance, duration, onComplete)
    local originalPos = instance.Position
    instance.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, 2, 0)
    instance.Visible = true
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = originalPos})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.SlideOutBottom = function(instance, duration, onComplete)
    local originalPos = instance.Position
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, 2, 0)})
    tween:Play()
    if onComplete then
        tween.Completed:Connect(onComplete)
    end
end

Animator.Preset.Shake = function(instance, duration, magnitude, onComplete)
    local originalPos = instance.Position
    local shakeTween
    local steps = 10
    local totalTime = duration or 0.5
    local stepTime = totalTime / steps
    local i = 0

    local function doShake()
        if i < steps then
            i = i + 1
            local offset = ((i % 2 == 0) and magnitude or -magnitude)
            instance.Position = originalPos + UDim2.new(0, offset, 0, 0)
            task.wait(stepTime)
            doShake()
        else
            instance.Position = originalPos
            if onComplete then onComplete() end
        end
    end

    doShake()
end

return Animator