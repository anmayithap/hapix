-- ============================================================================
-- [HAVIX] Plugins > UI > Statusline
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.ui.statusline.mini-statusline",
    }
)

-- Module Exports =============================================================

return manager
