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
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false

-- SOUND
local ClickSound = Instance.new("Sound", ScreenGui)
ClickSound.SoundId = "rbxassetid://12221967"
ClickSound.Volume = 0.8

-- MAIN FRAME
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0,320,0,240)
MainFrame.Position = UDim2.new(0.5,-160,0.5,-120)
MainFrame.BackgroundTransparency = 1
MainFrame.Active = true
MainFrame.Visible = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,14)

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

-- CREDIT (COPY LINK)
local Credit = Instance.new("TextButton", MainFrame)
Credit.Size = UDim2.new(1,0,0,32)
Credit.Position = UDim2.new(0,0,1,-34)
Credit.BackgroundTransparency = 1
Credit.Text = "mr_yete | TikTok"
Credit.Font = Enum.Font.LuckiestGuy
Credit.TextSize = 26
Credit.TextColor3 = Color3.fromRGB(190,90,255)

Credit.MouseButton1Click:Connect(function()
	ClickSound:Play()
	pcall(function()
		setclipboard("https://www.tiktok.com/@mr_yete")
	end)
	notify("Link copiado")
end)

-- FLOAT ICON (MINIMIZED)
local Circle = Instance.new("ImageButton", ScreenGui)
Circle.Image = "rbxassetid://85542695667199"
Circle.Size = UDim2.new(0,56,0,56)
Circle.Position = UDim2.new(0,20,0.5,0)
Circle.Visible = false
Circle.BackgroundTransparency = 1
Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

-- DRAG (PC + MOBILE)
local function drag(obj)
	local dragging, startPos, startInput
	obj.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startPos = obj.Position
			startInput = i.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local delta = i.Position - startInput
			obj.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

drag(MainFrame)
drag(Circle)

-- 🔽 MINIMIZE BUTTON (AGREGADO)
local Minimize = Instance.new("ImageButton", MainFrame)
Minimize.Image = "rbxassetid://6031091002"
Minimize.Size = UDim2.new(0,34,0,34)
Minimize.Position = UDim2.new(1,-76,0,8)
Minimize.BackgroundColor3 = Color3.fromRGB(120,0,255)
Minimize.BackgroundTransparency = 0.2
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(1,0)

Minimize.MouseButton1Click:Connect(function()
	ClickSound:Play()
	MainFrame.Visible = false
	Circle.Visible = true
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=0}):Play()
end)

Circle.MouseButton1Click:Connect(function()
	ClickSound:Play()
	MainFrame.Visible = true
	Circle.Visible = false
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=12}):Play()
end)

-- CLOSE (DESTROY)
local Close = Instance.new("ImageButton", MainFrame)
Close.Image = "rbxassetid://6031094678"
Close.Size = UDim2.new(0,34,0,34)
Close.Position = UDim2.new(1,-38,0,8)
Close.BackgroundColor3 = Color3.fromRGB(255,60,60)
Close.BackgroundTransparency = 0.15
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

Close.MouseButton1Click:Connect(function()
	ClickSound:Play()
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=0}):Play()
	ScreenGui:Destroy()
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

-- SCRIPT LOGIC
local running = false
local loopTask

local function startScript()
	running = true
	Start.Text = "STOP"
	notify("Script iniciado")

	loopTask = task.spawn(function()
		while running do
			local folder = workspace:FindFirstChild("Brainrots")
			if folder then
				local char = player.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				if hrp then
					for _,p in ipairs(folder:GetChildren()) do
						pcall(function()
							firetouchinterest(hrp,p,0)
							task.wait(0.05)
							firetouchinterest(hrp,p,1)
						end)
					end
				end
			end
			task.wait(0.25)
		end
	end)
end

local function stopScript()
	running = false
	Start.Text = "START"
	notify("Script detenido")
	if loopTask then
		task.cancel(loopTask)
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

-- AUTO SHOW
TweenService:Create(Blur,TweenInfo.new(0.4),{Size=12}):Play()
notify("GUI cargada correctamente")

