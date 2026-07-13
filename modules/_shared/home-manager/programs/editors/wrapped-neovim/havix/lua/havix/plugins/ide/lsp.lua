-- ============================================================================
-- [HAVIX] Plugins > Ide > LSP
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.autocmds"
local Autocmd = require("havix.util.autocmds")
---@module "lua.havix.util.mappings"
local Mapping = require("havix.util.mappings")

local map = Mapping.map
local C = Mapping.C

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new(
    {},
    {
        function(deferral, _)
            return {
                "trigger_configure_lsp_globals",
                disable_for_vscode = true,

                load = function()
                    deferral.later(H.on_attach)
                end,

                lazy = false,
            }
        end,
        {
            "trigger_enable_specific_lsp",
            for_spec = "lsp",
            disable_for_vscode = true,

            load = function()
                vim.lsp.enable({
                    "harper_ls",
                    "taplo",
                    "typos_lsp",
                    "jsonls",
                    "yamlls",
                    "marksman"
                })
            end,

            lazy = false,
        },
        {
            "nvim-lint",
            auto_enable = true,
            disable_for_vscode = true,
            for_spec = "lsp",

            after = function()
                local lint = require("lint")

                lint.linters_by_ft = {
                    sh = { "shellcheck" },
                    bash = { "shellcheck" },
                    dockerfile = { "hadolint" },
                    python = { "mypy" },
                }

                Autocmd.new({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
                    callback = function()
                        local lint = require("lint")

                        lint.try_lint()
                    end,
                    desc = "[LINT]: Configure linters",
                })
            end,

            priority = 100, -- Default: 50

            lazy = false,
        }
    }
)

-- Helper functionality =======================================================

--- Set global configuration for LSPs
function H.on_attach()
    Autocmd.new("LspAttach", {
        callback = function(event)
            map("n", "gd", C "lua vim.lsp.buf.definition()", { desc = "Definition", buffer = event.buf })
            map("n", "gD", C "lua vim.lsp.buf.declaration()", { desc = "Declaration", buffer = event.buf })
            map("n", "grc", C "lua vim.lsp.buf.incoming_calls()", { desc = "Incoming calls", buffer = event.buf })
            map("n", "grC", C "lua vim.lsp.buf.outgoing_calls()", { desc = "Outgoing calls", buffer = event.buf })

            local client = vim.lsp.get_client_by_id(event.data.client_id)

            map("n", "\\I",
                function()
                    local is_enabled = vim.lsp.inline_completion.is_enabled({ bufnr = event.buf })
                    vim.lsp.inline_completion.enable(not is_enabled, { bufnr = event.buf })
                end,
                { desc = "Toggle 'inline_completion'", buffer = event.buf }
            )

            if client and client:supports_method('textDocument/inlayHint', event.buf) then
                map("n", "\\i",
                    function()
                        local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                        vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = event.buf })
                    end,
                    { desc = "Toggle 'inlay_hint'", buffer = event.buf }
                )
                vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
            end

            if client and client:supports_method("textDocument/codeLens", event.buf) then
                map("n", "\\l", C "lua vim.lsp.codelens.refresh()", { desc = "Toggle 'codelens'" })
            end
        end,
        desc = "[LSP]: Configure global mappings",
    })
end

-- Module Exports =============================================================

return manager
