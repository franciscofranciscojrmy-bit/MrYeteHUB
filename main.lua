--=====================================================
-- MR_YETE | BRAINROT HUB (REAL + LOADER COMPATIBLE)
--=====================================================

-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

--=====================================================
-- NOTIFY
--=====================================================
local function notify(title, text, time)
	StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = time or 3
	})
end

notify("MR_Yete HUB", "Presiona CTRL para abrir el menú", 5)

--=====================================================
-- BLUR
--=====================================================
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

local function blurOn()
	TweenService:Create(blur, TweenInfo.new(0.4), {Size = 18}):Play()
end

local function blurOff()
	TweenService:Create(blur, TweenInfo.new(0.4), {Size = 0}):Play()
end

--=====================================================
-- GUI
--=====================================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.DisplayOrder = 999999
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,360,0,230)
Main.Position = UDim2.new(0.5,-180,0.5,-115)
Main.Visible = false
Main.Active = true
Main.ZIndex = 10
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

-- BACKGROUND IMAGE
local Bg = Instance.new("ImageLabel", Main)
Bg.Size = UDim2.new(1,0,1,0)
Bg.Image = "rbxassetid://85542695667199"
Bg.BackgroundTransparency = 1
Instance.new("UICorner", Bg).CornerRadius = UDim.new(0,18)

-- DARK OVERLAY
local Overlay = Instance.new("Frame", Main)
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.4
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0,18)

-- START BUTTON
local Start = Instance.new("TextButton", Main)
Start.Size = UDim2.new(0,200,0,55)
Start.Position = UDim2.new(0.5,-100,0.5,-15)
Start.Text = "START"
Start.Font = Enum.Font.FredokaOne
Start.TextSize = 28
Start.TextColor3 = Color3.new(1,1,1)
Start.BackgroundColor3 = Color3.fromRGB(130,50,120)
Instance.new("UICorner", Start).CornerRadius = UDim.new(0,14)

-- GLOW
local Stroke = Instance.new("UIStroke", Start)
Stroke.Color = Color3.fromRGB(200,120,255)
Stroke.Thickness = 2
TweenService:Create(
	Stroke,
	TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
	{Thickness = 6}
):Play()

-- CREDIT
local Credit = Instance.new("TextButton", Main)
Credit.Size = UDim2.new(1,0,30,0)
Credit.Position = UDim2.new(0,0,1,-32)
Credit.Text = "MR_YETE"
Credit.Font = Enum.Font.Arcade
Credit.TextSize = 20
Credit.TextColor3 = Color3.fromRGB(190,120,255)
Credit.BackgroundTransparency = 1

Credit.MouseButton1Click:Connect(function()
	setclipboard("https://www.tiktok.com/@mr_yete")
	notify("MR_Yete", "Has copiado el TikTok del desarrollador", 3)
end)

--=====================================================
-- OPEN / CLOSE (CTRL)
--=====================================================
UserInputService.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.LeftControl then
		Main.Visible = not Main.Visible
		if Main.Visible then blurOn() else blurOff() end
	end
end)

--=====================================================
-- SCRIPT ORIGINAL (INTACTO)
--=====================================================
local running = false

Start.MouseButton1Click:Connect(function()
	if running then return end
	running = true

	notify("MR_Yete", "Brainrot iniciado con éxito", 3)

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

		workspace.Brainrots.ChildAdded:Connect(function(p)
			if p:IsA("BasePart") then
				wreston(p)
			end
		end)
	end)
end)
