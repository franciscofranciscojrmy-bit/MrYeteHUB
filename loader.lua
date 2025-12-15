--====================================
-- MRYETE KEY SYSTEM LOADER
--====================================

-- SERVICES
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

-- GUI PARENT
local GuiParent
pcall(function() GuiParent = gethui() end)
if not GuiParent then
	GuiParent = game:GetService("CoreGui")
end

-- BLUR
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0

-- SCRIPT REAL
local MAIN_URL = "https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

-- KEYS VALIDAS
local VALID_KEYS = {
	"MRYETE-2025-ALPHA",
	"MRYETE-DEV-ACCESS"
}

local MAX_ATTEMPTS = 3
local lockTime = 10
local attempts = 0
local locked = false

-- SONIDO DE ERROR
local ErrorSound = Instance.new("Sound", SoundService)
ErrorSound.SoundId = "rbxassetid://138079197" -- sonido de error
ErrorSound.Volume = 1

-- GUI
local ScreenGui = Instance.new("ScreenGui", GuiParent)
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,420,0,300)
Frame.Position = UDim2.new(0.5,-210,0.5,-150)
Frame.BackgroundTransparency = 1
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,18)

local Scale = Instance.new("UIScale", Frame)
Scale.Scale = 0

-- BACKGROUND
local BG = Instance.new("ImageLabel", Frame)
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://15801196846"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,18)

local Overlay = Instance.new("Frame", BG)
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.35
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,18)

-- GLOW
local Glow = Instance.new("UIStroke", BG)
Glow.Color = Color3.fromRGB(190,120,255)
Glow.Thickness = 3
Glow.Transparency = 0.25

-- Glow pulsante
task.spawn(function()
	while true do
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=6,Transparency=0.1}):Play()
		task.wait(1)
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=3,Transparency=0.35}):Play()
		task.wait(1)
	end
end)

-- TITULO
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,-40,0,40)
Title.Position = UDim2.new(0,20,0,18)
Title.Text = "MRYETE Key System"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(210,150,255)
Title.BackgroundTransparency = 1

-- INPUT
local Input = Instance.new("TextBox", Frame)
Input.Size = UDim2.new(0,300,0,44)
Input.Position = UDim2.new(0.5,-150,0.5,-10)
Input.PlaceholderText = "Ingresa tu key aquí"
Input.Text = ""
Input.Font = Enum.Font.Gotham
Input.TextSize = 18
Input.TextColor3 = Color3.new(1,1,1)
Input.BackgroundColor3 = Color3.fromRGB(35,35,55)
Instance.new("UICorner", Input).CornerRadius = UDim.new(0,12)

-- BUTTON
local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0,180,0,46)
Button.Position = UDim2.new(0.5,-90,1,-70)
Button.Text = "VERIFY"
Button.Font = Enum.Font.GothamBold
Button.TextSize = 18
Button.TextColor3 = Color3.new(1,1,1)
Button.BackgroundColor3 = Color3.fromRGB(150,80,220)
Instance.new("UICorner", Button).CornerRadius = UDim.new(0,14)

-- STATUS
local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1,0,0,26)
Status.Position = UDim2.new(0,0,0.7,0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold
Status.TextSize = 16
Status.TextColor3 = Color3.new(1,1,1)

-- ENTRADA ANIMADA
TweenService:Create(Scale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
TweenService:Create(Blur,TweenInfo.new(0.5),{Size=14}):Play()

-- DRAG
do
	local dragging, startPos, startInput
	Frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			startInput = input.Position
			startPos = Frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - startInput
			Frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

-- GLITCH EFECTO
local function glitchEffect()
	for i=1,3 do
		Frame.Position = Frame.Position + UDim2.new(0,math.random(-8,8),0,math.random(-8,8))
		task.wait(0.03)
	end
end

-- SHAKE
local function shake()
	local original = Frame.Position
	for i=1,6 do
		Frame.Position = original + UDim2.new(0,math.random(-10,10),0,0)
		task.wait(0.02)
	end
	Frame.Position = original
end

-- LOCK TIMER
local function lockTimer()
	locked = true
	for i=lockTime,1,-1 do
		Status.Text = "Bloqueado por " .. i .. "s"
		Status.TextColor3 = Color3.fromRGB(255,50,50)
		task.wait(1)
	end
	Status.Text = ""
	attempts = 0
	locked = false
end

-- VERIFY LOGIC
Button.MouseButton1Click:Connect(function()
	if locked then return end
	local key = Input.Text
	if table.find(VALID_KEYS,key) then
		Status.Text = "ACCESS GRANTED ✔"
		Status.TextColor3 = Color3.fromRGB(80,255,120)
		task.wait(0.6)
		TweenService:Create(Blur,TweenInfo.new(0.4),{Size=0}):Play()
		ScreenGui:Destroy()
		loadstring(game:HttpGet(MAIN_URL))()
	else
		ErrorSound:Play()
		Status.Text = "INVALID KEY ✖"
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		shake()
		glitchEffect()
		attempts = attempts + 1
		if attempts >= MAX_ATTEMPTS then
			task.spawn(lockTimer)
		end
	end
end)

