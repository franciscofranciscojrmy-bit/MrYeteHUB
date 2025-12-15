-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

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
MainFrame.Size = UDim2.new(0,320,0,220)
MainFrame.Position = UDim2.new(0.5,-160,0.5,-110)
MainFrame.BackgroundTransparency = 1
MainFrame.Active = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,14)
MainFrame.Visible = false

local UIScale = Instance.new("UIScale", MainFrame)
UIScale.Scale = 0

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

-- GLOW FRAME
local Glow = Instance.new("UIStroke")
Glow.Parent = BG
Glow.Color = Color3.fromRGB(180,80,255)
Glow.Thickness = 3
Glow.Transparency = 0.3

-- Glow parpadeante
task.spawn(function()
	while true do
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=6,Transparency=0.1}):Play()
		task.wait(1)
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=3,Transparency=0.4}):Play()
		task.wait(1)
	end
end)

-- NOTIFICATIONS
local Notify = Instance.new("TextLabel")
Notify.Parent = ScreenGui
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
		TweenService:Create(Notify,TweenInfo.new(0.35,Enum.EasingStyle.Back),{
			TextTransparency=1,
			BackgroundTransparency=1,
			Position=UDim2.new(0.5,-240,0.9,30)
		}):Play()
		task.wait(0.35)
		Notify.Visible=false
	end)
end

-- NOTIFICACIÓN INICIAL
local InitNotify = Instance.new("TextLabel")
InitNotify.Parent = ScreenGui
InitNotify.Size = UDim2.new(0,480,0,60)
InitNotify.Position = UDim2.new(0.5,-240,0.05,0)
InitNotify.Font = Enum.Font.GothamBold
InitNotify.TextSize = 28
InitNotify.TextColor3 = Color3.fromRGB(255,255,0)
InitNotify.BackgroundColor3 = Color3.fromRGB(50,0,100)
InitNotify.Visible = true
InitNotify.Text = "Por favor presiona CTRL para abrir el menú"
InitNotify.ZIndex = 100
Instance.new("UICorner", InitNotify).CornerRadius = UDim.new(0,16)

TweenService:Create(InitNotify,TweenInfo.new(0.7,Enum.EasingStyle.Bounce),{Position=UDim2.new(0.5,-240,0.05,0)}):Play()
task.delay(5,function()
	TweenService:Create(InitNotify,TweenInfo.new(0.5,Enum.EasingStyle.Quad),{TextTransparency=1,BackgroundTransparency=1}):Play()
	task.wait(0.5)
	InitNotify.Visible=false
end)

-- SIGNATURE mr_yete
local Tag = Instance.new("TextButton")
Tag.Parent = MainFrame
Tag.Text = "mr_yete"
Tag.Font = Enum.Font.LuckiestGuy
Tag.TextSize = 32
Tag.TextColor3 = Color3.fromRGB(180,70,255)
Tag.BackgroundTransparency = 1
Tag.Position = UDim2.new(0.5,-130,0.5,32)
Tag.Size = UDim2.new(0,260,0,40)
Tag.MouseButton1Click:Connect(function()
	ClickSound:Play()
	pcall(function() setclipboard("https://www.tiktok.com/@mr_yete") end)
	notify("Haz copiado el link del TikTok del desarrollador")
end)

-- FLOAT ICON
local Circle = Instance.new("ImageButton")
Circle.Parent = ScreenGui
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
		if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
			local delta=i.Position-startInput
			o.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
	end)
end

drag(MainFrame)
drag(Circle)

-- MINIMIZE / CLOSE
local Minimize = Instance.new("ImageButton")
Minimize.Parent = MainFrame
Minimize.Image = "rbxassetid://6031091002"
Minimize.Size = UDim2.new(0,34,0,34)
Minimize.Position = UDim2.new(1,-70,0,8)
Minimize.BackgroundColor3 = Color3.fromRGB(120,0,255)
Minimize.BackgroundTransparency = 0.2
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(1,0)
local MinGlow = Instance.new("UIStroke", Minimize)
MinGlow.Color = Color3.fromRGB(255,140,255)
MinGlow.Thickness = 3

Minimize.MouseButton1Click:Connect(function()
	MainFrame.Visible=false
	Circle.Visible=true
	ClickSound:Play()
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=0}):Play()
end)

Circle.MouseButton1Click:Connect(function()
	MainFrame.Visible=true
	Circle.Visible=false
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=12}):Play()
end)

local Close = Instance.new("ImageButton")
Close.Parent = MainFrame
Close.Image = "rbxassetid://6031094678"
Close.Size = UDim2.new(0,34,0,34)
Close.Position = UDim2.new(1,-34,0,8)
Close.BackgroundColor3 = Color3.fromRGB(255,0,0)
Close.BackgroundTransparency = 0.15
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)
Close.MouseButton1Click:Connect(function()
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=0}):Play()
	ScreenGui:Destroy()
	ClickSound:Play()
end)

-- START BUTTON CON TOGGLE
local Start = Instance.new("TextButton")
Start.Parent = MainFrame
Start.Size = UDim2.new(0,170,0,56)
Start.Position = UDim2.new(0.5,-85,0.5,-28)
Start.Text = "START"
Start.Font = Enum.Font.FredokaOne
Start.TextSize = 28
Start.TextColor3 = Color3.new(1,1,1)
Start.BackgroundColor3 = Color3.fromRGB(140,70,200)
Instance.new("UICorner", Start).CornerRadius = UDim.new(0,16)

-- START GLOW & AURA
local StartGlow = Instance.new("UIStroke", Start)
StartGlow.Color = Color3.fromRGB(210,140,255)
StartGlow.Thickness = 4
StartGlow.Transparency = 0.15

local Aura = Instance.new("ParticleEmitter", Start)
Aura.Texture = "rbxassetid://296874871"
Aura.Rate = 25
Aura.Lifetime = NumberRange.new(1)
Aura.Speed = NumberRange.new(1.2)
Aura.SpreadAngle = Vector2.new(360,360)
Aura.Color = ColorSequence.new(Color3.fromRGB(200,120,255))
Aura.Size = NumberSequence.new{NumberSequenceKeypoint.new(0,0.4),NumberSequenceKeypoint.new(1,0)}

-- START/STOP LOGIC CON CONTROL DE RUNNING
local running = false
local brainrotConnection = nil

local function touch(part,hrp)
	for _,t in ipairs(part:GetChildren()) do
		if t:IsA("TouchTransmitter") then
			if not running then return end
			firetouchinterest(hrp, part, 0)
			task.wait(0.1)
			firetouchinterest(hrp, part, 1)
		end
	end
end

Start.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if not running then
		running = true
		Start.Text = "STOP"
		notify("MR_Yete ha comenzado a funcionar con éxito")

		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")

		-- EXISTENTES
		task.spawn(function()
			for _,p in ipairs(workspace.Brainrots:GetChildren()) do
				if p:IsA("BasePart") and running then
					touch(p,hrp)
				end
			end
		end)

		-- NUEVOS
		brainrotConnection = workspace.Brainrots.ChildAdded:Connect(function(p)
			if p:IsA("BasePart") and running then
				touch(p,hrp)
			end
		end)

	else
		running = false
		Start.Text = "START"
		notify("MR_Yete ha detenido el script")
		if brainrotConnection then
			brainrotConnection:Disconnect()
			brainrotConnection = nil
		end
	end
end)

-- CTRL TOGGLE
UserInputService.InputBegan:Connect(function(input,gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.LeftControl then
		ClickSound:Play()
		MainFrame.Visible = not MainFrame.Visible
		Circle.Visible = not MainFrame.Visible
		if MainFrame.Visible then
			UIScale.Scale = 0
			MainFrame.Rotation = -10
			TweenService:Create(UIScale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
			TweenService:Create(MainFrame,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Rotation=0}):Play()
			TweenService:Create(Blur,TweenInfo.new(0.5),{Size=12}):Play()
		else
			TweenService:Create(Blur,TweenInfo.new(0.5),{Size=0}):Play()
		end
	end
end)

-- PARALLAX DINÁMICO
RunService.RenderStepped:Connect(function()
	local mouse = UserInputService:GetMouseLocation()
	local deltaX = (mouse.X - workspace.CurrentCamera.ViewportSize.X/2)/100
	local deltaY = (mouse.Y - workspace.CurrentCamera.ViewportSize.Y/2)/100
	BG.Position = UDim2.new(-0.075 + deltaX/300,0,-0.075 + deltaY/300,0)
	Overlay.Position = UDim2.new(deltaX/500,0,deltaY/500,0)
	MainFrame.Rotation = deltaX/10
	-- Glow del Start sigue mouse
	local startCenter = Start.AbsolutePosition + Vector2.new(Start.AbsoluteSize.X/2, Start.AbsoluteSize.Y/2)
	local dist = (Vector2.new(mouse.X, mouse.Y) - startCenter).Magnitude
	StartGlow.Transparency = math.clamp(dist/300,0.05,0.4)
	Aura.Rate = math.clamp(50 - dist/5,10,50)
end)
