-- ============================================================================
-- [HAVIX] Plugins > Navigation > Picker
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.navigation.picker.mini-pick",
    }
)

-- Module Exports =============================================================

return manager
