local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,220,0,300)
frame.Position = UDim2.new(0.4,0,0.2,0)
frame.BackgroundTransparency = 0.2

local layout = Instance.new("UIListLayout")
layout.Parent = frame

-- ドラッグ
local dragging = false
local dragInput
local dragStart
local startPos

frame.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if input == dragInput and dragging then

        local delta = input.Position - dragStart

        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

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
    weld.Name = "CarryWeld"
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
