--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage.Shared.GameConfig)

ReplicatedStorage:SetAttribute("ServerReady", true)
print("Server bootstrap ready: " .. GameConfig.Name)
