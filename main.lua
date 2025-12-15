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
MainFrame.Size = isMobile and UDim2.new(0,360,0,260) or UDim2.new(0,320,0,220)
MainFrame.Position = UDim2.new(0.5,-MainFrame.Size.X.Offset/2,0.5,-MainFrame.Size.Y.Offset/2)
MainFrame.BackgroundTransparency = 1
MainFrame.Active = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,14)
MainFrame.Visible = true

local UIScale = Instance.new("UIScale", MainFrame)
UIScale.Scale = 0

-- BACKGROUND IMAGE
local BG = Instance.new("ImageLabel", MainFrame)
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://85542695667199"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,14)

-- OVERLAY
local Overlay = Instance.new("Frame", BG)
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
	while true do
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=6,Transparency=0.1}):Play()
		task.wait(1)
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=3,Transparency=0.4}):Play()
		task.wait(1)
	end
end)

-- NOTIFY
local Notify = Instance.new("TextLabel", ScreenGui)
Notify.Size = UDim2.new(0,480,0,44)
Notify.Position = UDim2.new(0.5,-240,0.9,30)
Notify.Font = Enum.Font.GothamBold
Notify.TextSize = 18
Notify.TextColor3 = Color3.new(1,1,1)
Notify.BackgroundColor3 = Color3.fromRGB(120,60,180)
Notify.Visible = false
Notify.ZIndex = 50
Instance.new("UICorner", Notify).CornerRadius = UDim.new(0,14)

local function notify(text)
	Notify.Text = text
	Notify.Visible = true
	Notify.TextTransparency = 1
	Notify.BackgroundTransparency = 1
	TweenService:Create(Notify,TweenInfo.new(0.35,Enum.EasingStyle.Back),{
		TextTransparency=0,
		BackgroundTransparency=0,
		Position=UDim2.new(0.5,-240,0.9,0)
	}):Play()
	task.delay(2.5,function()
		TweenService:Create(Notify,TweenInfo.new(0.35),{
			TextTransparency=1,
			BackgroundTransparency=1,
			Position=UDim2.new(0.5,-240,0.9,30)
		}):Play()
		task.wait(0.35)
		Notify.Visible=false
	end)
end

-- SIGNATURE
local Tag = Instance.new("TextButton", MainFrame)
Tag.Text = "mr_yete"
Tag.Font = Enum.Font.LuckiestGuy
Tag.TextSize = 32
Tag.TextColor3 = Color3.fromRGB(180,70,255)
Tag.BackgroundTransparency = 1
Tag.Position = UDim2.new(0.5,-130,1,-48)
Tag.Size = UDim2.new(0,260,0,40)
Tag.MouseButton1Click:Connect(function()
	ClickSound:Play()
	pcall(function() setclipboard("https://www.tiktok.com/@mr_yete") end)
	notify("Haz copiado el TikTok del desarrollador")
end)

-- FLOAT ICON
local Circle = Instance.new("ImageButton", ScreenGui)
Circle.Image = "rbxassetid://85542695667199"
Circle.Size = UDim2.new(0,56,0,56)
Circle.Position = UDim2.new(0,20,0.5,0)
Circle.Visible = false
Circle.BackgroundTransparency = 1
Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)
local CircleGlow = Instance.new("UIStroke", Circle)
CircleGlow.Color = Color3.fromRGB(180,120,255)
CircleGlow.Thickness = 3

-- DRAG
local function drag(o)
	local dragging, startPos, startInput
	o.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then
			dragging=true
			startPos=o.Position
			startInput=i.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			local delta=i.Position-startInput
			o.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			dragging=false
		end
	end)
end

drag(MainFrame)
drag(Circle)

-- MINIMIZE
local Minimize = Instance.new("ImageButton", MainFrame)
Minimize.Image = "rbxassetid://6031091002"
Minimize.Size = UDim2.new(0,34,0,34)
Minimize.Position = UDim2.new(1,-70,0,8)
Minimize.BackgroundTransparency = 0.2
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(1,0)

Minimize.MouseButton1Click:Connect(function()
	MainFrame.Visible=false
	Circle.Visible=true
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=0}):Play()
end)

Circle.MouseButton1Click:Connect(function()
	MainFrame.Visible=true
	Circle.Visible=false
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=12}):Play()
end)

-- CLOSE
local Close = Instance.new("ImageButton", MainFrame)
Close.Image = "rbxassetid://6031094678"
Close.Size = UDim2.new(0,34,0,34)
Close.Position = UDim2.new(1,-34,0,8)
Close.BackgroundTransparency = 0.15
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)
Close.MouseButton1Click:Connect(function()
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=0}):Play()
	ScreenGui:Destroy()
end)

-- START BUTTON
local Start = Instance.new("TextButton", MainFrame)
Start.Size = UDim2.new(0,180,0,56)
Start.Position = UDim2.new(0.5,-90,0.5,-28)
Start.Text = "START"
Start.Font = Enum.Font.FredokaOne
Start.TextSize = 28
Start.TextColor3 = Color3.new(1,1,1)
Start.BackgroundColor3 = Color3.fromRGB(140,70,200)
Instance.new("UICorner", Start).CornerRadius = UDim.new(0,16)

local StartGlow = Instance.new("UIStroke", Start)
StartGlow.Color = Color3.fromRGB(210,140,255)
StartGlow.Thickness = 4

-- LOGIC
local running = false
local brainrotConnection

local function touch(part,hrp)
	if not running then return end
	firetouchinterest(hrp, part, 0)
	task.wait(0.1)
	firetouchinterest(hrp, part, 1)
end

Start.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if not running then
		running=true
		Start.Text="STOP"
		notify("MR_Yete iniciado correctamente")
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")

		brainrotConnection = workspace.Brainrots.ChildAdded:Connect(function(p)
			if p:IsA("BasePart") then
				touch(p,hrp)
			end
		end)
	else
		running=false
		Start.Text="START"
		notify("MR_Yete detenido")
		if brainrotConnection then brainrotConnection:Disconnect() end
	end
end)

-- OPEN ANIMATION
TweenService:Create(UIScale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
TweenService:Create(Blur,TweenInfo.new(0.5),{Size=12}):Play()

-- PARALLAX
RunService.RenderStepped:Connect(function()
	local mouse = UserInputService:GetMouseLocation()
	local deltaX = (mouse.X - workspace.CurrentCamera.ViewportSize.X/2)/100
	local deltaY = (mouse.Y - workspace.CurrentCamera.ViewportSize.Y/2)/100
	BG.Position = UDim2.new(-0.075 + deltaX/300,0,-0.075 + deltaY/300,0)
end)
