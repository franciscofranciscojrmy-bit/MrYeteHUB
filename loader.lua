--====================================
-- MR_Yete HUB | KEY SYSTEM LOADER
--====================================

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- URL DEL SCRIPT REAL
local MAIN_URL = "https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

-- KEYS VALIDAS
local VALID_KEYS = {
	"mesedora1",
	"mesedora2"
}

--====================================
-- FUNCION KEY CHECK
--====================================
local function isValidKey(key)
	for _,k in ipairs(VALID_KEYS) do
		if key == k then
			return true
		end
	end
	return false
end

--====================================
-- GUI KEY
--====================================
local KeyGui = Instance.new("ScreenGui", CoreGui)
KeyGui.DisplayOrder = 1000000
KeyGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", KeyGui)
Frame.Size = UDim2.new(0,360,0,200)
Frame.Position = UDim2.new(0.5,-180,0.5,-100)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,30)
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)

-- DRAG
do
	local drag, startPos, startInput
	Frame.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = true
			startInput = i.Position
			startPos = Frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
			local d = i.Position - startInput
			Frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y
			)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = false
		end
	end)
end

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,40,0)
Title.Text = "MR_Yete HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(180,120,255)
Title.BackgroundTransparency = 1

-- INPUT
local Input = Instance.new("TextBox", Frame)
Input.Size = UDim2.new(0,280,0,40)
Input.Position = UDim2.new(0.5,-140,0.5,-20)
Input.PlaceholderText = "Introduce tu KEY"
Input.Text = ""
Input.Font = Enum.Font.Gotham
Input.TextSize = 18
Input.BackgroundCol
