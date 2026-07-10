local P_BOSS = Vector3.new(3450.6, 4.2, 8.2)
local N_BOSS = "Holy Wyrm"
local FarmAtivo = true
local TempoBoss = 4

local LP = game:GetService("Players").LocalPlayer
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local P_LOBBY = Vector3.new(0, 5, 0)

if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
    P_LOBBY = LP.Character.HumanoidRootPart.Position
end

local SG = Instance.new("ScreenGui", game:GetService("CoreGui") or LP:WaitForChild("PlayerGui"))
SG.Name = "MECUI"
SG.ResetOnSpawn = false

local MF = Instance.new("Frame", SG)
MF.BackgroundColor3 = Color3.fromRGB(10,10,12)
MF.Size = UDim2.new(0,220,0,190)
MF.Position = UDim2.new(0.05,0,0.35,0)
MF.Active = true
MF.Draggable = true

local C_MF = Instance.new("UICorner", MF)
C_MF.CornerRadius = UDim.new(0,10)

local TL = Instance.new("Frame", MF)
TL.BackgroundColor3 = Color3.fromRGB(0,255,100)
TL.Size = UDim2.new(1,0,0,4)

local Title = Instance.new("TextLabel", MF)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,0,0.05,0)
Title.Size = UDim2.new(1,0,0,25)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ USER: " .. LP.DisplayName .. " ⚡"
Title.TextColor3 = Color3.fromRGB(0,255,100)
Title.TextSize = 13

local Sub = Instance.new("TextLabel", MF)
Sub.BackgroundTransparency = 1
Sub.Position = UDim2.new(0,0,0.18,0)
Sub.Size = UDim2.new(1,0,0,15)
Sub.Font = Enum.Font.Gotham
Sub.Text = "Holy Wyrm Auto Farm"
Sub.TextColor3 = Color3.fromRGB(120,120,130)
Sub.TextSize = 11

local BT = Instance.new("TextButton", MF)
BT.BackgroundColor3 = Color3.fromRGB(0,180,70)
BT.Position = UDim2.new(0.1,0,0.32,0)
BT.Size = UDim2.new(0,176,0,32)
BT.Font = Enum.Font.GothamBold
BT.Text = "FARM: ATIVADO"
BT.TextColor3 = Color3.fromRGB(255,255,255)
BT.TextSize = 12

local C_BT = Instance.new("UICorner", BT)
C_BT.CornerRadius = UDim.new(0,6)

local BS = Instance.new("UIStroke", BT)
BS.Color = Color3.fromRGB(0,255,100)
BS.Thickness = 1

BT.MouseButton1Click:Connect(function()
    FarmAtivo = not FarmAtivo
    if FarmAtivo then
        BT.Text = "FARM: ATIVADO"
        TS:Create(BT, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0,180,70)}):Play()
        TS:Create(BS, TweenInfo.new(0.25), {Color = Color3.fromRGB(0,255,100)}):Play()
    else
        BT.Text = "FARM: DESATIVADO"
        TS:Create(BT, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(40,40,45)}):Play()
        TS:Create(BS, TweenInfo.new(0.25), {Color = Color3.fromRGB(70,70,75)}):Play()
    end
end)

local SB = Instance.new("Frame", MF)
SB.BackgroundColor3 = Color3.fromRGB(30,30,35)
SB.Position = UDim2.new(0.1,0,0.58,0)
SB.Size = UDim2.new(0,176,0,18)

local C_SB = Instance.new("UICorner", SB)
C_SB.CornerRadius = UDim.new(0,4)

local SF = Instance.new("Frame", SB)
SF.BackgroundColor3 = Color3.fromRGB(0,255,100)
SF.Size = UDim2.new(0.15,0,1,0)

local C_SF = Instance.new("UICorner", SF)
C_SF.CornerRadius = UDim.new(0,4)

local SL = Instance.new("TextLabel", SB)
SL.BackgroundTransparency = 1
SL.Size = UDim2.new(1,0,1,0)
SL.Font = Enum.Font.GothamBold
SL.Text = "Tempo no Boss: 4s"
SL.TextColor3 = Color3.fromRGB(255,255,255)
SL.TextSize = 10

local Cr = Instance.new("TextLabel", MF)
Cr.BackgroundTransparency = 1
Cr.Position = UDim2.new(0,0,0.82,0)
Cr.Size = UDim2.new(1,0,0,20)
Cr.Font = Enum.Font.GothamSemibold
Cr.Text = "Criador: TheBoy2K"
Cr.TextColor3 = Color3.fromRGB(80,80,90)
Cr.TextSize = 10

local dragging = false
local function updateSlider(input)
    local pos = math.clamp((input.Position.X - SB.AbsolutePosition.X) / SB.AbsoluteSize.X, 0, 1)
    TempoBoss = math.floor(1 + (pos * 19))
    SF.Size = UDim2.new(pos, 0, 1, 0)
    SL.Text = "Tempo no Boss: " .. TempoBoss .. "s"
end

SB.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        updateSlider(input)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if FarmAtivo then
            local char = LP.Character or LP.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart", 5)
            local hum = char:WaitForChild("Humanoid", 5)
            
            if root and hum and hum.Health > 0 then
                root.CFrame = CFrame.new(P_LOBBY)
                task.wait(2)
            end
            
            if FarmAtivo then
                local tempoInicial = tick()
                while (tick() - tempoInicial < TempoBoss) and FarmAtivo do
                    RunService.Heartbeat:Wait()
                    
                    local cChar = LP.Character
                    local cRoot = cChar and cChar:FindFirstChild("HumanoidRootPart")
                    local cHum = cChar and cChar:FindFirstChild("Humanoid")
                    
                    if cRoot and cHum and cHum.Health > 0 then
                        cRoot.CFrame = CFrame.new(P_BOSS)
                        
                        local tool = LP.Backpack:FindFirstChildOfClass("Tool") or cChar:FindFirstChildOfClass("Tool")
                        if tool then
                            if tool.Parent ~= cChar then
                                cHum:EquipTool(tool)
                            end
                            tool:Activate()
                        end
                    else
                        break
                    end
                end
            end
        end
    end
end)
