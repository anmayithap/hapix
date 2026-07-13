-- ============================================================================
-- [HAVIX] Plugins > IDE > Completion > mini.completion
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')
---@type AutocmdC
local Autocmd = require('havix.util.autocmds')

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new({}, {
  {
    'mini.completion',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'completion',

    after = function()
      local m = require('mini.completion')

      m.setup({
        lsp_completion = {
          source_func = 'omnifunc',
          auto_setup = false,
          process_items = H.process_items,
        },

        window = {
          info = {
            border = vim.o.winborder or 'bold',
          },
          signature = {
            border = vim.o.winborder or 'bold',
          },
        },
      })

      Autocmd.new('LspAttach', {
        pattern = '*',
        callback = H.configure_completion,
        desc = '[COMPLETION]: Configure omnifunc',
      })

      vim.lsp.config('*', { capabilities = m.get_lsp_capabilities() })
    end,

    lazy = false,
  },
})

-- Helper data ================================================================

--- Completion items options
H.process_items_opts = {
  kind_priority = {
    Text = -1, -- Don't show 'Text' suggestions
    Snippet = 99,
  },
}

-- Helper functionality =======================================================

--- Configure completion
---
---@type fun(args: vim.api.keyset.create_autocmd.callback_args)
function H.configure_completion(args)
  vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
end

--- Process LSP Items
---
---@param items any[]
---@param base string
---@return any[]
function H.process_items(items, base)
  return MiniCompletion.default_process_items(items, base, H.process_items_opts)
end

-- Module Exports =============================================================

return manager
