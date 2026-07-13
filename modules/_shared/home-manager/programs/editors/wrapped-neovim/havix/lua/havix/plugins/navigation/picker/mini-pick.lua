-- ============================================================================
-- [HAVIX] Plugins > Navigation > Picker > mini.pick
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
                "mini.pick",
                auto_enable = true,
                disable_for_vscode = true,
                for_spec = "picker",

                after = function()
                    require("mini.extra")

                    require("mini.pick").setup({
                        mappings = {
                            choose_marked = "<C-q>",

                            move_down = "<C-j>",
                            move_up = "<C-k>",

                            refine = "<C-o>",
                            refine_marked = "<C-p>",
                        },
                    })

                    vim.ui.select = MiniPick.ui_select

                    H.buffers_with_indication(config)

                    map("n", "z=", C "Pick spellsuggest", { desc = "Spelling suggestions" })
                    map("n", L " ", C "Pick files", { desc = "Find files" })
                    map("n", L ",", C "Pick buffers", { desc = "Switch buffer" })
                    map("n", L "/", C "Pick resume", { desc = "Resume" })
                    map("n", L "f/", C "Pick history scope='/'", { desc = "'/' history" })
                    map("n", L "f:", C "Pick history scope=':'", { desc = "':' history" })
                    map("n", L "fa", C "Pick git_hunks scope='staged'", { desc = "Added hunks (all)" })
                    map("n", L "fA", C "Pick git_hunks path='%' scope='staged'", { desc = "Added hunks (buf)" })
                    map("n", L "fc", C "Pick git_commits", { desc = "Commits (all)" })
                    map("n", L "fC", C "Pick git_commits path='%'", { desc = "Commits (buf)" })
                    map("n", L "fd", C "Pick diagnostic scope='all'", { desc = "Diagnostic (workspace)" })
                    map("n", L "fD", C "Pick diagnostic scope='current'", { desc = "Diagnostic (buf)" })
                    map("n", L "fg", C "Pick grep_live", { desc = "Grep live" })
                    map("n", L "fG", C "Pick grep pattern='<cword>'", { desc = "Grep current word" })
                    map("n", L "fh", C "Pick help", { desc = "Help tags" })
                    map("n", L "fH", C "Pick hl_groups", { desc = "Highlight groups" })
                    map("n", L "fl", C "Pick buf_lines scope='all' preserver_order=true", { desc = "Lines (all)" })
                    map("n", L "fL", C "Pick buf_lines scope='current' preserver_order=true", { desc = "Lines (buf)" })
                    map("n", L "fm", C "Pick git_hunks", { desc = "Modified hunks (all)" })
                    map("n", L "fM", C "Pick git_hunks path='%'", { desc = "Modified hunks (buf)" })
                    map("n", L "fr", C "Pick lsp scope='references'", { desc = "References (LSP)" })
                    map("n", L "fs", C "Pick lsp scope='workspace_symbol_live'", { desc = "Symbols (workspace)" })
                    map("n", L "fS", C "Pick lsp scope='document_symbol'", { desc = "Symbols (buf)" })
                    map("n", L "fv", C "Pick visit_paths cwd=''", { desc = "Visit (all)" })
                    map("n", L "fV", C "Pick visit_paths", { desc = "Visit (cwd)" })
                    map("n", L "fe", C "Pick commands", { desc = "Commands" })
                    map("n", L "f'", C "Pick marks scope='all'", { desc = "Marks (all)" })
                    map("n", L "f`", C "Pick marks scope='buf'", { desc = "Marks (buf)" })
                    map("n", L 'f"', C "Pick registers", { desc = "Registers" })
                end,

                on_plugin = "mini.extra",
            }
        end,
    }
)

-- Helper functionality =======================================================

--- Buffer picker with modified indicator
---
---@param config Config
function H.buffers_with_indication(config)
    local ns = vim.api.nvim_create_namespace("havix-modified-buffer-markers")

    MiniPick.registry.buffers = function(local_opts)
        local add_modified_marker = function(buf_id, row)
            local modified_opts = {
                virt_text = { { config.icons.git.modified, "DiagnosticHint" } },
                virt_text_pos = "eol"
            }
            vim.api.nvim_buf_set_extmark(buf_id, ns, row, 0, modified_opts)
        end
        local show_with_modified_marker = function(buf_id, items, query)
            MiniPick.default_show(buf_id, items, query, { show_icons = true })
            for i, item in ipairs(items) do
                if vim.bo[item.bufnr].modified then add_modified_marker(buf_id, i - 1) end
            end
        end
        local opts = { source = { show = show_with_modified_marker } }
        MiniPick.builtin.buffers(local_opts, opts)
    end
end

-- Module Exports =============================================================

return manager
