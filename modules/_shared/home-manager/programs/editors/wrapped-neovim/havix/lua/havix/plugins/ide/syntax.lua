-- ============================================================================
-- [HAVIX] Plugins > Ide > Treesitter
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.autocmds"
local Autocmd = require("havix.util.autocmds")

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new(
    {},
    {
        function(deferral, _)
            return {
                "nvim-treesitter",
                auto_enable = true,
                disable_for_vscode = false,
                for_spec = "syntax",

                after = function()
                    local treesitter = require("nvim-treesitter")

                    Autocmd.new("FileType", {
                        callback = function(opts)
                            local available = treesitter.get_available()

                            local buffer, filetype = opts.buf, opts.match
                            local language = vim.treesitter.language.get_lang(filetype)

                            if not language then
                                return
                            end

                            if not H.try_attach(buffer, language) then
                                if vim.tbl_contains(available, language) then
                                    -- not already installed, so try to install them via nvim-treesitter if possible
                                    treesitter.install(language):await(
                                        function()
                                            H.try_attach(buffer, language)
                                        end
                                    )
                                end
                            end
                        end,
                        desc = "[SYNTAX]: Try installing treesitter parsers",
                    })
                end,

                lazy = false,
            }
        end,
        {
            "nvim-treesitter-textobjects",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "syntax",

            before = function()
                -- Disable entire built-in ftplugin mappings to avoid conflicts.
                -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
                vim.g.no_plugin_maps = true
            end,

            lazy = false,
        },
        {
            "nvim-treesitter-context",
            auto_enable = true,
            disable_for_vscode = false,
            for_spec = "syntax",

            lazy = false,
        }
    }
)

-- Helper functionality =======================================================

--- Try attaching treesitter parser
---
---@param buffer integer
---@param language string
---@return boolean
function H.try_attach(buffer, language)
    if not vim.api.nvim_buf_is_valid(buffer) then
        return false
    end

    -- check if parser exists and load it
    if not vim.treesitter.language.add(language) then
        return false
    end

    -- enables syntax highlighting and other treesitter features
    vim.treesitter.start(buffer, language)

    return true
end

-- Module Exports =============================================================

return manager
