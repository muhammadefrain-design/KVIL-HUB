--[[ 
    KVIL HUB [ Made by Rebzyyx ] - Delta Mobile Fix (v2 - Features Integradas)
]]--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Obtención segura del contenedor GUI
local parentGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)
if gethui then
    parentGui = gethui()
elseif game:GetService("CoreGui") then
    pcall(function() parentGui = game:GetService("CoreGui") end)
end

if parentGui:FindFirstChild("KvilHubGui") then
    parentGui.KvilHubGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KvilHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

-- =========================================
-- ESTADOS Y VARIABLES DE LAS FEATURES
-- =========================================
local autoShoot = false
local autoKnife = false
local autoKill = false
local macroClick = false
local silentAim = false
local silentBtnEnabled = true
local fixBtnEnabled = false
local espRainbow = false
local speedHack = false
local customSpeed = 50
local defaultWalkSpeed = 16

-- =========================================
-- ESTRUCTURA PRINCIPAL DE LA GUI
-- =========================================
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

-- Botón Cerrar
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

-- Botón Minimizar (-)
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

-- Círculo DKV (Minimizado)
local DKVCircle = Instance.new("TextButton")
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
Content.Position = UDim2.new(0, 160, 0, 38)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local pages = {}
local function createPage(name)
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = Content
    pages[name] = page
    return page
end

local function selectTab(name)
    for _, tName in ipairs(tabs) do
        pages[tName].Visible = (tName == name)
        local btn = tabButtons[tName]
        local selected = (tName == name)
        btn.BackgroundColor3 = selected and Color3.fromRGB(32, 32, 42) or Color3.fromRGB(0, 0, 0)
        btn.BackgroundTransparency = selected and 0.2 or 1
        btn.TextColor3 = selected and Color3.fromRGB(240, 240, 250) or Color3.fromRGB(150, 150, 165)
        btn.Font = selected and Enum.Font.GothamBold or Enum.Font.Gotham
        btn.Text = (selected and "  ▎ " or "   ") .. tName
    end
end

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -14, 0, 30)
    btn.Position = UDim2.new(0, 7, 0, 30 + (i * 33))
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = "   " .. name
    btn.TextColor3 = Color3.fromRGB(150, 150, 165)
    btn.TextSize = 12
    btn.Font = Enum.Font.Gotham
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    tabButtons[name] = btn
    createPage(name)

    btn.MouseButton1Click:Connect(function()
        selectTab(name)
    end)
end

-- FUNCIONES DE COMPONENTES DE UI
local function addTitle(page, text)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -30, 0, 32)
    t.Position = UDim2.new(0, 18, 0, 10)
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = Color3.fromRGB(245, 245, 250)
    t.TextSize = 18
    t.Font = Enum.Font.GothamBold
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = page
end

local function addToggle(page, position, text, initialState, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -40, 0, 40)
    card.Position = position
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    card.BackgroundTransparency = 0.4
    card.BorderSizePixel = 0
    card.Parent = page

    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 8)
    cc.Parent = card

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(215, 215, 225)
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    local state = initialState or false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 44, 0, 20)
    btn.Position = UDim2.new(1, -58, 0.5, -10)
    btn.BackgroundColor3 = state and Color3.fromRGB(120, 80, 255) or Color3.fromRGB(45, 45, 55)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 170)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Parent = card

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 10)
    bc.Parent = btn

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(120, 80, 255) or Color3.fromRGB(45, 45, 55)
        btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 170)
        if callback then callback(state) end
    end)
    return btn
end

local function addInput(page, position, text, defaultVal, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -40, 0, 40)
    card.Position = position
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    card.BackgroundTransparency = 0.4
    card.BorderSizePixel = 0
    card.Parent = page

    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 8)
    cc.Parent = card

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -120, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(215, 215, 225)
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 80, 0, 24)
    box.Position = UDim2.new(1, -95, 0.5, -12)
    box.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 11
    box.Font = Enum.Font.GothamBold
    box.Text = tostring(defaultVal)
    box.Parent = card

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 6)
    bc.Parent = box

    box.FocusLost:Connect(function()
        if callback then callback(box.Text) end
    end)
    return box
end

local function addInfo(page, position, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 0, 60)
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(140, 140, 155)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.TextWrapped = true
    label.Parent = page
end

-- =========================================
-- BOTÓN FLOTANTE MÓVIL 🎯
-- =========================================
local MobileShootBtn = Instance.new("TextButton")
MobileShootBtn.Name = "MobileShootBtn"
MobileShootBtn.Size = UDim2.new(0, 50, 0, 50)
MobileShootBtn.Position = UDim2.new(0.82, 0, 0.45, 0)
MobileShootBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
MobileShootBtn.BackgroundTransparency = 0.2
MobileShootBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MobileShootBtn.Text = "🎯"
MobileShootBtn.TextSize = 22
MobileShootBtn.Visible = silentBtnEnabled
MobileShootBtn.Parent = ScreenGui

local MobileBtnCorner = Instance.new("UICorner")
MobileBtnCorner.CornerRadius = UDim.new(1, 0)
MobileBtnCorner.Parent = MobileShootBtn

local MobileBtnStroke = Instance.new("UIStroke")
MobileBtnStroke.Color = Color3.fromRGB(180, 150, 255)
MobileBtnStroke.Thickness = 1.5
MobileBtnStroke.Parent = MobileShootBtn

-- Arrastre del Botón 🎯
local btnDragging, btnDragStart, startPosBtn
MobileShootBtn.InputBegan:Connect(function(input)
    if not fixBtnEnabled and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        btnDragging = true
        btnDragStart = input.Position
        startPosBtn = MobileShootBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if btnDragging and not fixBtnEnabled and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - btnDragStart
        MobileShootBtn.Position = UDim2.new(startPosBtn.X.Scale, startPosBtn.X.Offset + delta.X, startPosBtn.Y.Scale, startPosBtn.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        btnDragging = false
    end
end)

-- =========================================
-- CONTENIDO DE LAS PESTAÑAS (NUEVA INTERFAZ)
-- =========================================

-- PESTAÑA INICIO
addTitle(pages["Inicio"], "Inicio")
addInfo(pages["Inicio"], UDim2.new(0, 18, 0, 50),
    "Bienvenido a KVIL HUB.\n\nUsa el panel lateral para navegar entre funciones.\nBotón '-' para minimizar a la bola flotante DKV, '×' para cerrar.")

-- PESTAÑA AIMBOT
addTitle(pages["Aimbot"], "Aimbot & Combate")
addToggle(pages["Aimbot"], UDim2.new(0, 18, 0, 50), "Silent-Aim", silentAim, function(s) silentAim = s end)
addToggle(pages["Aimbot"], UDim2.new(0, 18, 0, 98), "Auto-Shoot", autoShoot, function(s) autoShoot = s end)
addToggle(pages["Aimbot"], UDim2.new(0, 18, 0, 146), "Auto-Knife", autoKnife, function(s) autoKnife = s end)
addToggle(pages["Aimbot"], UDim2.new(0, 18, 0, 194), "Mostrar Botón Silent Aim (🎯)", silentBtnEnabled, function(s)
    silentBtnEnabled = s
    MobileShootBtn.Visible = s
end)
addToggle(pages["Aimbot"], UDim2.new(0, 18, 0, 242), "Fijar Botón 🎯 (Desactivar Drag)", fixBtnEnabled, function(s) fixBtnEnabled = s end)

-- PESTAÑA MACRO
addTitle(pages["Macro"], "Macro")
addToggle(pages["Macro"], UDim2.new(0, 18, 0, 50), "Macro Click (Auto-Equip Disparo)", macroClick, function(s) macroClick = s end)

-- PESTAÑA VISUALES
addTitle(pages["Visuales"], "Visuales")
addToggle(pages["Visuales"], UDim2.new(0, 18, 0, 50), "ESP Rainbow (Enemigos)", espRainbow, function(s) espRainbow = s end)

-- PESTAÑA MOVIMIENTO
addTitle(pages["Movimiento"], "Movimiento")
addToggle(pages["Movimiento"], UDim2.new(0, 18, 0, 50), "WalkSpeed Activado", speedHack, function(s) speedHack = s end)
addInput(pages["Movimiento"], UDim2.new(0, 18, 0, 98), "Velocidad WalkSpeed", customSpeed, function(val)
    local num = tonumber(val)
    if num then customSpeed = num end
end)

-- PESTAÑA AUTOFARM
addTitle(pages["AutoFarm"], "AutoFarm")
addToggle(pages["AutoFarm"], UDim2.new(0, 18, 0, 50), "Auto-Kill (Teleport + Knife)", autoKill, function(s) autoKill = s end)

-- PESTAÑA GRÁFICOS
addTitle(pages["Gráficos"], "Gráficos")
addInfo(pages["Gráficos"], UDim2.new(0, 18, 0, 50), "Ajustes gráficos para un mejor rendimiento.")

selectTab("Inicio")

-- =========================================
-- MINIMIZAR / RESTAURAR / ARRASTRE KVIL
-- =========================================
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    DKVCircle.Visible = true
end)

local function makeDraggable(guiObject, handle)
    handle = handle or guiObject
    local dragging, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(MainFrame, Header)

-- Bola flotante DKV (minimizado)
local movedDKV = false
local draggingDKV = false
local dragStartDKV, startPosDKV

DKVCircle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingDKV = true
        movedDKV = false
        dragStartDKV = input.Position
        startPosDKV = DKVCircle.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingDKV = false
            end
        end)
    end
end)

DKVCircle.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) and draggingDKV then
        local delta = input.Position - dragStartDKV
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            movedDKV = true
        end
        DKVCircle.Position = UDim2.new(
            startPosDKV.X.Scale, startPosDKV.X.Offset + delta.X,
            startPosDKV.Y.Scale, startPosDKV.Y.Offset + delta.Y
        )
    end
end)

DKVCircle.MouseButton1Click:Connect(function()
    if not movedDKV then
        DKVCircle.Visible = false
        MainFrame.Visible = true
    end
end)

-- =========================================
-- LÓGICA CORE DE LAS FEATURES
-- =========================================

local function isEnemy(player)
    if not player or player == LocalPlayer then return false end
    if LocalPlayer.Team ~= nil and player.Team ~= nil then
        return LocalPlayer.Team ~= player.Team
    end
    return true
end

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true

local primaryParts = {"UpperTorso", "HumanoidRootPart", "Torso"}
local secondaryParts = {"Head", "RightLowerArm", "LeftLowerArm", "RightLowerLeg", "LeftLowerLeg", "RightHand", "LeftHand", "RightFoot", "LeftFoot"}

local function getVisibleTarget()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local originPos = char.HumanoidRootPart.Position + Vector3.new(0, 0.5, 0)
    local bestPart = nil
    local bestDist = math.huge

    for _, p in ipairs(Players:GetPlayers()) do
        if isEnemy(p) and p.Character then
            local eChar = p.Character
            local eHum = eChar:FindFirstChildOfClass("Humanoid")
            if eHum and eHum.Health > 0 then
                local eRoot = eChar:FindFirstChild("HumanoidRootPart")
                if eRoot then
                    local dist = (eRoot.Position - originPos).Magnitude
                    if dist < bestDist then
                        rayParams.FilterDescendantsInstances = {char, eChar}
                        
                        local foundPrimary = nil
                        for _, pName in ipairs(primaryParts) do
                            local part = eChar:FindFirstChild(pName)
                            if part then
                                local hit = workspace:Raycast(originPos, part.Position - originPos, rayParams)
                          
