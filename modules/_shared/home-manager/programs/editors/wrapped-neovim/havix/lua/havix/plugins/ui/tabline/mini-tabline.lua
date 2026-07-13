-- ============================================================================
-- [HAVIX] Plugins > UI > Tabline > mini.tabline
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {},
    {
        function(_, config)
            return {
                "mini.tabline",
                auto_enable = true,
                disable_for_vscode = true,
                for_spec = "tabline",

                after = function()
                    require("mini.tabline").setup({
                        show_icons = true,
                        tabpage_section = "left",

                        --- Add modified icon to buffer name
                        ---@param buffer integer
                        ---@param label string
                        format = function(buffer, label)
                            local suffix = vim.bo[buffer].modified and config.icons.git.modified .. " " or ""
                            return MiniTabline.default_format(buffer, label) .. suffix
                        end,
                    })
                end,
            }
        end,
    }
)

-- Module Exports =============================================================

return manager
