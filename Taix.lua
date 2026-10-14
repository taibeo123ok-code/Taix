
-- TAI X | PURPLE NEON
local P = game:GetService("Players").LocalPlayer
local U = game:GetService("UserInputService")
local G = Instance.new("ScreenGui")
G.Name = "TaiX"
G.ResetOnSpawn = false
G.Parent = P:WaitForChild("PlayerGui")

local F = Instance.new("Frame", G)
F.Size = UDim2.fromOffset(235, 330)
F.Position = UDim2.new(.5, -117, .3, 0)
F.BackgroundColor3 = Color3.fromRGB(25, 10, 40)
F.BorderSizePixel = 0
Instance.new("UICorner", F).CornerRadius = UDim.new(0, 12)

local S = Instance.new("UIStroke", F)
S.Color = Color3.fromRGB(180, 60, 255)
S.Thickness = 2

local T = Instance.new("TextLabel", F)
T.Size = UDim2.new(1, 0, 0, 45)
T.BackgroundTransparency = 1
T.Text = "TAI X | EGG"
T.TextColor3 = Color3.fromRGB(220, 160, 255)
T.Font = Enum.Font.GothamBold
T.TextSize = 20

local status = Instance.new("TextLabel", F)
status.Position = UDim2.fromOffset(5, 40)
status.Size = UDim2.new(1, -10, 0, 24)
status.BackgroundTransparency = 1
status.Text = "Ready"
status.TextColor3 = Color3.new(1, 1, 1)
status.TextSize = 12

local names = {
    "Auto Treadmill",
    "Fast Steal Egg",
    "Anti Hit",
    "Anti Trap",
    "Anti Ban (Demo)",
    "Reduce GUI Effects"
}

local state = {}

for i, name in ipairs(names) do
    local B = Instance.new("TextButton", F)
    B.Size = UDim2.new(1, -20, 0, 34)
    B.Position = UDim2.fromOffset(10, 67 + (i-1)*38)
    B.BackgroundColor3 = Color3.fromRGB(55, 25, 80)
    B.TextColor3 = Color3.new(1, 1, 1)
    B.Font = Enum.Font.GothamSemibold
    B.TextSize = 12
    B.Text = name .. " : OFF"
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)

    state[name] = false

    B.Activated:Connect(function()
        state[name] = not state[name]
        B.Text = name .. (state[name] and " : ON" or " : OFF")
        B.BackgroundColor3 = state[name]
            and Color3.fromRGB(130, 45, 190)
            or Color3.fromRGB(55, 25, 80)

        if name == "Reduce GUI Effects" then
            S.Thickness = state[name] and 1 or 2
            F.BackgroundTransparency = state[name] and .15 or 0
        end

        status.Text = name .. (state[name] and " ON" or " OFF")
    end)
end

-- Keo tha bang thanh tieu de
local dragging, start, origin

T.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        start = input.Position
        origin = F.Position
    end
end)

U.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = input.Position - start
        F.Position = UDim2.new(
            origin.X.Scale, origin.X.Offset + d.X,
            origin.Y.Scale, origin.Y.Offset + d.Y
        )
    end
end)

U.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
