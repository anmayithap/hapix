-- ============================================================================
-- [HAVIX] Plugins > UI > Icons > mini.icons
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")

-- Module Definition ==========================================================

local manager = Factory.new(
    {},
    {
        function(deferral, _)
            return {
                {
                    "mini.icons",
                    auto_enable = true,
                    disable_for_vscode = true,
                    for_spec = "icons",

                    after = function()
                        local icons = require("mini.icons")

                        icons.setup(
                            {
                                style = "glyph",
                                use_file_extension = function(_, ext)
                                    local suf3, suf4 = ext:sub(-3), ext:sub(-4)

                                    local is_not_scm = suf3 ~= "scm"
                                    local is_not_txt = suf3 ~= "txt"
                                    local is_not_yml = suf3 ~= "yml" and suf4 ~= "yaml"
                                    local is_not_json = suf4 ~= "json"

                                    return is_not_scm and is_not_txt and is_not_yml and is_not_json
                                end,
                            }
                        )

                        deferral.later(icons.mock_nvim_web_devicons)
                        deferral.later(icons.tweak_lsp_kind)
                    end,

                    on_plugin = {
                        "oil.nvim", -- This is necessary for oil.nvim to display icons.
                    },
                },
            }
        end,
    }
)

-- Module Exports =============================================================

return manager
