-- ============================================================================
-- [HAVIX] Plugins > Navigation > Explorer > oil.nvim
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.mappings"
local Mapping = require("havix.util.mappings")

local map = Mapping.map
local C = Mapping.C
local L = Mapping.L

-- Module Definition ==========================================================

local manager = Factory.new(
    {},
    {
        function(_, opts)
            return {
                "oil.nvim",
                auto_enable = true,
                disable_for_vscode = true,
                for_spec = "explorer",

                after = function()
                    local details = false

                    local o = require("oil")

                    o.setup(
                        {
                            default_file_explorer = opts.settings.explorer.default == "as_buffer",

                            win_options = {
                                wrap = true,
                                signcolumn = "yes",
                            },

                            delete_to_trash = true,
                            skip_confirm_for_simple_edits = true,
                            watch_for_changes = true,

                            keymaps = {
                                ["~"] = { C "edit $HOME", mode = "n", desc = "Open CWD", },
                                ["gd"] = {
                                    callback = function()
                                        details = not details

                                        if details then
                                            require("oil").set_columns(
                                                {
                                                    "icon",
                                                    "permissions",
                                                    "size",
                                                    "mtime",
                                                }
                                            )
                                        else
                                            require("oil").set_columns(
                                                {
                                                    "icon",
                                                }
                                            )
                                        end
                                    end,
                                    desc = "Toggle file detail view",
                                },
                            },

                            view_options = {
                                show_hidden = true,

                                is_always_hidden = function(name, _)
                                    for _, pattern in ipairs(opts.always_hidden) do
                                        if name:match("^" .. pattern .. "$") or name == ".." then
                                            return true
                                        end
                                    end
                                end,
                            },

                            float = {
                                border = vim.o.winborder or "bold",
                                preview_split = "right",
                            },

                            confirmation = {
                                border = vim.o.winborder or "bold",
                            },

                            ssh = {
                                border = vim.o.winborder or "bold",
                            },

                            keymaps_help = {
                                border = vim.o.winborder or "bold",
                            },
                        }
                    )

                    map("n", "-", C "Oil", { desc = "Open parent directory" })
                    map("n", "_", function() o.open(vim.fn.getcwd()) end, { desc = "Open CWD" })
                    map("n", L "eb",
                        function()
                            o.toggle_float(nil, {
                                horizontal = true,
                                split = "aboveleft",
                            })
                        end,
                        { desc = "Toggle parent directory" }
                    )
                    map("n", L "eB",
                        function()
                            o.toggle_float(vim.fn.getcwd(), {
                                horizontal = true,
                                split = "aboveleft",
                            })
                        end,
                        { desc = "Toggle CWD" }
                    )
                end,

                lazy = false,
            }
        end,
        function(_, opts)
            return {
                "oil-lsp-diagnostics.nvim",
                auto_enable = true,
                disable_for_vscode = true,
                for_spec = "explorer",

                after = function()
                    require("oil-lsp-diagnostics").setup(
                        {
                            count = true,
                            parent_dirs = true,
                            diagnostic_colors = {
                                error = "DiagnosticError",
                                warn  = "DiagnosticWarn",
                                info  = "DiagnosticInfo",
                                hint  = "DiagnosticHint",
                            },
                            diagnostic_symbols = {
                                error = opts.icons.diagnostic.error,
                                warn = opts.icons.diagnostic.warn,
                                info = opts.icons.diagnostic.info,
                                hint = opts.icons.diagnostic.hint,
                            },
                        }
                    )
                end,

                on_plugin = "oil.nvim",
            }
        end,
        function(_, opts)
            return {
                "oil-git.nvim",
                auto_enable = true,
                disable_for_vscode = true,
                for_spec = "explorer",

                after = function()
                    local o = require("oil-git")

                    o.setup(
                        {
                            symbol_position = "signcolumn",

                            symbols = {
                                file = {
                                    added = opts.icons.git.added,
                                    modified = opts.icons.git.modified,
                                    removed = opts.icons.git.removed,
                                    renamed = opts.icons.git.renamed,
                                    copied = opts.icons.git.copied,
                                    conflict = opts.icons.git.conflict,
                                    untracked = opts.icons.git.untracked,
                                    ignored = opts.icons.git.ignored,
                                },
                                directory = {
                                    added = opts.icons.git.added,
                                    modified = opts.icons.git.modified,
                                    removed = opts.icons.git.removed,
                                    renamed = opts.icons.git.renamed,
                                    copied = opts.icons.git.copied,
                                    conflict = opts.icons.git.conflict,
                                    untracked = opts.icons.git.untracked,
                                    ignored = opts.icons.git.ignored,
                                },
                            },
                        }
                    )
                end,

                on_plugin = "oil.nvim",
            }
        end,
    }
)

-- Module Exports =============================================================

return manager
