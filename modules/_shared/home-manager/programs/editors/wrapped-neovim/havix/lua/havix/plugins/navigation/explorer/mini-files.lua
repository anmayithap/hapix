-- ============================================================================
-- [HAVIX] Plugins > Navigation > Explorer > mini.files
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.autocmds"
local Autocmd = require("havix.util.autocmds")

-- Module Definition ==========================================================

local manager = Factory.new(
    {},
    {
        function(_, config)
            return {
                "mini.files",
                auto_enable = true,
                disable_for_vscode = true,
                for_spec = "explorer",

                after = function()
                    require("mini.files").setup({
                        windows = {
                            preview = true,
                        },

                        options = {
                            permanent_delete = false,
                            use_as_default_explorer = config.settings.explorer.default == "as_tree",
                        },
                    })

                    Autocmd.new("User", {
                        pattern = "MiniFilesExplorerOpen",
                        callback = function()
                            MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
                        end,
                        desc = "[EXPLORER]: Set bookmarks",
                    })
                end,

                lazy = false,
            }
        end,
    }
)

-- Module Exports =============================================================

return manager
