local player = game.Players.LocalPlayer
player.CharacterAdded:Wait()
local pg = player:WaitForChild("PlayerGui")

task.wait(0.3) -- small delay for safety

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotHubGUI"
gui.ResetOnSpawn = false
gui.Parent = pg

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.25, 0)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Brainrot Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

-- Auto Pickup Button
local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0.45,0,0.25,0)
autoBtn.Position = UDim2.new(0.05,0,0.3,0)
autoBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
autoBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoBtn.Text = "Enable Auto Pickup"
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextScaled = true
autoBtn.Parent = frame

-- Teleport Button
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.45,0,0.25,0)
tpBtn.Position = UDim2.new(0.5,0,0.3,0)
tpBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBtn.Text = "Teleport to Base"
tpBtn.Font = Enum.Font.Gotham
tpBtn.TextScaled = true
tpBtn.Parent = frame

-- Status Label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0.15,0)
status.Position = UDim2.new(0,0,0.8,0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Text = "Status: Idle"
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame
