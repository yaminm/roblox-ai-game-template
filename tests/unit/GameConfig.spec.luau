--!strict

local GameConfig = require("../../src/shared/GameConfig")

assert(type(GameConfig.Name) == "string" and #GameConfig.Name > 0, "Game name must be nonempty")
assert(table.isfrozen(GameConfig), "Shared configuration must be immutable")
print("Game configuration tests passed")
