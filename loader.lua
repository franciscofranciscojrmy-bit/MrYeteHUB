--====================================
-- MR_Yete HUB | KEY SYSTEM (FIXED)
--====================================

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- SAFE GUI PARENT (MUY IMPORTANTE)
local GuiParent
pcall(function()
	GuiParent = gethui()
end)
if not GuiParent then
	GuiParent = game:GetService("CoreGui")
end

-- URL SCRIPT REAL
local MAIN_URL = "https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

-- KEYS
local VALID_KEYS = {
	"MRYETE-2025-ALPHA",
	"MRYETE-DEV-ACCESS"
}

local function isValidKey(key)
	for _,k in ipairs(VALID_KEYS) do
		if key == k then
			return true
		end
	end
	return false
end

--====================================
-- GUI
--====================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MR_Yete_KeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1000000
ScreenGui.Parent = GuiParent

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,360,0,210)
Frame.Position = UDim2.new(0.5,-180,0.5,-105)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,30)
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)

-- DRAG
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
			local d = i.Position - startInput
			Frame.Position = UDim2.new(
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

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,44,0)
Title.Text = "MR_Yete HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(180,120,255)
Title.BackgroundTransparency = 1

-- INPUT
local Input = Instance.new("TextBox", Frame)
Input.Size = UDim2.new(0,280,0,42)
Input.Position = UDim2.new(0.5,-140,0.5,-20)
Input.PlaceholderText = "Introduce tu KEY"
Input.Font = Enum.Font.Gotham
Input.TextSize = 18
Input.TextColor3 = Color3.new(1,1,1)
Input.BackgroundColor3 = Color3.fromRGB(35,35,50)
Instance.new("UICorner", Input).CornerRadius = UDim.new(0,10)

-- BUTTON
local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0,150,0,40)
Button.Position = UDim2.new(0.5,-75,1,-50)
Button.Text = "VERIFY"
Button.Font = Enum.Font.GothamBold
Button.TextSize = 18
Button.TextColor3 = Color3.new(1,1,1)
Button.BackgroundColor3 = Color3.fromRGB(140,70,200)
Instance.new("UICorner", Button).CornerRadius = UDim.new(0,10)

-- STATUS
local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1,0,30,0)
Status.Position = UDim2.new(0,0,0.72,0)
Status.Text = ""
Status.Font = Enum.Font.GothamBold
Status.TextSize = 16
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255,80,80)

--====================================
-- LOGIC
--====================================
Button.MouseButton1Click:Connect(function()
	local key = Input.Text

	if isValidKey(key) then
		Status.TextColor3 = Color3.fromRGB(80,255,120)
		Status.Text = "KEY CORRECTA ✔"

		task.wait(0.6)
		ScreenGui:Destroy()

		loadstring(game:HttpGet(MAIN_URL))()
	else
		Status.TextColor3 = Color3.fromRGB(255,80,80)
		Status.Text = "KEY INVÁLIDA ✖"
	end
end)
