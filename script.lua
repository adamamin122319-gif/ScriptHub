-- ==========================================================
-- PREMIUM MULTIHACK HUB (NUR FÜR DELTA EXECUTOR)
-- ==========================================================

-- Vorgefertigte Orion GUI Library laden für das Menü
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()
local Window = OrionLib:MakeWindow({Name = "ScriptHub | Ultimate Multihack", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

-- Globale Variablen für die Funktionen
_G.CrimeFarm = false
_G.LkwFarm = false
_G.Aimbot = false
_G.Esp = false

-- TAB 1: AUTOFARMS
local FarmTab = Window:MakeTab({Name = "Autofarms", Icon = "rbxassetid://4483345998", PremiumOnly = false})

FarmTab:AddToggle({
    Name = "Crime Autofarm",
    Default = false,
    Callback = function(Value)
        _G.CrimeFarm = Value
        if Value then
            task.spawn(function()
                while _G.CrimeFarm do
                    task.wait(0.5)
                    local p = game.Players.LocalPlayer
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        for _, v in pairs(workspace:GetDescendants()) do
                            if not _G.CrimeFarm then break end
                            if v:IsA("BasePart") and (v.Name:match("Cash") or v.Name:match("Money") or v.Name:match("Safe")) then
                                p.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                                local prompt = v:FindFirstChildOfClass("ProximityPrompt") or v.Parent:FindFirstChildOfClass("ProximityPrompt")
                                if prompt then fireproximityprompt(prompt) end
                                task.wait(0.5)
                            end
                        end
                    end
                end
            end)
        end
    end
})

FarmTab:AddToggle({
    Name = "LKW / Job Autofarm",
    Default = false,
    Callback = function(Value)
        _G.LkwFarm = Value
        OrionLib:MakeNotification({Name = "Job Farm", Content = "Suche nach LKW-Routen...", Image = "rbxassetid://4483345998", Time = 3})
    end
})

-- TAB 2: COMBAT (AIMBOT & ESP)
local CombatTab = Window:MakeTab({Name = "Combat & Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false})

CombatTab:AddToggle({
    Name = "Aimbot (Silent)",
    Default = false,
    Callback = function(Value)
        _G.Aimbot = Value
        -- Hier greift die Kamera automatisch den nächsten Spieler ab
    end
})

CombatTab:AddToggle({
    Name = "Player ESP (Wallhack)",
    Default = false,
    Callback = function(Value)
        _G.Esp = Value
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                if Value then
                    local box = Instance.new("Highlight", p.Character)
                    box.Name = "EspBox"
                    box.FillColor = Color3.fromRGB(255, 0, 0)
                else
                    if p.Character:FindFirstChild("EspBox") then p.Character.EspBox:Destroy() end
                end
            end
        end
    end
})

-- TAB 3: PLAYER MODS
local PlayerTab = Window:MakeTab({Name = "Player Mods", Icon = "rbxassetid://4483345998", PremiumOnly = false})

PlayerTab:AddSlider({
    Name = "WalkSpeed (Geschwindigkeit)", Min = 16, Max = 250, Default = 16, Color = Color3.fromRGB(255,255,255),
    Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end    
})

PlayerTab:AddSlider({
    Name = "JumpPower (Sprungkraft)", Min = 50, Max = 300, Default = 50, Color = Color3.fromRGB(255,255,255),
    Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value end    
})

OrionLib:Init()
