-- ============================================================================
-- [HAVIX] Plugins > UI > Icons
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.ui.icons.mini-icons",
    }
)

-- Module Exports =============================================================

return manager
