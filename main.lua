local Players = game:GetService("Players")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,200,0,300)
frame.Position = UDim2.new(0.4,0,0.2,0)

local layout = Instance.new("UIListLayout")
layout.Parent = frame

-- 肩車
local function carry(target)

    local char1 = player.Character
    local char2 = target.Character

    if not char1 or not char2 then return end

    local torso = char1:FindFirstChild("Torso")
    local hrp2 = char2:FindFirstChild("HumanoidRootPart")

    if not torso or not hrp2 then return end

    hrp2.CFrame = torso.CFrame * CFrame.new(0,2,0)

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = torso
    weld.Part1 = hrp2
    weld.Parent = torso
end

-- プレイヤーボタン
local function createButton(plr)

    if plr == player then return end

    local button = Instance.new("TextButton")
    button.Parent = frame
    button.Size = UDim2.new(1,0,0,40)
    button.Text = plr.Name

    button.MouseButton1Click:Connect(function()
        carry(plr)
    end)
end

for _,plr in pairs(Players:GetPlayers()) do
    createButton(plr)
end

Players.PlayerAdded:Connect(createButton)
