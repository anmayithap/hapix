-- ============================================================================
-- [HAVIX] Plugins > Ide > Motions
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
            "mini.ai",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "motions",

            after = function()
                local m = require("mini.ai")
                local extra = require("mini.extra")

                m.setup({
                    custom_textobjects = {
                        F = m.gen_spec.treesitter({
                            a = '@function.outer',
                            i = '@function.inner'
                        }),
                        o = m.gen_spec.treesitter({
                            a = { "@block.outer", "@loop.outer", "@conditional.outer" },
                            i = { "@block.inner", "@loop.inner", "@conditional.inner" },
                        }),
                        c = m.gen_spec.treesitter({
                            a = "@class.outer",
                            i = "@class.inner",
                        }),

                        B = extra.gen_ai_spec.buffer(),
                        D = extra.gen_ai_spec.diagnostic(),
                        I = extra.gen_ai_spec.indent(),
                        L = extra.gen_ai_spec.line(),
                        N = extra.gen_ai_spec.number(),
                    },

                    n_lines = 500,
                    search_method = "cover_or_next",
                })
            end,

            on_plugin = "mini.extra",
        },
        {
            "mini.comment",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "motions",

            after = function()
                require("mini.comment").setup()
            end,

            lazy = false,
        },
        {
            "mini.move",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "motions",

            after = function()
                require("mini.move").setup({
                    mappings = {
                        left  = 'H',
                        right = 'L',
                        down  = 'J',
                        up    = 'K',
                    },
                })
            end,

            lazy = false,
        },
        {
            "mini.operators",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "motions",

            after = function()
                require("mini.operators").setup({
                    replace = {
                        prefix = "cr",
                    },
                })

                map("n", "(", C "normal gxiagxila", { desc = "Move argument left" })
                map("n", ")", C "normal gxiagxina", { desc = "Move argument right" })
            end,

            lazy = false,
        },
        {
            "mini.splitjoin",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "motions",

            after = function()
                require("mini.splitjoin").setup()
            end,

            lazy = false,
        },
        {
            "mini.surround",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "motions",

            after = function()
                require("mini.surround").setup()
            end,

            lazy = false,
        },
        {
            "leap.nvim",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "motions",

            after = function()
                map({ "n", "x", "o" }, "sj", "<Plug>(leap)", { desc = "Leap anywhere" })
                map({ "n", "x", "o" }, "st", C "lua require('leap.treesitter').select()", { desc = "Treesitter select" })
                map("n", "sw", "<Plug>(leap-from-window)", { desc = "Leap window" })

                -- Highly recommended: define a preview filter to reduce visual noise
                -- and the blinking effect after the first keypress
                -- (see `:h leap.opts.preview`).
                -- For example, skip preview if the first character of the match is
                -- whitespace or is in the middle of an alphabetic word:
                require('leap').opts.preview = function(ch0, ch1, ch2)
                    return not (
                        ch1:match('%s')
                        or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
                    )
                end

                -- Define equivalence classes for brackets and quotes, in addition to
                -- the default whitespace group:
                require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

                -- Use the traversal keys to repeat the previous motion without
                -- explicitly invoking Leap:
                require('leap.user').set_repeat_keys('<enter>', '<backspace>')

                -- Automatic paste after remote yank operations:
                vim.api.nvim_create_autocmd('User', {
                    pattern = 'RemoteOperationDone',
                    group = vim.api.nvim_create_augroup('LeapRemote', {}),
                    callback = function(event)
                        if vim.v.operator == 'y' and event.data.register == '"' then
                            vim.cmd('normal! p')
                        end
                    end,
                })
            end,

            lazy = false,
        },
        {
            "mini.jump",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "motions",

            after = function()
                require("mini.jump").setup()
            end,

            lazy = false,
        }
    }
)

-- Module Exports =============================================================

return manager
