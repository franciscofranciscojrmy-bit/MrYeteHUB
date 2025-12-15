--====================================================
-- MRYETE PRO KEY SYSTEM (FINAL)
--====================================================

-- SERVICES
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

-- GUI PARENT
local GuiParent
pcall(function() GuiParent = gethui() end)
if not GuiParent then
	GuiParent = game:GetService("CoreGui")
end

-- CONFIG
local MAIN_URL = "https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

local VALID_KEYS = {
	"MRYETE-2025-ALPHA",
	"MRYETE-DEV-ACCESS"
}

local MAX_ATTEMPTS = 3
local LOCK_TIME = 15

-- STATE
local attempts = 0
local locked = false

-- BLUR
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0

-- SOUNDS
local ErrorSound = Instance.new("Sound", SoundService)
ErrorSound.SoundId = "rbxassetid://138079197"
ErrorSound.Volume = 1

local SuccessSound = Instance.new("Sound", SoundService)
SuccessSound.SoundId = "rbxassetid://6026984224"
SuccessSound.Volume = 1

-- GUI
local ScreenGui = Instance.new("ScreenGui", GuiParent)
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,440,0,320)
Frame.Position = UDim2.new(0.5,-220,0.5,-160)
Frame.BackgroundTransparency = 1
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,20)

local Scale = Instance.new("UIScale", Frame)
Scale.Scale = 0

-- BACKGROUND
local BG = Instance.new("ImageLabel", Frame)
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://15801196846"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,20)

local Overlay = Instance.new("Frame", BG)
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.35
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,20)

-- GLOW
local Glow = Instance.new("UIStroke", BG)
Glow.Color = Color3.fromRGB(200,120,255)
Glow.Thickness = 3
Glow.Transparency = 0.25

-- GLOW PULSE
task.spawn(function()
	while true do
		TweenService:Create(Glow,TweenInfo.new(1.2),{Thickness=6,Transparency=0.1}):Play()
		task.wait(1.2)
		TweenService:Create(Glow,TweenInfo.new(1.2),{Thickness=3,Transparency=0.35}):Play()
		task.wait(1.2)
	end
end)

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,-40,0,42)
Title.Position = UDim2.new(0,20,0,18)
Title.Text = "MRYETE Key System"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 30
Title.TextColor3 = Color3.fromRGB(220,160,255)
Title.TextStrokeTransparency = 0.3
Title.BackgroundTransparency = 1

-- INPUT
local Input = Instance.new("TextBox", Frame)
Input.Size = UDim2.new(0,320,0,46)
Input.Position = UDim2.new(0.5,-160,0.5,-8)
Input.PlaceholderText = "Ingresa tu key aquí"
Input.Text = ""
Input.Font = Enum.Font.Gotham
Input.TextSize = 18
Input.TextColor3 = Color3.new(1,1,1)
Input.BackgroundColor3 = Color3.fromRGB(35,35,55)
Instance.new("UICorner", Input).CornerRadius = UDim.new(0,14)

local InputStroke = Instance.new("UIStroke", Input)
InputStroke.Color = Color3.fromRGB(180,120,255)
InputStroke.Thickness = 2

-- VERIFY BUTTON
local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0,200,0,50)
Button.Position = UDim2.new(0.5,-100,1,-78)
Button.Text = "VERIFY"
Button.Font = Enum.Font.GothamBold
Button.TextSize = 20
Button.TextColor3 = Color3.new(1,1,1)
Button.BackgroundColor3 = Color3.fromRGB(150,80,220)
Instance.new("UICorner", Button).CornerRadius = UDim.new(0,16)

local BtnGlow = Instance.new("UIStroke", Button)
BtnGlow.Color = Color3.fromRGB(220,160,255)
BtnGlow.Thickness = 3
BtnGlow.Transparency = 0.2

-- BUTTON AURA
task.spawn(function()
	while true do
		TweenService:Create(BtnGlow,TweenInfo.new(1),{Transparency=0.05}):Play()
		task.wait(1)
		TweenService:Create(BtnGlow,TweenInfo.new(1),{Transparency=0.3}):Play()
		task.wait(1)
	end
end)

-- STATUS
local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1,0,0,26)
Status.Position = UDim2.new(0,0,0.72,0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold
Status.TextSize = 16

-- ENTRANCE
TweenService:Create(Scale,TweenInfo.new(0.7,Enum.EasingStyle.Back),{Scale=1}):Play()
TweenService:Create(Blur,TweenInfo.new(0.6),{Size=14}):Play()

-- DRAG (SAFE)
do
	local dragging, startPos, startInput
	Frame.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			startInput = i.Position
			startPos = Frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = i.Position - startInput
			Frame.Position = startPos + UDim2.new(0,delta.X,0,delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
end

-- GLITCH EFFECT
local function glitch()
	for i=1,5 do
		BG.ImageColor3 = Color3.fromRGB(255, math.random(0,255), 255)
		Frame.Position += UDim2.new(0,math.random(-10,10),0,math.random(-6,6))
		task.wait(0.03)
	end
	BG.ImageColor3 = Color3.new(1,1,1)
end

-- LOCK TIMER
local function lockCountdown()
	locked = true
	for i=LOCK_TIME,1,-1 do
		Status.Text = "Bloqueado ("..i.."s)"
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		task.wait(1)
	end
	Status.Text = ""
	attempts = 0
	locked = false
end

-- VERIFY
Button.MouseButton1Click:Connect(function()
	if locked then return end

	local key = Input.Text
	if table.find(VALID_KEYS, key) then
		SuccessSound:Play()
		InputStroke.Color = Color3.fromRGB(80,255,120)
		Status.Text = "ACCESS GRANTED ✔"
		Status.TextColor3 = Color3.fromRGB(80,255,120)
		task.wait(0.6)
		TweenService:Create(Blur,TweenInfo.new(0.4),{Size=0}):Play()
		ScreenGui:Destroy()
		loadstring(game:HttpGet(MAIN_URL))()
	else
		ErrorSound:Play()
		attempts += 1
		InputStroke.Color = Color3.fromRGB(255,80,80)
		Status.Text = "INVALID KEY ("..attempts.."/"..MAX_ATTEMPTS..")"
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		glitch()
		if attempts >= MAX_ATTEMPTS then
			task.spawn(lockCountdown)
		end
	end
end)
