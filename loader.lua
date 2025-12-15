--====================================
-- MR_Yete HUB | KEY SYSTEM
--====================================

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- GUI PARENT SEGURO
local GuiParent
pcall(function() GuiParent = gethui() end)
if not GuiParent then GuiParent = game:GetService("CoreGui") end

-- BLUR
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0

-- URL SCRIPT REAL
local MAIN_URL = "https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

-- KEYS VÁLIDAS
local VALID_KEYS = {
	"MRYETE-2025-ALPHA",
	"MRYETE-DEV-ACCESS"
}

local function isValidKey(key)
	for _,v in ipairs(VALID_KEYS) do
		if key == v then
			return true
		end
	end
	return false
end

--====================================
-- GUI
--====================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MRYete_KeySystem"
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = GuiParent

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,380,0,260)
Main.Position = UDim2.new(0.5,-190,0.5,-130)
Main.BackgroundTransparency = 1
Main.Active = true
Main.ZIndex = 10
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local UIScale = Instance.new("UIScale", Main)
UIScale.Scale = 0

-- BACKGROUND IMAGE
local BG = Instance.new("ImageLabel", Main)
BG.Size = UDim2.new(1.15,0,1.15,0)
BG.Position = UDim2.new(-0.075,0,-0.075,0)
BG.Image = "rbxassetid://15801196846"
BG.BackgroundTransparency = 1
BG.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", BG).CornerRadius = UDim.new(0,16)

-- OVERLAY
local Overlay = Instance.new("Frame", BG)
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.35
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,16)

-- GLOW
local Glow = Instance.new("UIStroke", BG)
Glow.Color = Color3.fromRGB(180,80,255)
Glow.Thickness = 3
Glow.Transparency = 0.25

task.spawn(function()
	while true do
		TweenService:Create(Glow,TweenInfo.new(1),{
			Thickness = 6,
			Transparency = 0.1
		}):Play()
		task.wait(1)
		TweenService:Create(Glow,TweenInfo.new(1),{
			Thickness = 3,
			Transparency = 0.4
		}):Play()
		task.wait(1)
	end
end)

-- TITLE PRINCIPAL
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,40,0)
Title.Position = UDim2.new(0,0,0,10)
Title.Text = "MRYETE Key System"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 26
Title.TextColor3 = Color3.fromRGB(200,130,255)
Title.BackgroundTransparency = 1
Title.ZIndex = 20

-- SUB TEXTO
local Sub = Instance.new("TextLabel", Main)
Sub.Size = UDim2.new(1,0,26,0)
Sub.Position = UDim2.new(0,0,0,48)
Sub.Text = "Introduce tu clave para continuar"
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 15
Sub.TextColor3 = Color3.fromRGB(200,200,200)
Sub.BackgroundTransparency = 1
Sub.ZIndex = 20

-- INPUT KEY
local Input = Instance.new("TextBox", Main)
Input.Size = UDim2.new(0,280,0,42)
Input.Position = UDim2.new(0.5,-140,0.5,-10)
Input.PlaceholderText = "KEY AQUÍ"
Input.Font = Enum.Font.Gotham
Input.TextSize = 18
Input.TextColor3 = Color3.new(1,1,1)
Input.BackgroundColor3 = Color3.fromRGB(35,35,50)
Input.ZIndex = 20
Instance.new("UICorner", Input).CornerRadius = UDim.new(0,10)

-- BOTÓN VERIFY
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

local ButtonGlow = Instance.new("UIStroke", Button)
ButtonGlow.Color = Color3.fromRGB(210,150,255)
ButtonGlow.Thickness = 3
ButtonGlow.Transparency = 0.2

-- STATUS
local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1,0,26,0)
Status.Position = UDim2.new(0,0,0.72,0)
Status.Text = ""
Status.Font = Enum.Font.GothamBold
Status.TextSize = 16
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255,80,80)
Status.ZIndex = 20

-- CLOSE
local Close = Instance.new("TextButton", Main)
Close.Text = "✕"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 20
Close.Size = UDim2.new(0,34,0,34)
Close.Position = UDim2.new(1,-42,0,8)
Close.BackgroundColor3 = Color3.fromRGB(180,60,60)
Close.TextColor3 = Color3.new(1,1,1)
Close.ZIndex = 30
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

Close.MouseButton1Click:Connect(function()
	TweenService:Create(Blur,TweenInfo.new(0.3),{Size=0}):Play()
	ScreenGui:Destroy()
end)

-- DRAG
do
	local dragging, startPos, startInput
	Main.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			startInput = i.Position
			startPos = Main.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
			local d = i.Position - startInput
			Main.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y
			)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

-- OPEN ANIMATION
TweenService:Create(UIScale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
TweenService:Create(Blur,TweenInfo.new(0.5),{Size=12}):Play()

-- VERIFY
Button.MouseButton1Click:Connect(function()
	if isValidKey(Input.Text) then
		Status.TextColor3 = Color3.fromRGB(80,255,120)
		Status.Text = "KEY CORRECTA ✔"

		task.wait(0.6)
		TweenService:Create(Blur,TweenInfo.new(0.4),{Size=0}):Play()
		ScreenGui:Destroy()

		loadstring(game:HttpGet(MAIN_URL))()
	else
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		Status.Text = "KEY INVÁLIDA ✖"
	end
end)
