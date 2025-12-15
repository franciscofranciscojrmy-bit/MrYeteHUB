--====================================
-- MRYETE KEY SYSTEM (FIXED)
--====================================

-- SERVICES
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- GUI PARENT
local GuiParent
pcall(function() GuiParent = gethui() end)
if not GuiParent then GuiParent = game:GetService("CoreGui") end

-- BLUR
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0

-- SCRIPT REAL
local MAIN_URL = "https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

-- KEYS
local VALID_KEYS = {
	"MRYETE-2025-ALPHA",
	"MRYETE-DEV-ACCESS"
}

local MAX_FAILS = 3
local LOCK_TIME = 10
local fails = 0
local locked = false

local function isValidKey(k)
	for _,v in ipairs(VALID_KEYS) do
		if k == v then return true end
	end
	return false
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", GuiParent)
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,380,0,260)
Main.Position = UDim2.new(0.5,-190,0.5,-130)
Main.BackgroundTransparency = 1
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local UIScale = Instance.new("UIScale", Main)
UIScale.Scale = 0

-- BACKGROUND
local BG = Instance.new("ImageLabel", Main)
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://15801196846"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,16)

local Overlay = Instance.new("Frame", BG)
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.35
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,16)

local Glow = Instance.new("UIStroke", BG)
Glow.Color = Color3.fromRGB(180,80,255)
Glow.Thickness = 3
Glow.Transparency = 0.25

-- TITLE (🔥 ESTE ES EL QUE FALTABA)
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -20, 50, 0)
Title.Position = UDim2.new(0, 10, 0, 20)
Title.Text = "MRYETE Key System"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(210,150,255)
Title.TextStrokeTransparency = 0.3
Title.BackgroundTransparency = 1
Title.ZIndex = 20

-- INPUT
local Input = Instance.new("TextBox", Main)
Input.Size = UDim2.new(0,280,0,42)
Input.Position = UDim2.new(0.5,-140,0.5,-10)
Input.PlaceholderText = "Ingresa tu key aquí"
Input.Text = ""
Input.Font = Enum.Font.Gotham
Input.TextSize = 18
Input.TextColor3 = Color3.new(1,1,1)
Input.BackgroundColor3 = Color3.fromRGB(35,35,50)
Input.ZIndex = 20
Instance.new("UICorner", Input).CornerRadius = UDim.new(0,10)

-- BUTTON
local Button = Instance.new("TextButton", Main)
Button.Size = UDim2.new(0,160,0,44)
Button.Position = UDim2.new(0.5,-80,1,-62)
Button.Text = "VERIFY"
Button.Font = Enum.Font.GothamBold
Button.TextSize = 18
Button.TextColor3 = Color3.new(1,1,1)
Button.BackgroundColor3 = Color3.fromRGB(140,70,200)
Button.ZIndex = 20
Instance.new("UICorner", Button).CornerRadius = UDim.new(0,12)

-- STATUS
local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1,0,26,0)
Status.Position = UDim2.new(0,0,0.72,0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold
Status.TextSize = 16
Status.ZIndex = 20

-- OPEN
TweenService:Create(UIScale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
TweenService:Create(Blur,TweenInfo.new(0.5),{Size=12}):Play()

-- SHAKE
local function shake(obj)
	local original = obj.Position
	for i=1,10 do
		obj.Position = original + UDim2.new(0,math.random(-10,10),0,0)
		task.wait(0.02)
	end
	obj.Position = original
end

-- VERIFY
Button.MouseButton1Click:Connect(function()
	if locked then return end

	if isValidKey(Input.Text) then
		Status.TextColor3 = Color3.fromRGB(80,255,120)
		Status.Text = "ACCESS GRANTED ✔"
		task.wait(0.6)
		TweenService:Create(Blur,TweenInfo.new(0.4),{Size=0}):Play()
		ScreenGui:Destroy()
		loadstring(game:HttpGet(MAIN_URL))()
	else
		fails += 1
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		Status.Text = "ACCESS DENIED ✖"
		shake(Main)
	end
end)
