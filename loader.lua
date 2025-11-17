-- Delta GUI
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

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Jezzotrades
