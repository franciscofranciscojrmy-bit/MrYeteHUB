--==============================
-- MRYETE KEY SYSTEM LOADER
--==============================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local GuiParent
pcall(function() GuiParent = gethui() end)
if not GuiParent then
	GuiParent = game:GetService("CoreGui")
end

-- BLUR
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0

-- CONFIG
local MAIN_SCRIPT_URL =
"https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

local VALID_KEYS = {
	"MRYETE-2025-ALPHA",
	"MRYETE-DEV-ACCESS"
}

-- GUI
local ScreenGui = Instance.new("ScreenGui", GuiParent)
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,420,0,300)
Frame.Position = UDim2.new(0.5,-210,0.5,-150)
Frame.BackgroundTransparency = 1
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,18)

local Scale = Instance.new("UIScale", Frame)
Scale.Scale = 0

-- BACKGROUND IMAGE
local BG = Instance.new("ImageLabel", Frame)
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://15801196846"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,18)

-- OVERLAY
local Overlay = Instance.new("Frame", BG)
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.35
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,18)

-- GLOW
local Stroke = Instance.new("UIStroke", BG)
Stroke.Color = Color3.fromRGB(190,120,255)
Stroke.Thickness = 3
Stroke.Transparency = 0.25

-- PULSE
task.spawn(function()
	while true do
		TweenService:Create(Stroke,TweenInfo.new(1),{Thickness=6,Transparency=0.1}):Play()
		task.wait(1)
		TweenService:Create(Stroke,TweenInfo.new(1),{Thickness=3,Transparency=0.35}):Play()
		task.wait(1)
	end
end)

-- TITLE (ESTE YA NO SE ESCONDE)
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,-40,50,0)
Title.Position = UDim2.new(0,20,0,25)
Title.Text = "MRYETE Key System"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 30
Title.TextColor3 = Color3.fromRGB(210,150,255)
Title.TextStrokeTransparency = 0.3
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
Status.Size = UDim2.new(1,0,26,0)
Status.Position = UDim2.new(0,0,0.72,0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold
Status.TextSize = 16

-- ENTRANCE
TweenService:Create(Scale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
TweenService:Create(Blur,TweenInfo.new(0.5),{Size=14}):Play()

-- SHAKE ERROR
local function shake()
	local p = Frame.Position
	for i=1,10 do
		Frame.Position = p + UDim2.new(0,math.random(-12,12),0,0)
		task.wait(0.02)
	end
	Frame.Position = p
end

-- VERIFY
Button.MouseButton1Click:Connect(function()
	local key = Input.Text
	for _,v in ipairs(VALID_KEYS) do
		if key == v then
			Status.Text = "ACCESS GRANTED ✔"
			Status.TextColor3 = Color3.fromRGB(80,255,120)
			task.wait(0.6)
			TweenService:Create(Blur,TweenInfo.new(0.4),{Size=0}):Play()
			ScreenGui:Destroy()
			loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
			return
		end
	end
	Status.Text = "INVALID KEY ✖"
	Status.TextColor3 = Color3.fromRGB(255,80,80)
	shake()
end)

-- PARALLAX
RunService.RenderStepped:Connect(function()
	local m = UserInputService:GetMouseLocation()
	local c = workspace.CurrentCamera.ViewportSize
	BG.Position = UDim2.new(-0.075+(m.X-c.X/2)/400,0,-0.075+(m.Y-c.Y/2)/400,0)
end)
