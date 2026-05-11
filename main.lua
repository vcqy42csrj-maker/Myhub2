local Players = game:GetService("Players")

local function carryPlayer(carrier, target)

    local char1 = carrier.Character
    local char2 = target.Character

    if not char1 or not char2 then return end

    local torso = char1:FindFirstChild("Torso")
    local hrp2 = char2:FindFirstChild("HumanoidRootPart")

    if not torso or not hrp2 then return end

    -- 位置
    hrp2.CFrame = torso.CFrame * CFrame.new(0,2,0)

    -- 固定
    local weld = Instance.new("WeldConstraint")
    weld.Name = "CarryWeld"
    weld.Part0 = torso
    weld.Part1 = hrp2
    weld.Parent = torso
end

Players.PlayerAdded:Connect(function(player)

    player.Chatted:Connect(function(msg)

        local split = msg:split(" ")

        if split[1] == "/carry" then

            local target = Players:FindFirstChild(split[2])

            if target then
                carryPlayer(player, target)
            end
        end
    end)
end)
