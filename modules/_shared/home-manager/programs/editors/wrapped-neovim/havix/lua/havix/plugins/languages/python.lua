-- ============================================================================
-- [HAVIX] Plugins > Languages > Python
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.mappings"
local Mapping = require("havix.util.mappings")
---@module "lua.havix.util.functions"
local Function = require("havix.util.functions")
---@module "lua.havix.util.autocmds"
local Autocmd = require("havix.util.autocmds")

local map = Mapping.map
local L = Mapping.LL
local C = Mapping.C

-- Module Definition ==========================================================

local manager = Factory.new(
    {},
    {
        {
            "trigger_python_lsp_enable",
            for_spec = "python",
            disable_for_vscode = true,

            load = function()
                vim.lsp.enable({
                    "basedpyright",
                    "ruff"
                })
            end,

            lazy = false,
        },
        function(deferral, config)
            return {
                "trigger_python_formatter_enable",
                for_spec = "python",
                disable_for_vscode = true,

                load = function()
                    local conform = Function.try_conform(deferral, config)

                    conform.formatters_by_ft.python = {
                        "ruff_fix",
                        "ruff_format",
                        "ruff_organize_imports",
                    }
                end,

                on_plugin = "conform.nvim",
            }
        end,
        {
            "venv-selector.nvim",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "python",

            after = function()
                require("venv-selector").setup({
                    notify_user_on_venv_activation = true,
                    override_notify = false,
                })

                map("n", L "v", C "VenvSelect", { desc = "Virtual environment" })
            end,

            ft = "python",
            keys = {
                "<localleader>v",
            },
        },
        {
            "nvim-dap-python",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "python",

            after = function()
                local m = require("dap-python")

                m.setup("uv")

                m.test_runner = "pytest"
            end,

            on_plugin = {
                "venv-selector.nvim",
            },
            ft = "python",
        }
    }
)

-- Module Exports =============================================================

return manager
