-- ============================================================================
-- [HAVIX] Plugins > Ide
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.ide.syntax",
        "havix.plugins.ide.diagnostic",
        "havix.plugins.ide.lsp",
        "havix.plugins.ide.completion",
        "havix.plugins.ide.format",
        "havix.plugins.ide.dap",
        "havix.plugins.ide.motions",
    }
)

-- Module Exports =============================================================

return manager
