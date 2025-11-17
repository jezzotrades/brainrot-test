-- Delta GUI
local player = game:GetService("Players").LocalPlayer
local pg = player:WaitForChild("PlayerGui")

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
autoBtn.Text = "Enable Instant Teleport with Brainrot"
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextScaled = true
autoBtn.Parent = frame

-- Variables
local enabled = false

autoBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    autoBtn.Text = enabled and "Disable Instant Teleport" or "Enable Instant Teleport"
    status.Text = enabled and "Status: Waiting for Brainrot..." or "Status: Idle"
end)

-- Detect if player is holding the Brainrot
task.spawn(function()
    while task.wait(0.1) do
        if enabled then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local backpack = player:FindFirstChild("Backpack") -- optional check if Brainrot goes there
            local brainrot = workspace:FindFirstChild("Brainrot") -- adjust path if needed

            -- Check if player is carrying Brainrot (this may vary by game implementation)
            local holding = false
            if brainrot and root then
                if (root.Position - brainrot.Position).Magnitude < 5 then
                    holding = true
                end
            end

            if holding and root then
                -- Find player's base
                local base
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name:lower():match(player.Name:lower()) and obj:IsA("Model") then
                        base = obj
                        break
                    end
                end

                if base and base:FindFirstChild("SpawnPoint") then
                    root.CFrame = base.SpawnPoint.CFrame + Vector3.new(0,3,0)
                    if brainrot then
                        brainrot.CFrame = root.CFrame + Vector3.new(0,3,0) -- move brainrot with player
                    end
                    status.Text = "Status: Brainrot Teleported to Base!"
                    task.wait(0.5) -- small delay to avoid repeat teleport
                else
                    status.Text = "Status: Base not found!"
                end
            end
        end
    end
end)
