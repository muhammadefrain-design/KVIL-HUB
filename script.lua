-- =========================================
-- PARTE A: CONFIGURACIÓN, GUI Y BARRA SUPERIOR
-- =========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
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

-- Destruir GUI previa si existía
if parentGui:FindFirstChild("UltimateScriptGUI") then
	parentGui.UltimateScriptGUI:Destroy()
end

-- ESTADOS Y VARIABLES
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
local fovSize = 120
local showFovCircle = false

-- INTERFAZ GRÁFICA (KVIL HUB - MODERN DARK)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateScriptGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

-- VENTANA PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Color = Color3.fromRGB(40, 40, 50)
UIStrokeMain.Parent = MainFrame

-- BARRA SUPERIOR (TOPBAR)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TopBar.BackgroundTransparency = 0.2
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local UICornerTop = Instance.new("UICorner")
UICornerTop.CornerRadius = UDim.new(0, 10)
UICornerTop.Parent = TopBar

local TopTitle = Instance.new("TextLabel")
TopTitle.Size = UDim2.new(0, 200, 1, 0)
TopTitle.Position = UDim2.new(0, 15, 0, 0)
TopTitle.BackgroundTransparency = 1
TopTitle.Text = "KVIL HUB"
TopTitle.TextColor3 = Color3.fromRGB(0, 255, 135)
TopTitle.TextSize = 13
TopTitle.Font = Enum.Font.GothamBold
TopTitle.TextXAlignment = Enum.TextXAlignment.Left
TopTitle.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TopBar

local UICornerMin = Instance.new("UICorner")
UICornerMin.CornerRadius = UDim.new(0, 6)
UICornerMin.Parent = MinimizeBtn

-- SIDEBAR (PANEL LATERAL IZQUIERDO)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 130, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local CategoryHeader = Instance.new("TextLabel")
CategoryHeader.Size = UDim2.new(1, -16, 0, 20)
CategoryHeader.Position = UDim2.new(0, 12, 0, 8)
CategoryHeader.BackgroundTransparency = 1
CategoryHeader.Text = "PRINCIPAL"
CategoryHeader.TextColor3 = Color3.fromRGB(100, 100, 115)
CategoryHeader.TextSize = 9
CategoryHeader.Font = Enum.Font.GothamBold
CategoryHeader.TextXAlignment = Enum.TextXAlignment.Left
CategoryHeader.Parent = Sidebar

-- ÁREA DE CONTENIDO PRINCIPAL
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -130, 1, -36)
ContentArea.Position = UDim2.new(0, 130, 0, 36)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local ContentTitle = Instance.new("TextLabel")
ContentTitle.Size = UDim2.new(1, -20, 0, 25)
ContentTitle.Position = UDim2.new(0, 15, 0, 10)
ContentTitle.BackgroundTransparency = 1
ContentTitle.Text = "Aimbot"
ContentTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ContentTitle.TextSize = 16
ContentTitle.Font = Enum.Font.GothamBold
ContentTitle.TextXAlignment = Enum.TextXAlignment.Left
ContentTitle.Parent = ContentArea

-- =========================================
-- PARTE B: CONTENEDORES Y PESTAÑAS (INICIO, AIMBOT, MACRO)
-- =========================================

local TabFrames = {}

local function createTabContainer(name)
	local frame = Instance.new("ScrollingFrame")
	frame.Name = name .. "Frame"
	frame.Size = UDim2.new(1, 0, 1, -35)
	frame.Position = UDim2.new(0, 0, 0, 35)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.CanvasSize = UDim2.new(0, 0, 0, 250)
	frame.ScrollBarThickness = 3
	frame.Visible = false
	frame.Parent = ContentArea
	TabFrames[name] = frame
	return frame
end

local function createToggleBtnInParent(parent, name, posX, posY, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 110, 0, 24)
	btn.Position = UDim2.new(0, posX, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 9
	btn.Font = Enum.Font.GothamBold
	btn.Text = name .. ": OFF"
	btn.Parent = parent

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 5)
	c.Parent = btn

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = name .. ": " .. (state and "ON" or "OFF")
		btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 95) or Color3.fromRGB(30, 30, 40)
		btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
		callback(state)
	end)
	return btn
end

-- 1. PESTAÑA: Inicio
local fInicio = createTabContainer("Inicio")
local lblInicio = Instance.new("TextLabel")
lblInicio.Size = UDim2.new(1, -30, 0, 100)
lblInicio.Position = UDim2.new(0, 15, 0, 10)
lblInicio.BackgroundTransparency = 1
lblInicio.Text = "¡Bienvenido! Gracias por usar KVIL HUB\n\nJugador: " .. LocalPlayer.Name
lblInicio.TextColor3 = Color3.fromRGB(200, 200, 210)
lblInicio.TextSize = 12
lblInicio.Font = Enum.Font.GothamBold
lblInicio.TextXAlignment = Enum.TextXAlignment.Left
lblInicio.TextYAlignment = Enum.TextYAlignment.Top
lblInicio.TextWrapped = true
lblInicio.Parent = fInicio

-- 2. PESTAÑA: Aimbot
local fAimbot = createTabContainer("Aimbot")
fAimbot.Visible = true

local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, -30, 0, 26)
ToggleFrame.Position = UDim2.new(0, 15, 0, 5)
ToggleFrame.BackgroundTransparency = 1
ToggleFrame.Parent = fAimbot

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Activar Silent-Aim (FOV)"
ToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
ToggleLabel.TextSize = 11
ToggleLabel.Font = Enum.Font.Gotham
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleFrame

local SwitchBtn = Instance.new("TextButton")
SwitchBtn.Size = UDim2.new(0, 36, 0, 18)
SwitchBtn.Position = UDim2.new(1, -36, 0.5, -9)
SwitchBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SwitchBtn.Text = ""
SwitchBtn.Parent = ToggleFrame

local UICornerSwitch = Instance.new("UICorner")
UICornerSwitch.CornerRadius = UDim.new(1, 0)
UICornerSwitch.Parent = SwitchBtn

local SwitchDot = Instance.new("Frame")
SwitchDot.Size = UDim2.new(0, 14, 0, 14)
SwitchDot.Position = UDim2.new(0, 2, 0.5, -7)
SwitchDot.BackgroundColor3 = Color3.fromRGB(120, 120, 130)
SwitchDot.Parent = SwitchBtn

local UICornerDot = Instance.new("UICorner")
UICornerDot.CornerRadius = UDim.new(1, 0)
UICornerDot.Parent = SwitchDot

SwitchBtn.MouseButton1Click:Connect(function()
	silentAim = not silentAim
	if silentAim then
		SwitchBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 95)
		SwitchDot.Position = UDim2.new(1, -16, 0.5, -7)
		SwitchDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	else
		SwitchBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
		SwitchDot.Position = UDim2.new(0, 2, 0.5, -7)
		SwitchDot.BackgroundColor3 = Color3.fromRGB(120, 120, 130)
	end
end)

local SectionLabel = Instance.new("TextLabel")
SectionLabel.Size = UDim2.new(1, -30, 0, 20)
SectionLabel.Position = UDim2.new(0, 15, 0, 40)
SectionLabel.BackgroundTransparency = 1
SectionLabel.Text = "Campo de visión"
SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SectionLabel.TextSize = 12
SectionLabel.Font = Enum.Font.GothamBold
SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
SectionLabel.Parent = fAimbot

local SliderSubLabel = Instance.new("TextLabel")
SliderSubLabel.Size = UDim2.new(0.5, 0, 0, 18)
SliderSubLabel.Position = UDim2.new(0, 15, 0, 64)
SliderSubLabel.BackgroundTransparency = 1
SliderSubLabel.Text = "Tamaño del FOV"
SliderSubLabel.TextColor3 = Color3.fromRGB(170, 170, 180)
SliderSubLabel.TextSize = 10
SliderSubLabel.Font = Enum.Font.Gotham
SliderSubLabel.TextXAlignment = Enum.TextXAlignment.Left
SliderSubLabel.Parent = fAimbot

local SliderBox = Instance.new("TextBox")
SliderBox.Size = UDim2.new(0, 40, 0, 20)
SliderBox.Position = UDim2.new(1, -55, 0, 62)
SliderBox.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
SliderBox.TextColor3 = Color3.fromRGB(0, 255, 135)
SliderBox.TextSize = 10
SliderBox.Font = Enum.Font.GothamBold
SliderBox.Text = "120"
SliderBox.Parent = fAimbot

local UICornerBox = Instance.new("UICorner")
UICornerBox.CornerRadius = UDim.new(0, 4)
UICornerBox.Parent = SliderBox

SliderBox.FocusLost:Connect(function()
	local num = tonumber(SliderBox.Text)
	if num then
		fovSize = num
	else
		SliderBox.Text = tostring(fovSize)
	end
end)

local SliderTrack = Instance.new("Frame")
SliderTrack.Size = UDim2.new(1, -30, 0, 6)
SliderTrack.Position = UDim2.new(0, 15, 0, 90)
SliderTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SliderTrack.Parent = fAimbot

local UICornerTrack = Instance.new("UICorner")
UICornerTrack.CornerRadius = UDim.new(1, 0)
UICornerTrack.Parent = SliderTrack

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.6, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 135)
SliderFill.Parent = SliderTrack

local UICornerFill = Instance.new("UICorner")
UICornerFill.CornerRadius = UDim.new(1, 0)
UICornerFill.Parent = SliderFill

local QuickActionFrameAimbot = Instance.new("Frame")
QuickActionFrameAimbot.Size = UDim2.new(1, -30, 0, 100)
QuickActionFrameAimbot.Position = UDim2.new(0, 15, 0, 110)
QuickActionFrameAimbot.BackgroundTransparency = 1
QuickActionFrameAimbot.Parent = fAimbot

createToggleBtnInParent(QuickActionFrameAimbot, "AutoShoot", 0, 0, function(st) autoShoot = st end)
createToggleBtnInParent(QuickActionFrameAimbot, "AutoKnife", 120, 0, function(st) autoKnife = st end)
createToggleBtnInParent(QuickActionFrameAimbot, "SilentBtn", 0, 32, function(st) silentBtnEnabled = st; local btn = ScreenGui:FindFirstChild("MobileShootBtn"); if btn then btn.Visible = silentBtnEnabled end end)
createToggleBtnInParent(QuickActionFrameAimbot, "Fijar Botón", 120, 32, function(st) fixBtnEnabled = st end)

-- 3. PESTAÑA: Macro
local fMacro = createTabContainer("Macro")
local QuickActionFrameMacro = Instance.new("Frame")
QuickActionFrameMacro.Size = UDim2.new(1, -30, 0, 100)
QuickActionFrameMacro.Position = UDim2.new(0, 15, 0, 10)
QuickActionFrameMacro.BackgroundTransparency = 1
QuickActionFrameMacro.Parent = fMacro

createToggleBtnInParent(QuickActionFrameMacro, "MacroClick", 0, 0, function(st) macroClick = st end)

-- =========================================
-- PARTE C: PESTAÑAS RESTANTES, SIDEBAR Y BOTONES FLOTANTES
-- =========================================

-- 4. PESTAÑA: Visuales
local fVisuales = createTabContainer("Visuales")
local QuickActionFrameVisuals = Instance.new("Frame")
QuickActionFrameVisuals.Size = UDim2.new(1, -30, 0, 100)
QuickActionFrameVisuals.Position = UDim2.new(0, 15, 0, 10)
QuickActionFrameVisuals.BackgroundTransparency = 1
QuickActionFrameVisuals.Parent = fVisuales

createToggleBtnInParent(QuickActionFrameVisuals, "ESP Rainbow", 0, 0, function(st) espRainbow = st end)

-- 5. PESTAÑA: Movimiento
local fMovimiento = createTabContainer("Movimiento")
local QuickActionFrameMovement = Instance.new("Frame")
QuickActionFrameMovement.Size = UDim2.new(1, -30, 0, 100)
QuickActionFrameMovement.Position = UDim2.new(0, 15, 0, 10)
QuickActionFrameMovement.BackgroundTransparency = 1
QuickActionFrameMovement.Parent = fMovimiento

createToggleBtnInParent(QuickActionFrameMovement, "SpeedHack", 0, 0, function(st) speedHack = st end)

local SpeedSubLabel = Instance.new("TextLabel")
SpeedSubLabel.Size = UDim2.new(0.5, 0, 0, 18)
SpeedSubLabel.Position = UDim2.new(0, 0, 0, 35)
SpeedSubLabel.BackgroundTransparency = 1
SpeedSubLabel.Text = "Velocidad Personalizada"
SpeedSubLabel.TextColor3 = Color3.fromRGB(170, 170, 180)
SpeedSubLabel.TextSize = 10
SpeedSubLabel.Font = Enum.Font.Gotham
SpeedSubLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedSubLabel.Parent = QuickActionFrameMovement

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 50, 0, 22)
SpeedBox.Position = UDim2.new(0, 150, 0, 33)
SpeedBox.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
SpeedBox.TextColor3 = Color3.fromRGB(0, 255, 135)
SpeedBox.TextSize = 10
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.Text = "50"
SpeedBox.Parent = QuickActionFrameMovement

local UICornerSpeedBox = Instance.new("UICorner")
UICornerSpeedBox.CornerRadius = UDim.new(0, 4)
UICornerSpeedBox.Parent = SpeedBox

SpeedBox.FocusLost:Connect(function()
	local num = tonumber(SpeedBox.Text)
	if num then
		customSpeed = num
	else
		SpeedBox.Text = tostring(customSpeed)
	end
end)

-- 6. PESTAÑA: AutoFarm
local fAutoFarm = createTabContainer("AutoFarm")
local QuickActionFrameAutoFarm = Instance.new("Frame")
QuickActionFrameAutoFarm.Size = UDim2.new(1, -30, 0, 100)
QuickActionFrameAutoFarm.Position = UDim2.new(0, 15, 0, 10)
QuickActionFrameAutoFarm.BackgroundTransparency = 1
QuickActionFrameAutoFarm.Parent = fAutoFarm

createToggleBtnInParent(QuickActionFrameAutoFarm, "AutoKill", 0, 0, function(st) autoKill = st end)

-- 7. PESTAÑA: Gráficos
local fGraficos = createTabContainer("Gráficos")
local lblGraficos = Instance.new("TextLabel")
lblGraficos.Size = UDim2.new(1, -30, 0, 50)
lblGraficos.Position = UDim2.new(0, 15, 0, 10)
lblGraficos.BackgroundTransparency = 1
lblGraficos.Text = "Opciones gráficas adicionales y optimización de rendimiento próximamente."
lblGraficos.TextColor3 = Color3.fromRGB(180, 180, 190)
lblGraficos.TextSize = 11
lblGraficos.Font = Enum.Font.Gotham
lblGraficos.TextXAlignment = Enum.TextXAlignment.Left
lblGraficos.TextWrapped = true
lblGraficos.Parent = fGraficos

-- NAVEGACIÓN Y EVENTOS DE BOTONES LATERALES
local tabs = {
	{Name = "Inicio", Icon = "ℹ️"},
	{Name = "Aimbot", Icon = "🎯", Active = true},
	{Name = "Macro", Icon = "⚡"},
	{Name = "Visuales", Icon = "👁️"},
	{Name = "Movimiento", Icon = "🏃"},
	{Name = "AutoFarm", Icon = "⚙️"},
	{Name = "Gráficos", Icon = "🖥️"}
}

local tabButtons = {}

for i, tab in ipairs(tabs) do
	local TabBtn = Instance.new("TextButton")
	TabBtn.Size = UDim2.new(1, -16, 0, 24)
	TabBtn.Position = UDim2.new(0, 8, 0, 28 + (i - 1) * 28)
	TabBtn.BackgroundColor3 = tab.Active and Color3.fromRGB(30, 30, 42) or Color3.fromRGB(0, 0, 0)
	TabBtn.BackgroundTransparency = tab.Active and 0 or 1
	TabBtn.Text = "  " .. tab.Icon .. "  " .. tab.Name
	TabBtn.TextColor3 = tab.Active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 160)
	TabBtn.TextSize = 10
	TabBtn.Font = Enum.Font.GothamSemibold
	TabBtn.TextXAlignment = Enum.TextXAlignment.Left
	TabBtn.Parent = Sidebar

	local UICornerTab = Instance.new("UICorner")
	UICornerTab.CornerRadius = UDim.new(0, 6)
	UICornerTab.Parent = TabBtn

	local Indicator = Instance.new("Frame")
	Indicator.Size = UDim2.new(0, 3, 0, 14)
	Indicator.Position = UDim2.new(0, 0, 0.5, -7)
	Indicator.BackgroundColor3 = Color3.fromRGB(0, 255, 135)
	Indicator.BorderSizePixel = 0
	Indicator.Visible = tab.Active
	Indicator.Parent = TabBtn
	
	local IndCorner = Instance.new("UICorner")
	IndCorner.CornerRadius = UDim.new(1, 0)
	IndCorner.Parent = Indicator

	tabButtons[i] = {Btn = TabBtn, Ind = Indicator, Name = tab.Name}

	TabBtn.MouseButton1Click:Connect(function()
		for _, tb in ipairs(tabButtons) do
			tb.Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			tb.Btn.BackgroundTransparency = 1
			tb.Btn.TextColor3 = Color3.fromRGB(150, 150, 160)
			tb.Ind.Visible = false
		end
		TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
		TabBtn.BackgroundTransparency = 0
		TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		Indicator.Visible = true
		ContentTitle.Text = tab.Name

		for _, frame in pairs(TabFrames) do
			frame.Visible = false
		end
		if TabFrames[tab.Name] then
			TabFrames[tab.Name].Visible = true
		end
	end)
end

-- CÍRCULO MINIMIZADO "DKV" Y BOTÓN FLOTANTE
local MinimizedCircle = Instance.new("TextButton")
MinimizedCircle.Name = "MinimizedCircle"
MinimizedCircle.Size = UDim2.new(0, 50, 0, 50)
MinimizedCircle.Position = UDim2.new(0.05, 0, 0.2, 0)
MinimizedCircle.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
MinimizedCircle.TextColor3 = Color3.fromRGB(0, 255, 135)
MinimizedCircle.Text = "DKV"
MinimizedCircle.TextSize = 14
MinimizedCircle.Font = Enum.Font.GothamBold
MinimizedCircle.Visible = false
MinimizedCircle.Parent = ScreenGui

local UICornerCircle = Instance.new("UICorner")
UICornerCircle.CornerRadius = UDim.new(1, 0)
UICornerCircle.Parent = MinimizedCircle

local UIStrokeCircle = Instance.new("UIStroke")
UIStrokeCircle.Color = Color3.fromRGB(0, 255, 135)
UIStrokeCircle.Thickness = 1.5
UIStrokeCircle.Parent = MinimizedCircle

-- LÓGICA DE MINIMIZAR / RESTAURAR
MinimizeBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	MinimizedCircle.Visible = true
end)

MinimizedCircle.MouseButton1Click:Connect(function()
	MinimizedCircle.Visible = false
	MainFrame.Visible = true
end)

-- ARRASTRE DE LA VENTANA PRINCIPAL (DESDE EL TOPBAR)
local dragging, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- ARRASTRE DEL CÍRCULO "DKV"
local circleDragging, circleDragStart, circleStartPos
MinimizedCircle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		circleDragging = true
		circleDragStart = input.Position
		circleStartPos = MinimizedCircle.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if circleDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - circleDragStart
		MinimizedCircle.Position = UDim2.new(circleStartPos.X.Scale, circleStartPos.X.Offset + delta.X, circleStartPos.Y.Scale, circleStartPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		circleDragging = false
	end
end)

-- BOTÓN FLOTANTE 🎯
local MobileShootBtn = Instance.new("TextButton")
MobileShootBtn.Name = "MobileShootBtn"
MobileShootBtn.Size = UDim2.new(0, 50, 0, 50)
MobileShootBtn.Position = UDim2.new(0.82, 0, 0.45, 0)
MobileShootBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 95)
MobileShootBtn.BackgroundTransparency = 0.2
MobileShootBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MobileShootBtn.Text = "🎯"
MobileShootBtn.TextSize = 22
MobileShootBtn.Visible = silentBtnEnabled
MobileShootBtn.Parent = ScreenGui

local MobileBtnCorner = Instance.new("UICorner")
MobileBtnCorner.CornerRadius = UDim.new(1, 0)
MobileBtnCorner.Parent = MobileShootBtn

-- ARRASTRE DEL BOTÓN 🎯
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
-- PARTE D: LÓGICA DE JUEGO, BUCLES Y EVENTOS
-- =========================================

-- FUNCIONALIDADES DE ESCANEO
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
								if not hit then
									foundPrimary = part
									break
								end
							end
						end

						if foundPrimary then
							bestDist = dist
							bestPart = foundPrimary
						else
							for _, pName in ipairs(secondaryParts) do
								local part = eChar:FindFirstChild(pName)
								if part then
									local hit = workspace:Raycast(originPos, part.Position - originPos, rayParams)
									if not hit then
										bestDist = dist
										bestPart = part
										break
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return bestPart
end

local function getClosestEnemy()
	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
	local root = char.HumanoidRootPart
	local closestChar = nil
	local closestDist = math.huge

	for _, p in ipairs(Players:GetPlayers()) do
		if isEnemy(p) and p.Character then
			local eChar = p.Character
			local eHum = eChar:FindFirstChildOfClass("Humanoid")
			if eHum and eHum.Health > 0 then
				local eRoot = eChar:FindFirstChild("HumanoidRootPart")
				if eRoot then
					local dist = (eRoot.Position - root.Position).Magnitude
					if dist < closestDist then
						closestDist = dist
						closestChar = eChar
					end
				end
			end
		end
	end
	return closestChar
end

local function getRemote(name)
	local char = LocalPlayer.Character
	if char then
		for _, t in ipairs(char:GetChildren()) do
			if t:IsA("Tool") and (t.Name:lower():find(name:lower()) or t:FindFirstChild(name)) then 
				return t, t:FindFirstChild(name) or t:FindFirstChildOfClass("RemoteEvent") 
			end
		end
	end
	local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
	if bp then
		for _, t in ipairs(bp:GetChildren()) do
			if t:IsA("Tool") and (t.Name:lower():find(name:lower()) or t:FindFirstChild(name)) then 
				return t, t:FindFirstChild(name) or t:FindFirstChildOfClass("RemoteEvent") 
			end
		end
	end
	return nil, nil
end

local function executeShoot(overridePoint)
	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char.HumanoidRootPart

	local gun, gunRemote = getRemote("GunFire")
	if not gun or not gunRemote then return end

	local targetPart = nil
	if silentAim then
		targetPart = getVisibleTarget()
		if not targetPart then return end
	end

	local autoUnequip = false
	if macroClick and gun.Parent ~= char then
		hum:EquipTool(gun)
		autoUnequip = true
		local t = tick()
		repeat task.wait() until gun.Parent == char or (tick() - t) > 0.15
	elseif not macroClick and gun.Parent ~= char then
		return
	end

	local targetPos = targetPart and targetPart.Position
	if not targetPos then
		if overridePoint then
			local unitRay = Camera:ViewportPointToRay(overridePoint.X, overridePoint.Y)
			targetPos = unitRay.Origin + unitRay.Direction * 10000
		else
			local mouseLocation = UserInputService:GetMouseLocation()
			local unitRay = Camera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
			targetPos = unitRay.Origin + unitRay.Direction * 10000
		end
	end

	local myPos = root.Position
	pcall(function()
		gunRemote:FireServer(
			Vector3.new(myPos.X + 0.5, myPos.Y + 2, myPos.Z),
			targetPos,
			false, false,
			workspace:GetServerTimeNow(),
			Vector3.new(myPos.X, myPos.Y + 2.5, myPos.Z)
		)
	end)

	if autoUnequip then
		task.delay(0.05, function() pcall(function() hum:UnequipTools() end) end)
	end
end

-- BUCLE AUTO-KILL
task.spawn(function()
	while task.wait(0.05) do
		if autoKill then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum and hum.Health > 0 then
					local enemy = getClosestEnemy()
					if enemy and enemy:FindFirstChild("HumanoidRootPart") then
						local root = char.HumanoidRootPart
						local eRoot = enemy.HumanoidRootPart

						local knife, remote = getRemote("KnifeServer")
						if not remote then knife, remote = getRemote("Throw") end
						if not remote then knife, remote = getRemote("Knife") end

						if knife and remote then
							root.CFrame = eRoot.CFrame * CFrame.new(0, 0, 1.2)

							if knife.Parent ~= char then
								hum:EquipTool(knife)
								local t = tick()
								repeat task.wait() until knife.Parent == char or (tick() - t) > 0.15
							end

							if knife.Parent == char then
								knife:Activate()
								pcall(function()
									remote:FireServer(
										eRoot.Position,
										(eRoot.Position - root.Position).Unit * 10000,
										workspace:GetServerTimeNow()
									)
								end)
							end
						end
					end
				end
			end
		end
	end
end)

-- BUCLE PRINCIPAL (RENDERSTEPPED)
RunService.RenderStepped:Connect(function()
	local char = LocalPlayer.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")

	if hum then
		if speedHack then
			hum.WalkSpeed = customSpeed
		else
			if hum.WalkSpeed == customSpeed then
				hum.WalkSpeed = defaultWalkSpeed
			end
		end
	end

	if autoKnife and hum and root then
		local knife, remote = getRemote("KnifeServer")
		if not remote then knife, remote = getRemote("Throw") end
		if knife and remote and knife.Parent == char then
			local target = getVisibleTarget()
			if target then
				knife:Activate()
				pcall(function()
					remote:FireServer(target.Position, (target.Position - root.Position).Unit * 10000, workspace:GetServerTimeNow())
				end)
			end
		end
	end

	if autoShoot and hum and root then
		local target = getVisibleTarget()
		local gun, gunRemote = getRemote("GunFire")
		if target and gun and gunRemote then
			if gun.Parent ~= char then
				hum:EquipTool(gun)
			end
			local myPos = root.Position
			pcall(function()
				gunRemote:FireServer(
					Vector3.new(myPos.X + 0.5, myPos.Y + 2, myPos.Z),
					target.Position,
					false, false,
					workspace:GetServerTimeNow(),
					Vector3.new(myPos.X, myPos.Y + 2.5, myPos.Z)
				)
			end)
		end
	end
end)

-- ESP BUCLE
task.spawn(function()
	while task.wait(0.5) do
		if espRainbow then
			local hue = (tick() % 3) / 3
			local col = Color3.fromHSV(hue, 1, 1)
			for _, p in ipairs(Players:GetPlayers()) do
				if isEnemy(p) and p.Character then
					local hl = p.Character:FindFirstChild("DeltaESP") or Instance.new("Highlight")
					hl.Name = "DeltaESP"
					hl.Adornee = p.Character
					hl.FillColor = col
					hl.OutlineColor = col
					hl.FillTransparency = 0.5
					hl.Parent = p.Character
					hl.Enabled = true
				elseif p.Character and p.Character:FindFirstChild("DeltaESP") then
					p.Character.DeltaESP.Enabled = false
				end
			end
		else
			for _, p in ipairs(Players:GetPlayers()) do
				if p.Character and p.Character:FindFirstChild("DeltaESP") then
					p.Character.DeltaESP.Enabled = false
				end
			end
		end
	end
end)

-- MANEJO DE MACRO CLICK EN PANTALLA
local touchStartPos = nil
local touchTime = 0

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		touchStartPos = input.Position
		touchTime = tick()
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		if touchStartPos then
			local dragDistance = (input.Position - touchStartPos).Magnitude
			local duration = tick() - touchTime

			if dragDistance < 15 and duration < 0.4 then
				if macroClick then
					executeShoot(Vector2.new(input.Position.X, input.Position.Y))
				end
			end
		end
		touchStartPos = nil
	end
end)

-- BOTÓN FLOTANTE 🎯 DE DISPARO
MobileShootBtn.MouseButton1Click:Connect(function()
	if silentBtnEnabled then
		executeShoot()
	end
end)
