-- Get LocalPlayer and PlayerGui
local player = game:GetService("Players").LocalPlayer
local pg = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotHubGUI"
gui.ResetOnSpawn = false
gui.Parent = pg

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
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
title.Text = "Brainrot Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

-- Buttons
local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0.45,0,0.2,0)
autoBtn.Position = UDim2.new(0.05,0,0.2,0)
autoBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
autoBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoBtn.Text = "Enable Auto Pickup"
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextScaled = true
autoBtn.Parent = frame

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.45,0,0.2,0)
tpBtn.Position = UDim2.new(0.5,0,0.2,0)
tpBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBtn.Text = "Teleport to Base"
tpBtn.Font = Enum.Font.Gotham
tpBtn.TextScaled = true
tpBtn.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0.15,0)
status.Position = UDim2.new(0,0,0.75,0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Text = "Status: Idle"
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

-- Logic variables
local enabled = false
local hasBrainrot = false
local targetName = "Brainrot"
local pickupRange = 10
local remote = game.ReplicatedStorage:FindFirstChild("BrainrotPickup")

-- Auto Pickup Toggle
autoBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    autoBtn.Text = enabled and "Disable Auto Pickup" or "Enable Auto Pickup"
    status.Text = enabled and "Status: Auto Pickup Enabled" or "Status: Idle"
end)

-- Teleport Button
tpBtn.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local base = workspace:FindFirstChild(player.Name.."_Base")
    if root and base and base:FindFirstChild("SpawnPoint") then
        root.CFrame = base.SpawnPoint.CFrame + Vector3.new(0,3,0)
        status.Text = "Status: Teleported to Base"
    else
        status.Text = "Status: Base not found"
    end
end)

-- Auto Pickup Loop (runs separately)
task.spawn(function()
    while task.wait(0.1) do
        if enabled then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local item = workspace:FindFirstChild(targetName)
            if root and item then
                if (root.Position - item.Position).Magnitude <= pickupRange then
                    if remote then remote:FireServer() end
                    item.Transparency = 1
                    item.CanCollide = false
                    status.Text = "Status: Brainrot Picked Up!"
                    hasBrainrot = true
                end
            end
        end
    end
end)
