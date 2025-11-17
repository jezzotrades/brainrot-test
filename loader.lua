local player = game.Players.LocalPlayer

-- Wait for character and PlayerGui
player.CharacterAdded:Wait()
local char = player.Character
local root = char:WaitForChild("HumanoidRootPart")
local pg = player:WaitForChild("PlayerGui")
task.wait(0.3) -- ensure GUI can be added safely

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotHubGUI"
gui.ResetOnSpawn = false
gui.Parent = pg

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui
frame.Active = true
frame.Draggable = true

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

local teleportWithBtn = Instance.new("TextButton")
teleportWithBtn.Size = UDim2.new(0.9,0,0.2,0)
teleportWithBtn.Position = UDim2.new(0.05,0,0.5,0)
teleportWithBtn.BackgroundColor3 = Color3.fromRGB(50,120,50)
teleportWithBtn.TextColor3 = Color3.fromRGB(255,255,255)
teleportWithBtn.Text = "Teleport With Brainrot"
teleportWithBtn.Font = Enum.Font.Gotham
teleportWithBtn.TextScaled = true
teleportWithBtn.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0.15,0)
status.Position = UDim2.new(0,0,0.75,0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Text = "Status: Idle"
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

-- Logic Variables
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

-- Teleport to Base
tpBtn.MouseButton1Click:Connect(function()
    local base = workspace:FindFirstChild(player.Name.."_Base")
    if base and base:FindFirstChild("SpawnPoint") then
        root.CFrame = base.SpawnPoint.CFrame + Vector3.new(0,3,0)
        status.Text = "Status: Teleported to Base"
    else
        status.Text = "Status: Base not found"
    end
end)

-- Teleport With Brainrot
teleportWithBtn.MouseButton1Click:Connect(function()
    if hasBrainrot then
        local base = workspace:FindFirstChild(player.Name.."_Base")
        if base and base:FindFirstChild("SpawnPoint") then
            root.CFrame = base.SpawnPoint.CFrame + Vector3.new(0,3,0)
            status.Text = "Status: Teleported With Brainrot!"
        else
            status.Text = "Status: Base not found"
        end
    else
        status.Text = "Status: You don't have the Brainrot!"
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
                    item
