-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- BLUR
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false

-- SOUND
local ClickSound = Instance.new("Sound", ScreenGui)
ClickSound.SoundId = "rbxassetid://12221967"
ClickSound.Volume = 0.8

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = isMobile and UDim2.new(0,280,0,210) or UDim2.new(0,320,0,220)
MainFrame.Position = UDim2.new(0.5,-MainFrame.Size.X.Offset/2,0.5,-MainFrame.Size.Y.Offset/2)
MainFrame.BackgroundTransparency = 1
MainFrame.Active = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,14)
MainFrame.Visible = true

local UIScale = Instance.new("UIScale", MainFrame)
UIScale.Scale = isMobile and 1 or 0

-- BACKGROUND IMAGE
local BG = Instance.new("ImageLabel")
BG.Parent = MainFrame
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://85542695667199"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,14)

-- OVERLAY
local Overlay = Instance.new("Frame")
Overlay.Parent = BG
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.35
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,14)

-- GLOW
local Glow = Instance.new("UIStroke", BG)
Glow.Color = Color3.fromRGB(180,80,255)
Glow.Thickness = 3
Glow.Transparency = 0.3

task.spawn(function()
	while ScreenGui.Parent do
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=6,Transparency=0.1}):Play()
		task.wait(1)
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=3,Transparency=0.4}):Play()
		task.wait(1)
	end
end)

-- SHOW ON START
TweenService:Create(Blur,TweenInfo.new(0.5),{Size=12}):Play()
if not isMobile then
	TweenService:Create(UIScale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
end

-- FLOAT ICON
local Circle = Instance.new("ImageButton")
Circle.Parent = ScreenGui
Circle.Image = "rbxassetid://85542695667199"
Circle.Size = UDim2.new(0,56,0,56)
Circle.Position = UDim2.new(0,20,0.5,0)
Circle.Visible = false
Circle.BackgroundTransparency = 1
Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

-- DRAG (PC + MÓVIL)
local function drag(o)
	local dragging, startPos, startInput
	o.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startPos = o.Position
			startInput = i.Position
		end
	end)
	o.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local delta = i.Position - startInput
			o.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
		end
	end)
	o.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

drag(MainFrame)
drag(Circle)

-- CTRL TOGGLE (SOLO PC)
UserInputService.InputBegan:Connect(function(input,gp)
	if gp or isMobile then return end
	if input.KeyCode == Enum.KeyCode.LeftControl then
		ClickSound:Play()
		MainFrame.Visible = not MainFrame.Visible
		Circle.Visible = not MainFrame.Visible
		TweenService:Create(Blur,TweenInfo.new(0.4),{Size = MainFrame.Visible and 12 or 0}):Play()
	end
end)

-- PARALLAX SOLO EN PC
if not isMobile then
	RunService.RenderStepped:Connect(function()
		local mouse = UserInputService:GetMouseLocation()
		local deltaX = (mouse.X - workspace.CurrentCamera.ViewportSize.X/2)/100
		local deltaY = (mouse.Y - workspace.CurrentCamera.ViewportSize.Y/2)/100
		BG.Position = UDim2.new(-0.075 + deltaX/300,0,-0.075 + deltaY/300,0)
		MainFrame.Rotation = deltaX/10
	end)
end

