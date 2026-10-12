--[[ 
    KVIL HUB [ Made by Rebzyyx ] - Versión Completa
]]--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer

-- Obtención Ultra Segura del contenedor GUI compatible con Delta
local parentGui = (gethui and gethui()) or (game:GetService("CoreGui") and pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui")) or player:WaitForChild("PlayerGui", 5)

if parentGui:FindFirstChild("KvilHubGui") then
    parentGui.KvilHubGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KvilHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

-- Ventana Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 340)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(50, 50, 65)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
Header.BackgroundTransparency = 0.2
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 10)
HeaderFix.Position = UDim2.new(0, 0, 1, -10)
HeaderFix.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
HeaderFix.BackgroundTransparency = 0.2
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Position = UDim2.new(0, 8, 0.5, -11)
CloseBtn.BackgroundColor3 = Color3.fromRGB(235, 65, 65)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 15
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 22, 0, 22)
MinBtn.Position = UDim2.new(1, -30, 0.5, -11)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 18
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 300, 1, 0)
TitleLabel.Position = UDim2.new(0, 38, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "KVIL HUB [ Made by Rebzyyx ]  -- activos"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
TitleLabel.TextSize = 11
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

-- Círculo DKV
local DKVCircle = Instance.new("TextButton")
DKVCircle.Name = "DKVCircle"
DKVCircle.Size = UDim2.new(0, 52, 0, 52)
DKVCircle.Position = UDim2.new(0, 20, 0.5, -26)
DKVCircle.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
DKVCircle.BackgroundTransparency = 0.1
DKVCircle.Text = "DKV"
DKVCircle.TextColor3 = Color3.fromRGB(180, 150, 255)
DKVCircle.TextSize = 14
DKVCircle.Font = Enum.Font.GothamBold
DKVCircle.Visible = false
DKVCircle.Parent = ScreenGui

local DKVCorner = Instance.new("UICorner")
DKVCorner.CornerRadius = UDim.new(1, 0)
DKVCorner.Parent = DKVCircle

local DKVStroke = Instance.new("UIStroke")
DKVStroke.Color = Color3.fromRGB(120, 80, 255)
DKVStroke.Thickness = 2
DKVStroke.Parent = DKVCircle

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local CatLabel = Instance.new("TextLabel")
CatLabel.Size = UDim2.new(1, -16, 0, 22)
CatLabel.Position = UDim2.new(0, 12, 0, 8)
CatLabel.BackgroundTransparency = 1
CatLabel.Text = "PRINCIPAL"
CatLabel.TextColor3 = Color3.fromRGB(90, 90, 105)
CatLabel.TextSize = 10
CatLabel.Font = Enum.Font.GothamBold
CatLabel.TextXAlignment = Enum.TextXAlignment.Left
CatLabel.Parent = Sidebar

local tabs = {"Inicio", "Aimbot", "Macro", "Visuales", "Movimiento", "AutoFarm", "Gráficos"}
local tabButtons = {}

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -160, 1, -38)
Content.Position = UDim2.new(0, 160,
  
