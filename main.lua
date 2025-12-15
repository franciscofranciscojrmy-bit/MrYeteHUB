-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- BLUR
local Blur = Instance.new("BlurEffect")
Blur.Parent = Lighting
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
MainFrame.Size = UDim2.new(0,320,0,220)
MainFrame.Position = UDim2.new(0.5,-160,0.5,-110)
MainFrame.BackgroundTransparency = 1
MainFrame.Active = true
MainFrame.ZIndex = 10
MainFrame.Visible = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,14)

local UIScale = Instance.new("UIScale", MainFrame)
UIScale.Scale = 1

-- BACKGROUND
local BG = Instance.new("ImageLabel", MainFrame)
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://85542695667199"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,14)

local Overlay = Instance.new("Frame", BG)
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.35
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,14)

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
Notify.Size = UDim2.new(0,420,0,44)
Notify.Position = UDim2.new(0.5,-210,0.9,30)
Notify.Font = Enum.Font.GothamBold
Notify.TextSize = 18
Notify.TextColor3 = Color3.new(1,1,1)
Notify.BackgroundColor3 = Color3.fromRGB(120,60,180)
Notify.Visible = false
Notify.ZIndex = 50
Instance.new("UICorner", Notify).CornerRadius = UDim.new(0,14)

local function notify(txt)
	Notify.Text = txt
	Notify.Visible = true
	Notify.TextTransparency = 1
	Notify.BackgroundTransparency = 1
	TweenService:Create(Notify,TweenInfo.new(0.35,Enum.EasingStyle.Back),{
		TextTransparency=0,
		BackgroundTransparency=0,
		Position=UDim2.new(0.5,-210,0.9,0)
	}):Play()
	task.delay(2.2,function()
		TweenService:Create(Notify,TweenInfo.new(0.3),{
			TextTransparency=1,
			BackgroundTransparency=1,
			Position=UDim2.new(0.5,-210,0.9,30)
		}):Play()
		task.wait(0.3)
		Notify.Visible=false
	end)
end

-- FLOAT ICON (MÓVIL)
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

-- DRAG (PC + MÓVIL)
local function drag(obj)
	local dragging, startPos, startInput
	obj.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startPos = obj.Position
			startInput = i.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
		or i.UserInputType == Enum.UserInputType.Touch) then
			local delta = i.Position - startInput
			obj.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
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
Minimize.BackgroundColor3 = Color3.fromRGB(120,0,255)
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(1,0)

Minimize.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	Circle.Visible = true
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=0}):Play()
end)

Circle.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	Circle.Visible = false
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=12}):Play()
end)

-- START BUTTON
local Start = Instance.new("TextButton", MainFrame)
Start.Size = UDim2.new(0,180,0,60)
Start.Position = UDim2.new(0.5,-90,0.5,-30)
Start.Text = "START"
Start.Font = Enum.Font.FredokaOne
Start.TextSize = 30
Start.TextColor3 = Color3.new(1,1,1)
Start.BackgroundColor3 = Color3.fromRGB(140,70,200)
Instance.new("UICorner", Start).CornerRadius = UDim.new(0,18)

local StartGlow = Instance.new("UIStroke", Start)
StartGlow.Color = Color3.fromRGB(210,140,255)
StartGlow.Thickness = 4
StartGlow.Transparency = 0.15

-- SCRIPT LOGIC (ARREGLADO)
local running = false
local loopTask = nil
local brainrotConnection = nil

local function safeTouch(part, hrp)
	if not running then return end
	if not part:IsA("BasePart") then return end
	pcall(function()
		firetouchinterest(hrp, part, 0)
		task.wait(0.05)
		firetouchinterest(hrp, part, 1)
	end)
end

local function startScript()
	running = true
	Start.Text = "STOP"
	notify("Script iniciado correctamente")

	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	loopTask = task.spawn(function()
		while running do
			local folder = workspace:FindFirstChild("Brainrots")
			if folder then
				for _,p in ipairs(folder:GetChildren()) do
					if not running then break end
					safeTouch(p, hrp)
				end
			end
			task.wait(0.25)
		end
	end)

	local folder = workspace:FindFirstChild("Brainrots")
	if folder then
		brainrotConnection = folder.ChildAdded:Connect(function(p)
			task.wait(0.1)
			safeTouch(p, hrp)
		end)
	end
end

local function stopScript()
	running = false
	Start.Text = "START"
	notify("Script detenido")

	if loopTask then
		task.cancel(loopTask)
		loopTask = nil
	end
	if brainrotConnection then
		brainrotConnection:Disconnect()
		brainrotConnection = nil
	end
end

Start.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if running then
		stopScript()
	else
		startScript()
	end
end)

-- INICIO AUTOMÁTICO GUI
TweenService:Create(Blur,TweenInfo.new(0.4),{Size=12}):Play()
notify("GUI cargada correctamente")
