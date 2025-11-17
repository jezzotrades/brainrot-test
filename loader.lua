-- Full GUI Hub for Brainrot Test
local player = game.Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

-- Main ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotHubGUI"
gui.ResetOnSpawn = false
gui.Parent = pg

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 200)
frame.Position = UDim2.new(0.5, -175, 0.5, -100)
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
autoBtn.Size = UDim2.new(0,150,0,50)
autoBtn.Position = UDim2.new(0,20,0,60)
autoBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
autoBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoBtn.Text = "Enable Auto Pickup"
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextScaled = true
autoBtn.Parent = frame

-- Teleport Button
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0,150,0,50)
tpBtn.Position = UDim2.new(0,180,0,60)
tpBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBtn.Text = "Teleport to Base"
tpBtn.Font = Enum.Font.Gotham
tpBtn.TextScaled = true
tpBtn.Parent = frame

-- Status Label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.new(0,0,1,-30)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Text = "Status: Idle"
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

-- Logic variables
local enabled = false
local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local targetName = "Brainrot"
local pickupRange = 10
local remote = game.ReplicatedStorage:FindFirstChild("BrainrotPickup")

-- Auto Pickup Toggle
autoBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    autoBtn.Text = enabled and "Disable Auto Pickup" or "Enable Auto Pickup"
    status.Text = enabled and "Status: Auto Pickup Enabled" or "Status: Idle"
end)

-- Teleport Button Logic
tpBtn.MouseButton1Click:Connect(function()
    local base = workspace:FindFirstChild(player.Name.."_Base")
    if base and base:FindFirstChild("SpawnPoint") then
        root = player.Character:WaitForChild("HumanoidRootPart")
        root.CFrame = base.SpawnPoint.CFrame + Vector3.new(0,3,0)
        status.Text = "Status: Teleported to Base"
    else
        status.Text = "Status: Base not found"
    end
end)

-- Auto Pickup Loop
task.spawn(function()
    while task.wait(0.1) do
        if enabled then
            root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local item = workspace:FindFirstChild(targetName)
            if item and root then
                if (root.Position - item.Position).Magnitude <= pickupRange then
                    if remote then remote:FireServer() end
                    item.Transparency = 1
                    item.CanCollide = false
                    status.Text = "Status: Brainrot Picked Up!"
                end
            end
        end
    end
end)
