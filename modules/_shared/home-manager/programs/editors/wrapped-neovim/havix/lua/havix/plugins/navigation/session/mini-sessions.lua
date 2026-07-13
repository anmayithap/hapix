-- ============================================================================
-- [HAVIX] Plugins > Navigation > Session > mini.session
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

local H = {}

local manager = Factory.new(
    {},
    {
        function(_, config)
            return {
                "mini.sessions",
                auto_enable = true,
                disable_for_vscode = true,
                for_spec = "session",

                after = function()
                    require("mini.sessions").setup()

                    map("n", L "sd", C "lua MiniSessions.select('delete')", { desc = "Delete" })
                    map("n", L "sr", C "lua MiniSessions.select('read')", { desc = "Read" })
                    map("n", L "sn", C "lua MiniSessions.write(vim.fn.input('Session name: '))", { desc = "New" })
                    map("n", L "ss", C "lua MiniSessions.write()", { desc = "Write" })
                end,

                lazy = false,
            }
        end,
    }
)

-- Module Exports =============================================================

return manager
