-- ============================================================================
-- [HAVIX] Plugins > Navigation > Explorer
-- ============================================================================

---@module "lua.havix.util.manager"
local manager_factory = require("havix.util.manager")

local manager = manager_factory.new(
    {
        "havix.plugins.navigation.explorer.oil",
        "havix.plugins.navigation.explorer.mini-files",
    }
)

return manager
