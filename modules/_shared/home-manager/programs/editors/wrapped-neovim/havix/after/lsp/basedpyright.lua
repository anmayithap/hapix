-- ============================================================================
-- [HAVIX] LSP > basedpyright
-- ============================================================================

-- Module definition ==========================================================

local H = {}

-- Helper functionality =======================================================

--- Filter for noisy notifications
function H.filter_noisy_notifications(err, result, ctx)
    -- Just notify once (at every buffer)
    if result.token == (vim.b.basedpyright_progress_token or result.token) then
        vim.b.basedpyright_progress_token = result.token
        vim.lsp.handlers["$/progress"](err, result, ctx)
    end
end

-- Module exports =============================================================

return {
    handlers = {
        ['$/progress'] = H.filter_noisy_notifications,
    },

    settings = {
        basedpyright = {
            disableOrganizeImports = true, -- `ruff` is used for this
            disableTaggedHints = false,

            analysis = {
                ignore = { "*" },                 -- Ignore all files for analysis to exclusively `ruff` for linting
                autoImportCompletions = false,    -- Determines whether pyright offers auto-import completions
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", -- Determines whether pyright analyzes
                typeCheckingMode = "off",         -- `mypy` or `ty` used for this

                inlayHints = {
                    callArgumentNames = true,
                    callArgumentNamesMatching = false,
                    functionReturnTypes = true,
                    genericTypes = true,
                    useTypingExtension = false,
                    autoFormatStrings = false,
                }
            }
        }
    }
}
