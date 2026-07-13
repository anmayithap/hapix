-- ============================================================================
-- [HAVIX] Plugins > UI > Starter > mini.starter
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
            "mini.starter",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "starter",

            after = function()
                local s = require("mini.starter")

                s.setup({
                    items = {
                        s.sections.sessions(5, true),            -- sessions count | only recent sessions
                        s.sections.recent_files(3, true, false), -- files count | for current directory | without abs path
                        s.sections.pick(),
                        {
                            { name = "Quit Neovim", action = "qall", section = "Actions" },
                        }
                    },

                    header = function()
                        return [[
 .-._                                                   _,-,
  `._`-._                                           _,-'_,'
     `._ `-._                                   _,-' _,'
        `._  `-._        __.-----.__        _,-'  _,'
           `._   `#==="""           """===#'   _,'
              `._/)  ._               _.  (\_,'
               )*'     **.__     __.**     '*(
               #  .==..__  ""   ""  __..==,  #
Сосал?         #   `"._(_).       .(_)_."'   #
                        ]]
                    end,

                    footer = "",
                })

                map("n", L "So", function() s.open() end, { desc = "Open" })
                map("n", L "Sr", function() s.refresh() end, { desc = "Refresh" })
            end,


            lazy = false,
        },
    }
)

-- Module Exports =============================================================

return manager
