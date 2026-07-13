-- ============================================================================
-- [HAVIX] Plugins > UI
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {
        "havix.plugins.ui.colorscheme",
        "havix.plugins.ui.icons",
        "havix.plugins.ui.statusline",
        "havix.plugins.ui.starter",
        "havix.plugins.ui.notifier",
        "havix.plugins.ui.tabline",
        "havix.plugins.ui.extra",
    },
    {
        {
            "trigger_experimental_ui",

            load = function()
                require("vim._core.ui2").enable({ enable = true })
            end,
        }
    }
)

-- Module Exports =============================================================

return manager
