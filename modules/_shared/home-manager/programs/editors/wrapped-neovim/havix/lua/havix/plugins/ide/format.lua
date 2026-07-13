-- ============================================================================
-- [HAVIX] Plugins > Ide > Format
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.options"
local Option = require("havix.util.options")
---@module "lua.havix.util.mappings"
local Mapping = require("havix.util.mappings")

local map = Mapping.map
local o = Option.o

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new(
    {},
    {
        {
            "conform.nvim",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "format",

            after = function()
                require("conform").setup({
                    formatters_by_ft = {
                        sh = { "shfmt" },
                        markdown = { "prettier" },
                        yaml = { "prettier" },
                        json = { "biome", "prettier", stop_after_first = true },
                        jsonc = { "biome", "prettier", stop_after_first = true },
                        javascript = { "biome", "prettier", stop_after_first = true },
                        typescript = { "biome", "prettier", stop_after_first = true },
                        html = { "biome", "prettier", stop_after_first = true },
                        css = { "biome", "prettier", stop_after_first = true },
                        graphql = { "biome", "prettier", stop_after_first = true },
                        dockerfile = { "injected" },
                        rst = { "rstfmt" },

                        ["_"] = { "trim_whitespace", "trim_newlines", lsp_format = "last" },
                    },

                    default_format_opts = {
                        lsp_format = "fallback",
                    },

                    log_level = vim.log.levels.ERROR,
                })

                o.formatexpr = "v:lua.require('conform').formatexpr()"

                map({ "n", "v" }, "gqq", H.format, { desc = "Format" })
            end,

            lazy = false,
        }
    }
)

-- Helper functionality =======================================================

--- Format
function H.format()
    require("conform").format({ async = true }, function(err)
        if not err then
            -- Exit from visual mode if format was applied on selected text
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
                local exit_visual = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
                vim.api.nvim_feedkeys(exit_visual, "n", true)
            end
        end
    end)
end

-- Module Exports =============================================================

return manager
