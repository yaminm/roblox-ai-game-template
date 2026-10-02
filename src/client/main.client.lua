--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage.Shared.GameConfig)

Players.LocalPlayer:SetAttribute("ClientReady", true)
print("Client bootstrap ready: " .. GameConfig.Name)
