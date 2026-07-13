-- ============================================================================
-- [HAVIX] Plugins > UI > Notifier > mini.notify
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.mappings"
local Mapping = require("havix.util.mappings")

local map = Mapping.map
local L = Mapping.L
local C = Mapping.C

-- Module Definition ==========================================================

local manager = Factory.new(
    {},
    {
        {
            "mini.notify",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "notifier",

            after = function()
                require("mini.notify").setup(
                    {
                        window = {
                            config = {
                                border = vim.o.winborder or "bold",
                            },

                            winblend = 0,
                        },
                    }
                )

                map("n", L "en", C "lua MiniNotify.show_history()", { desc = "Notifications" })
            end,

            lazy = false,
        },
    }
)

-- Module Exports =============================================================

return manager
