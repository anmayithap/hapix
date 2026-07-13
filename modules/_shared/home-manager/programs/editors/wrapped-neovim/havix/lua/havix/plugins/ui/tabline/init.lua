-- ============================================================================
-- [HAVIX] Plugins > UI > Tabline
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.ui.tabline.mini-tabline",
    }
)

-- Module Exports =============================================================

return manager
