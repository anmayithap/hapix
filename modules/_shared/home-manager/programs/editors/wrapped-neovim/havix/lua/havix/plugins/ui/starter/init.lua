-- ============================================================================
-- [HAVIX] Plugins > UI > Starter
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.ui.starter.mini-starter",
    }
)

-- Module Exports =============================================================

return manager
