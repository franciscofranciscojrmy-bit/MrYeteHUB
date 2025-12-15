--====================================
-- MRYETE KEY SYSTEM - FINAL FIX
--====================================

-- SERVICES
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- GUI PARENT
local GuiParent
pcall(function() GuiParent = gethui() end)
if not GuiParent then
	GuiParent = game:GetService("CoreGui")
end

-- BLUR
local Blur = Instance.new("BlurEffect")
Blur.Parent = Lighting
Blur.Size = 0

-- URL DEL SCRIPT REAL
local MAIN_URL = "https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

-- KEYS
local VALID_KEYS = {
	"MRYETE-2025-ALPHA",
	"MRYETE-DEV-ACCESS"
}

-- GUI
local ScreenGui = Instance.new("ScreenGui", GuiParent)
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,420,0,300)
Main.Position = UDim2.new(0.5,-210,0.5,-150)
Main.BackgroundTransparency = 1
Main.Active = true
Main.ZIndex = 10
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

local UIScale = Instance.new("UIScale", Main)
UIScale.Scale = 0

-- BACKGROUND IMAGE
local BG = Instance.new("ImageLabel", Main)
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://15801196846"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
BG.ZIndex = 1
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,18)

-- OVERLAY
local Overlay = Instance.new("Frame", BG)
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.35
Overlay.ZIndex = 2
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,18)

-- GLOW
local Glow = Instance.new("UIStroke", BG)
Glow.Color = Color3.fromRGB(190,120,255)
Glow.Thickness = 3
Glow.Transparency = 0.25

-- GLOW PULSANTE
task.spawn(function()
	while true do
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=6,Transparency=0.1}):Play()
		task.wait(1)
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=3,Transparency=0.35}):Play()
		task.wait(1)
	end
end)

-- ===== TITULO (ARREGLADO DEFINITIVAMENTE) =====
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -40, 50, 0)
Title.Position = UDim2.new(0, 20, 0, 25)
Title.Text = "MRYETE Key System"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 30
Title.TextColor3 = Color3.fromRGB(210,150,255)
Title.TextStrokeTransparency = 0.3
Title.BackgroundTransparency = 1
Title.ZIndex = 20

-- SUBTITULO
local Subtitle = Instance.new("TextLabel", Main)
Subtitle.Size = UDim2.new(1, -40, 30, 0)
Subtitle.Position = UDim2.new(0, 20, 0, 65)
Subtitle.Text = "Acceso exclusivo"
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextSize = 16
Subtitle.TextColor3 = Color3.fromRGB(180,180,255)
Subtitle.BackgroundTransparency = 1
Subtitle.ZIndex = 20

-- INPUT
local Input = Instance.new("TextBox", Main)
Input.Size = UDim2.new(0,300,0,44)
Input.Position = UDim2.new(0.5,-150,0.5,-10)
Input.PlaceholderText = "Ingresa tu key aquí"
Input.Text = ""
Input.Font = Enum.Font.Gotham
Input.TextSize = 18
Input.TextColor3 = Color3.new(1,1,1)
Input.BackgroundColor3 = Color3.fromRGB(35,35,55)
Input.ZIndex = 20
Instance.new("UICorner", Input).CornerRadius = UDim.new(0,12)

-- BUTTON
local Button = Instance.new("TextButton", Main)
Button.Size = UDim2.new(0,180,0,46)
Button.Position = UDim2.new(0.5,-90,1,-70)
Button.Text = "VERIFY"
Button.Font = Enum.Font.GothamBold
Button.TextSize = 18
Button.TextColor3 = Color3.new(1,1,1)
Button.BackgroundColor3 = Color3.fromRGB(150,80,220)
Button.ZIndex = 20
Instance.new("UICorner", Button).CornerRadius = UDim.new(0,14)

-- STATUS
local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1,0,26,0)
Status.Position = UDim2.new(0,0,0.7,0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold
Status.TextSize = 16
Status.Text = ""
Status.ZIndex = 20

-- ANIMACION DE ENTRADA
TweenService:Create(UIScale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
TweenService:Create(Blur,TweenInfo.new(0.5),{Size=14}):Play()

-- SHAKE ERROR
local function shake()
	local original = Main.Position
	for i=1,12 do
		Main.Position = original + UDim2.new(0,math.random(-12,12),0,0)
		task.wait(0.02)
	end
	Main.Position = original
end

-- VERIFY
Button.MouseButton1Click:Connect(function()
	local key = Input.Text
	local valid = false

	for _,v in ipairs(VALID_KEYS) do
		if key == v then valid = true end
	end

	if valid then
		Status.Text = "ACCESS GRANTED ✔"
		Status.TextColor3 = Color3.fromRGB(80,255,120)
		task.wait(0.6)
		TweenService:Create(Blur,TweenInfo.new(0.4),{Size=0}):Play()
		ScreenGui:Destroy()
		loadstring(game:HttpGet(MAIN_URL))()
	else
		Status.Text = "INVALID KEY ✖"
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		shake()
	end
end)

-- PARALLAX
RunService.RenderStepped:Connect(function()
	local mouse = UserInputService:GetMouseLocation()
	local cx,cy = workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2
	local dx = (mouse.X - cx)/300
	local dy = (mouse.Y - cy)/300
	BG.Position = UDim2.new(-0.075 + dx,0,-0.075 + dy,0)
end)
