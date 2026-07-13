-- ============================================================================
-- [HAVIX] Plugins > Languages
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.languages.python",
        "havix.plugins.languages.lua",
    }
)

-- Module Exports =============================================================

return manager
