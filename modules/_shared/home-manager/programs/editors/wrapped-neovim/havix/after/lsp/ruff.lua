-- ============================================================================
-- [HAVIX] LSP > ruff
-- ============================================================================

-- Module Requirements ========================================================

---@module ""
local Autocmd = require("havix.util.autocmds")

-- Module exports =============================================================

Autocmd.new("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client == nil then
            return
        end

        if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = "[LSP]: Disable hover capability from `ruff`",
})

return {
    init_options = {
        settings = {
            -- Take priority over the global config.
            -- Use 'ruff.toml' or 'pyproject.toml' as master config provider.
            configurationPreference = "filesystemFirst",
        },
    },
}
