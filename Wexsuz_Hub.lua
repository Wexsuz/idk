local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

StarterGui:SetCore("SendNotification", {
    Title = "✅ Anti AFK GUI",
    Text = "Script Loaded Successfully!",
    Duration = 5
})

local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "AntiAFK_GUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 130)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local TitleBar = Instance.new("TextLabel", Frame)
TitleBar.Size = UDim2.new(1, -60, 0, 25)
TitleBar.Position = UDim2.new(0, 5, 0, 5)
TitleBar.Text = "AntiAfk 1.0 by Wexsuz"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.BackgroundTransparency = 1
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.TextSize = 16
TitleBar.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeButton = Instance.new("TextButton", Frame)
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -55, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 18

local CloseButton = Instance.new("TextButton", Frame)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Text = "x"
CloseButton.BackgroundColor3 = Color3.fromRGB(120, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18

local StatusLabel = Instance.new("TextLabel", Frame)
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 35)
StatusLabel.Text = "Anti AFK: OFF"
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextSize = 20

local ToggleButton = Instance.new("TextButton", Frame)
ToggleButton.Size = UDim2.new(1, -20, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 70)
ToggleButton.Text = "Toggle Anti AFK"
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.TextSize = 16

local MinimizedBar = Instance.new("Frame")
MinimizedBar.Size = UDim2.new(0, 200, 0, 30)
MinimizedBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizedBar.BorderSizePixel = 0
MinimizedBar.Active = true
MinimizedBar.Draggable = true
MinimizedBar.Visible = false
MinimizedBar.Parent = ScreenGui

local BarLabel = Instance.new("TextLabel", MinimizedBar)
BarLabel.Size = UDim2.new(1, -60, 1, 0)
BarLabel.Position = UDim2.new(0, 5, 0, 0)
BarLabel.Text = "AntiAfk 1.0 by Wexsuz"
BarLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BarLabel.BackgroundTransparency = 1
BarLabel.Font = Enum.Font.SourceSansBold
BarLabel.TextSize = 14
BarLabel.TextXAlignment = Enum.TextXAlignment.Left

local ExpandButton = Instance.new("TextButton", MinimizedBar)
ExpandButton.Size = UDim2.new(0, 25, 1, 0)
ExpandButton.Position = UDim2.new(1, -55, 0, 0)
ExpandButton.Text = "+"
ExpandButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
ExpandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExpandButton.Font = Enum.Font.SourceSansBold
ExpandButton.TextSize = 18

local BarCloseButton = Instance.new("TextButton", MinimizedBar)
BarCloseButton.Size = UDim2.new(0, 25, 1, 0)
BarCloseButton.Position = UDim2.new(1, -30, 0, 0)
BarCloseButton.Text = "x"
BarCloseButton.BackgroundColor3 = Color3.fromRGB(120, 50, 50)
BarCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BarCloseButton.Font = Enum.Font.SourceSansBold
BarCloseButton.TextSize = 18

local antiAFK = false
local connection

ToggleButton.MouseButton1Click:Connect(function()
    if antiAFK then
        if connection then connection:Disconnect() end
        antiAFK = false
        StatusLabel.Text = "Anti AFK: OFF"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    else
        connection = player.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
        end)
        antiAFK = true
        StatusLabel.Text = "Anti AFK: ON"
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
    end
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MinimizedBar.Position = Frame.Position
    MinimizedBar.Visible = true
    Frame.Visible = false
end)

ExpandButton.MouseButton1Click:Connect(function()
    Frame.Position = MinimizedBar.Position
    Frame.Visible = true
    MinimizedBar.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    if connection then connection:Disconnect() end
    ScreenGui:Destroy()
    StarterGui:SetCore("SendNotification", {
        Title = "Anti AFK GUI",
        Text = "Script closed, Goodbye.",
        Duration = 3
    })
end)

BarCloseButton.MouseButton1Click:Connect(function()
    if connection then connection:Disconnect() end
    ScreenGui:Destroy()
    StarterGui:SetCore("SendNotification", {
        Title = "Anti AFK GUI",
        Text = "Script closed, Goodbye.",
        Duration = 3
    })
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
        Frame.Visible = not Frame.Visible
        MinimizedBar.Visible = false
    end
end)
