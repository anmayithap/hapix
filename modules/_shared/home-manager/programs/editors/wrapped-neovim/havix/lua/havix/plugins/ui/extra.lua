-- ============================================================================
-- [HAVIX] Plugins > UI > Extra
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.mappings"
local Mapping = require("havix.util.mappings")
---@module "lua.havix.util.autocmds"
local Autocmd = require("havix.util.autocmds")

local map = Mapping.map
local L = Mapping.L
local C = Mapping.C

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new(
    {},
    {
        {
            "mini.cursorword",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "ui-extra",

            after = function()
                require("mini.cursorword").setup()
            end,

            lazy = false,
        },
        {
            "mini.hipatterns",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "ui-extra",

            after = function()
                local m = require("mini.hipatterns")
                local words = require("mini.extra").gen_highlighter.words

                m.setup({
                    highlighters = {
                        hex_color = m.gen_highlighter.hex_color({
                            style = "inline",
                            inline_text = " ",
                        }),
                        fixme     = words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
                        hack      = words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
                        todo      = words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
                        note      = words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
                    },
                })
            end,

            on_plugin = "mini.extra",
        },
        {
            "mini.indentscope",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "ui-extra",

            after = function()
                require("mini.indentscope").setup()
            end,

            lazy = false,
        },
        {
            "mini.map",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "ui-extra",

            after = function()
                local m = require("mini.map")

                m.setup({
                    integrations = {
                        m.gen_integration.builtin_search(),
                        m.gen_integration.diff(),
                        m.gen_integration.diagnostic(),
                    },

                    symbols = {
                        encode = m.gen_encode_symbols.dot("4x2"),
                    },

                    window = {
                        -- place above treesitter-context, which is 20
                        zindex = 21,
                    },
                })

                -- Refresh minimap on certain movements
                for _, key in ipairs({ "n", "N", "*", "#" }) do
                    map(
                        "n",
                        key,
                        key .. "zv<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>"
                    )
                end

                Mapping.map_extend('n', '<C-L>', function()
                  MiniMap.refresh()
                end)

                Autocmd.new("BufEnter", {
                    callback = vim.schedule_wrap(function()
                        -- Do nothing if entering the minimap buffer itself (when focusing)
                        if vim.bo.filetype == "minimap" then return end

                        -- Otherwise we check if the minimap should be opened or not
                        if H.minimap_should_be_enabled() then
                            m.open()
                        else
                            m.close()
                        end
                    end),
                    desc = "[MAP]: Configure map toggle",
                })

                map("n", L "mf", C "lua MiniMap.toggle_focus()", { desc = "Focus" })
                map("n", L "mr", C "lua MiniMap.refresh()", { desc = "Refresh" })
                map("n", L "ms", C "lua MiniMap.toggle_side()", { desc = "Switch sides" })
                map("n", L "mt", C "lua MiniMap.toggle()", { desc = "Toggle" })
            end,

            lazy = false,
        },
        {
            "render-markdown.nvim",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "ui-extra",

            after = function()
                require("render-markdown").setup({
                    file_types = { "markdown", "md" },
                    render_modes = { "n", "no", "c", "t", "i", "ic" },
                    completions = {
                        lsp = {
                            enabled = true,
                        },
                    },
                })
            end,

            lazy = false,
        },
        {
            "toggleterm.nvim",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "ui-extra",

            after = function()
                require("toggleterm").setup({
                    open_mapping = [[<c-\>]],

                    direction = "horizontal",
                    shade_terminals = false,
                    autochdir = true, -- When neovim changes it current directory the terminal will changes it's own when next it's opened
                    highlights = {
                        NormalFloat = { link = "NormalFloat" },
                        FloatBorder = { link = "FloatBorder" },
                    },
                    float_opts = {
                        border = vim.o.winborder or "bold",
                        winblend = 0,
                    },
                })

                local TerminalC = require("toggleterm.terminal").Terminal

                local lazygit = TerminalC:new({
                    cmd = "lazygit",
                    dir = "git_dir",
                    hidden = true,
                    direction = "float",
                    on_open = H.toggleterm_float_handler,
                })

                local lazydocker = TerminalC:new({
                    cmd = "lazydocker",
                    dir = "git_dir",
                    hidden = true,
                    direction = "float",
                    on_open = H.toggleterm_float_handler,
                })

                map("n", L [[\]], C "TermSelect", { desc = "Toggle terminal" })
                map("n", L "gg", function() lazygit:toggle() end, { desc = "LazyGit" })
            end,

            lazy = false,
        },
        {
            "mini.trailspace",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "ui-extra",

            after = function()
                require("mini.trailspace").setup()
            end,

            lazy = false,
        },
    }
)

-- Helper data ================================================================

--- Which file types will show mini.map
---
---@type table<string, boolean>
H.map_auto_enable = {
    python = true,
    go = true,
    markdown = true,
    lua = true,
}

-- Helper functionality =======================================================

--- Return true if the current buffer is supposed to have a map.
--- 1. User has expilicity enabled it via M.buf_toggle
--- 2. Filetype of buffer is in the auto_enable table
---
---@return boolean
H.minimap_should_be_enabled = function()
    local ft = vim.bo.filetype
    local disabled = vim.b.minimap_disable
    local enabled_explicitly = vim.b.minimap_disable == false
    return enabled_explicitly or H.map_auto_enable[ft] and not disabled
end

-- Module Exports =============================================================

return manager
