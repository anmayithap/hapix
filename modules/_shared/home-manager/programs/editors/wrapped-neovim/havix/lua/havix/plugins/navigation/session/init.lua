-- ============================================================================
-- [HAVIX] Plugins > Navigation > Session
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.navigation.session.mini-sessions",
    }
)

-- Module Exports =============================================================

return manager
