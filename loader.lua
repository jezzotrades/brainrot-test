-- Delta Immediate GUI
local player = game:GetService("Players").LocalPlayer
local pg = player:WaitForChild("PlayerGui")

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotHubGUI"
gui.ResetOnSpawn = false
gui.Parent = pg

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,400,0,250)
frame.Position = UDim2.new(0.3,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Jezzotrades Instant Steal"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

-- Status Label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0.15,0)
status.Position = UDim2.new(0,0,0.75,0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Text = "Status: Idle"
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

-- Button
local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0.9,0,0.2,0)
autoBtn.Position =
