local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotTestGUI"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = gui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.Text = "GUI Loaded (Delta Test)"
label.Font = Enum.Font.GothamBold
label.TextSize = 22
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Parent = frame
