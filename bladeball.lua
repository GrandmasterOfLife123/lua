-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local AutoParryButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local highlight = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local TextLabel_2 = Instance.new("TextLabel")
local UICorner_5 = Instance.new("UICorner")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.354257315, 0, 0.266644031, 0)
Frame.Size = UDim2.new(0, 505, 0, 305)

UICorner.Parent = Frame

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(0, 505, 0, 50)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "GRANDMASTER.OLO - BETA VERISION"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextSize = 22.000

UICorner_2.Parent = TextLabel

AutoParryButton.Name = "AutoParryButton"
AutoParryButton.Parent = Frame
AutoParryButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AutoParryButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoParryButton.BorderSizePixel = 0
AutoParryButton.Position = UDim2.new(0.171352997, 0, 0.239805326, 0)
AutoParryButton.Size = UDim2.new(0, 330, 0, 69)
AutoParryButton.Font = Enum.Font.SourceSansBold
AutoParryButton.Text = "AUTO PARRY"
AutoParryButton.TextColor3 = Color3.fromRGB(0, 0, 0)
AutoParryButton.TextSize = 40.000

UICorner_3.Parent = AutoParryButton

highlight.Name = "highlight"
highlight.Parent = Frame
highlight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
highlight.BorderSizePixel = 0
highlight.Position = UDim2.new(0.171352997, 0, 0.548002064, 0)
highlight.Size = UDim2.new(0, 330, 0, 70)
highlight.Font = Enum.Font.SourceSansBold
highlight.Text = "HIGHLIGHT ALL PLAYER HEADS"
highlight.TextColor3 = Color3.fromRGB(0, 0, 0)
highlight.TextSize = 25.000

UICorner_4.Parent = highlight

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0, 0, 0.83606559, 0)
TextLabel_2.Size = UDim2.new(0, 505, 0, 50)
TextLabel_2.Font = Enum.Font.SourceSansBold
TextLabel_2.Text = "AUTO PARRY IS STILL IN TESTING SO CLASHING WILL NOT WORK AS WELL."
TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.TextSize = 19.000

UICorner_5.Parent = TextLabel_2

-- Scripts:

local function HVNCQ_fake_script() -- AutoParryButton.LocalScript 
	local script = Instance.new('LocalScript', AutoParryButton)

	-- LocalScript inside the AutoParryButton
	
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	
	local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()
	local Remotes = ReplicatedStorage:WaitForChild("Remotes", 9e9) -- A second argument in waitforchild what could it mean?
	local Balls = workspace:WaitForChild("Balls", 9e9)
	
	local function VerifyBall(Ball)
		if typeof(Ball) == "Instance" and Ball:IsA("BasePart") and Ball:IsDescendantOf(Balls) and Ball:GetAttribute("realBall") == true then
			return true
		end
	end
	
	local function IsTarget()
		return (Player.Character and Player.Character:FindFirstChild("Highlight"))
	end
	
	local function Parry()
		Remotes:WaitForChild("ParryButtonPress"):Fire()
	end
	-- Change "AutoParryButton" to the actual name of your button
	local autoParryButton = script.Parent  -- Assuming the script is a child of the AutoParryButton
	
	autoParryButton.MouseButton1Click:Connect(function()
		-- Insert your Auto Parry logic here
		print("Auto Parry activated!")  -- Replace this line with the actual Auto Parry logic
		Parry()  -- This line should remain the same
	end)
	
	-- The actual Auto Parry code remains unchanged
	Balls.ChildAdded:Connect(function(Ball)
		if not VerifyBall(Ball) then
			return
		end
	
		local OldPosition = Ball.Position
		local OldTick = tick()
	
		Ball:GetPropertyChangedSignal("Position"):Connect(function()
			if IsTarget() then
				local Distance = (Ball.Position - workspace.CurrentCamera.Focus.Position).Magnitude
				local Velocity = (OldPosition - Ball.Position).Magnitude
	
				if (Distance / Velocity) <= 10 then
					Parry()
				end
			end
	
			if (tick() - OldTick >= 1/60) then
				OldTick = tick()
				OldPosition = Ball.Position
			end
		end)
	end)
	
end
coroutine.wrap(HVNCQ_fake_script)()
local function KJFF_fake_script() -- highlight.LocalScript 
	local script = Instance.new('LocalScript', highlight)

	-- Reference to the button
	local highlightButton = script.Parent -- Assuming the LocalScript is a child of the button
	
	-- Function to create a highlight for a player
	local function createHighlight(player)
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				-- Create a BillboardGui
				local billboard = Instance.new("BillboardGui")
				billboard.Size = UDim2.new(2, 0, 2, 0)
				billboard.Adornee = humanoid.Parent.Head
				billboard.Parent = character
	
				-- Create a frame inside the BillboardGui for highlighting
				local highlightFrame = Instance.new("Frame")
				highlightFrame.Size = UDim2.new(1, 0, 1, 0)
				highlightFrame.BackgroundTransparency = 0.5 -- Adjust transparency as needed
				highlightFrame.BackgroundColor3 = Color3.new(1, 1, 0) -- Set the highlight color to yellow
				highlightFrame.Parent = billboard
			end
		end
	end
	
	-- Function to activate highlight for all players
	local function activateHighlight()
		for _, player in pairs(game:GetService("Players"):GetPlayers()) do
			createHighlight(player)
		end
	end
	
	-- Connect button click event to activateHighlight function
	highlightButton.MouseButton1Click:Connect(activateHighlight)
	
end
coroutine.wrap(KJFF_fake_script)()
local function FGZVD_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	-- Reference to the GUI you want to make draggable
	local gui = script.Parent
	
	-- Variables to track dragging state
	local dragging = false
	local dragStart
	local startPos
	
	-- Function to update the GUI position based on user input
	local function updatePosition(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	-- Connect events for mouse/touch input
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragging then
				updatePosition(input)
			end
		end
	end)
	
end
coroutine.wrap(FGZVD_fake_script)()
