-- MR_Yete | Brainrot Script REAL (CORREGIDO)

-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- =========================
-- GUI
-- =========================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 200)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 40, 0)
Title.Text = "MR_Yete Brainrot"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(180, 120, 255)
Title.BackgroundTransparency = 1

local Start = Instance.new("TextButton", MainFrame)
Start.Size = UDim2.new(0, 180, 0, 50)
Start.Position = UDim2.new(0.5, -90, 0.5, -10)
Start.Text = "START"
Start.Font = Enum.Font.GothamBold
Start.TextSize = 24
Start.BackgroundColor3 = Color3.fromRGB(120, 0, 80)
Start.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Start).CornerRadius = UDim.new(0, 12)

-- DRAG
do
	local dragging, dragStart, startPos
	MainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(
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

-- =========================
-- SCRIPT ORIGINAL (RESTAURADO)
-- =========================
local running = false
local brainrotConnection

local function startBrainrot()
	if running then return end
	running = true

	task.spawn(function()
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")

		local function wreston(part)
			for _,ti in ipairs(part:GetChildren()) do
				if ti:IsA("TouchTransmitter") then
					firetouchinterest(hrp, part, 0)
					task.wait(0.1)
					firetouchinterest(hrp, part, 1)
				end
			end
		end

		for _,p in ipairs(workspace.Brainrots:GetChildren()) do
			if p:IsA("BasePart") then
				wreston(p)
			end
		end

		brainrotConnection = workspace.Brainrots.ChildAdded:Connect(function(p)
			if running and p:IsA("BasePart") then
				wreston(p)
			end
		end)
	end)
end

Start.MouseButton1Click:Connect(startBrainrot)
