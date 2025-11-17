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

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Jezzotrades Instant Steal"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0.15,0)
status.Position = UDim2.new(0,0,0.75,0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Text = "Status: Idle"
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0.9,0,0.2,0)
autoBtn.Position = UDim2.new(0.05,0,0.5,0)
autoBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
autoBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoBtn.Text = "Enable Auto Steal & Teleport"
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextScaled = true
autoBtn.Parent = frame

-- Logic Variables
local enabled = false
local hasBrainrot = false

-- Auto Steal + Teleport
autoBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    autoBtn.Text = enabled and "Disable Auto Steal & Teleport" or "Enable Auto Steal & Teleport"
    status.Text = enabled and "Status: Auto Steal Enabled" or "Status: Idle"
end)

-- Utility function to find Brainrot anywhere in workspace
local function findBrainrot()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():match("brainrot") and obj:IsA("BasePart") then
            return obj
        end
    end
    return nil
end

-- Utility function to find your Base
local function findBase()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():match(player.Name:lower()) and obj:IsA("Model") then
            return obj
        end
    end
    return nil
end

-- Auto Pickup Loop
task.spawn(function()
    while task.wait(0.1) do
        if enabled and not hasBrainrot then
            local brainrot = findBrainrot()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if brainrot and root then
                -- Move player close to brainrot
                root.CFrame = CFrame.new(brainrot.Position + Vector3.new(0,3,0))
                task.wait(0.05)
                -- Simulate pickup
                if game.ReplicatedStorage:FindFirstChild("BrainrotPickup") then
                    game.ReplicatedStorage.BrainrotPickup:FireServer()
                end
                brainrot.Transparency = 1
                brainrot.CanCollide = false
                hasBrainrot = true
                status.Text = "Status: Brainrot Picked Up!"
            end
        elseif hasBrainrot then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local base = findBase()
            if root and base and base:FindFirstChild("SpawnPoint") then
                root.CFrame = base.SpawnPoint.CFrame + Vector3.new(0,3,0)
                status.Text = "Status: Teleported With Brainrot!"
                hasBrainrot = false -- reset to allow multiple runs
            end
        end
    end
end)
