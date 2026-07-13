-- ============================================================================
-- [HAVIX] Plugins > UI > Notifier
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.ui.notifier.mini-notify",
    }
)

-- Module Exports =============================================================

return manager
