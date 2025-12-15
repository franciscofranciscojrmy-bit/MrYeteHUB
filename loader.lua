--====================================
-- MR_Yete HUB | KEY SYSTEM PRO
--====================================

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

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

-- CONFIG SEGURIDAD
local MAX_FAILS = 3
local LOCK_TIME = 10 -- segundos

local fails = 0
local locked = false

-- FUNCIONES
local function isValidKey(key)
	for _,v in ipairs(VALID_KEYS) do
		if key == v then
			return true
		end
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

-- GLOW
local Glow = Instance.new("UIStroke", BG)
Glow.Color = Color3.fromRGB(180,80,255)
Glow.Thickness = 3
Glow.Transparency = 0.25

task.spawn(function()
	while true do
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=6,Transparency=0.1}):Play()
		task.wait(1)
		TweenService:Create(Glow,TweenInfo.new(1),{Thickness=3,Transparency=0.4}):Play()
		task.wait(1)
	end
end)

-- SOUNDS
local SoundOk = Instance.new("Sound", ScreenGui)
SoundOk.SoundId = "rbxassetid://6026984224"
SoundOk.Volume = 1

local SoundFail = Instance.new("Sound", ScreenGui)
SoundFail.SoundId = "rbxassetid://9118823101"
SoundFail.Volume = 1

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,40,0)
Title.Position = UDim2.new(0,0,0,10)
Title.Text = "MRYETE Key System"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 26
Title.TextColor3 = Color3.fromRGB(200,130,255)
Title.BackgroundTransparency = 1

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
Instance.new("UICorner", Button).CornerRadius = UDim.new(0,12)

-- STATUS
local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1,0,26,0)
Status.Position = UDim2.new(0,0,0.72,0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.GothamBold
Status.TextSize = 16

-- DRAG
do
	local dragging, startPos, startInput
	Main.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging=true
			startInput=i.Position
			startPos=Main.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
			local d=i.Position-startInput
			Main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
	end)
end

-- OPEN
TweenService:Create(UIScale,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Scale=1}):Play()
TweenService:Create(Blur,TweenInfo.new(0.5),{Size=12}):Play()

-- SHAKE
local function shake()
	local original = Main.Position
	for i=1,10 do
		Main.Position = original + UDim2.new(0,math.random(-10,10),0,0)
		task.wait(0.02)
	end
	Main.Position = original
end

-- VERIFY
Button.MouseButton1Click:Connect(function()
	if locked then
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		Status.Text = "Bloqueado temporalmente"
		return
	end

	if isValidKey(Input.Text) then
		SoundOk:Play()
		Status.TextColor3 = Color3.fromRGB(80,255,120)
		Status.Text = "KEY CORRECTA ✔"
		task.wait(0.6)
		TweenService:Create(Blur,TweenInfo.new(0.4),{Size=0}):Play()
		ScreenGui:Destroy()
		loadstring(game:HttpGet(MAIN_URL))()
	else
		fails += 1
		SoundFail:Play()
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		Status.Text = "KEY INCORRECTA ("..fails.."/"..MAX_FAILS..")"
		shake()

		TweenService:Create(Input,TweenInfo.new(0.15),{
			BackgroundColor3=Color3.fromRGB(120,30,30)
		}):Play()

		task.delay(0.3,function()
			TweenService:Create(Input,TweenInfo.new(0.2),{
				BackgroundColor3=Color3.fromRGB(35,35,50)
			}):Play()
		end)

		if fails >= MAX_FAILS then
			locked = true
			Status.Text = "Bloqueado "..LOCK_TIME.."s"
			task.spawn(function()
				for i=LOCK_TIME,1,-1 do
					Status.Text = "Bloqueado "..i.."s"
					task.wait(1)
				end
				fails = 0
				locked = false
				Status.Text = ""
			end)
		end
	end
end)
