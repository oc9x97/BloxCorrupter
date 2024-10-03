-- all of this is coded by violet.tmod on tiktok or oc9x97 on github
-- dont skid (even tho i used chatgpt)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Config is here
local logging = false -- controls if you want to log things to the console
local changechar = false -- if you want to change your character, leave off to avoid bugs
local mesh = "rbxassetid://5143242882" -- change this to the mesh you want any mesh to become
-- Config ends here

print("Realtime Corrupter has started!") -- will log anyway

local function log(message)
    if logging then
        print(message)
    end
end

local function randomColorChange(part)
    part.Color = Color3.new(math.random(), math.random(), math.random())
    log(part:GetFullName() .. " color changed!")
end

local function randomTransparencyChange(part)
    part.Transparency = math.clamp(part.Transparency + 0.1 * (math.random(0, 1) * 2 - 1), 0, 1)
    log(part:GetFullName() .. " transparency changed to: " .. part.Transparency)
end

local function corruptPlayer()
    while true do
        wait(5)
        if Character and Character:FindFirstChild("Humanoid") then
            local humanoid = Character.Humanoid
            
            -- Randomly change health
            if math.random(1, 10) <= 5 then  -- 50% chance
                local newHealth = math.clamp(humanoid.Health + math.random(-10, 10), 0, humanoid.MaxHealth)
                humanoid.Health = newHealth
                log("Player health changed to: " .. newHealth)
            end
            
            -- Randomly change jump power
            if math.random(1, 10) <= 5 then  -- 50% chance
                humanoid.JumpPower = math.random(50, 200)
                log("Player jump power changed to: " .. humanoid.JumpPower)
            end
            
            -- Randomly change walk speed
            if math.random(1, 10) <= 5 then  -- 50% chance
                humanoid.WalkSpeed = math.random(5, 50)
                log("Player walk speed changed to: " .. humanoid.WalkSpeed)
            end
            
            -- Randomly change body parts color and transparency
            for _, part in ipairs(Character:GetChildren()) do
                if part:IsA("BasePart") then
                    if math.random(1, 10) <= 5 then  -- 50% chance to change color
                        randomColorChange(part)
                    end
                    if math.random(1, 10) <= 5 then  -- 50% chance to change transparency
                        randomTransparencyChange(part)
                    end
                end
            end
        end
    end
end

local function corruptGame()
    while true do
        for _, obj in ipairs(workspace:GetDescendants()) do
            wait(0.01)
            local action = math.random(1, 10)
            
            if obj:IsA("BasePart") then
                if action == 1 then
                    randomColorChange(obj)
                elseif action == 2 then
                    randomTransparencyChange(obj)
                elseif action == 3 then
                    obj.CanCollide = not obj.CanCollide
                    log(obj:GetFullName() .. " collision changed!")
                elseif action == 4 then
                    obj.Transparency = 1
                    log(obj:GetFullName() .. " invisible!")
                elseif action == 5 and not obj:IsA("Terrain") then
                    obj:Destroy()
                    log(obj:GetFullName() .. " destroyed!")
                elseif action == 6 then
                    local scaleFactor = math.random(80, 120) / 100
                    obj.Size = obj.Size * Vector3.new(scaleFactor, scaleFactor, scaleFactor)
                    log(obj:GetFullName() .. " rescaled!")
                elseif action == 7 then
                    obj.Anchored = not obj.Anchored
                    log(obj:GetFullName() .. " anchored state toggled!")
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                if action == 8 then
                    obj.Transparency = math.clamp(obj.Transparency + 0.1, 0, 1)
                    log(obj:GetFullName() .. " decal transparency changed!")
                end
            elseif obj:IsA("Sound") then
                if action == 9 then
                    obj.PlaybackSpeed = math.random(50, 150) / 100
                    log(obj:GetFullName() .. " sound pitch changed!")
                end
            elseif obj:IsA("MeshPart") then
                if action == 10 then
                    obj.MeshId = mesh
                    log(obj:GetFullName() .. " MeshPart changed!")
                end
            end
        end
    end
end

-- Start both functions
corruptGame()
if changechar then
    corruptPlayer()
end
