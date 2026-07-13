-- ============================================================================
-- [HAVIX] Plugins > Languages > Python
-- ============================================================================

-- Module Requirements ========================================================

---@module "lua.havix.util.manager"
local Factory = require('havix.util.manager')
---@module "lua.havix.util.functions"
local Function = require('havix.util.functions')

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new({}, {
  {
    'trigger_lua_lsp_enable',
    for_spec = 'lua',
    disable_for_vscode = true,

    load = function()
      vim.lsp.enable({
        'lua_ls',
      })
    end,
  },
  function(_, config)
    return {
      'lazydev.nvim',
      auto_enable = true,
      for_spec = 'lua',
      disable_for_vscode = true,

      after = function()
        local deferral_path = H.provide_deferral_library(config)

        require('lazydev').setup({
          library = {
            { path = deferral_path, words = { 'deferral', 'Deferral', 'lze' } },
          },
        })
      end,

      ft = 'lua',
    }
  end,
  function(deferral, config)
    return {
      'trigger_lua_formatter_enable',
      for_spec = 'lua',
      disable_for_vscode = true,

      load = function()
        local conform = Function.try_conform(deferral, config)

        conform.formatters_by_ft.lua = {
          'stylua',
        }
      end,

      on_plugin = 'conform.nvim',
    }
  end,
})

-- Helper functionality =======================================================

--- Provides deferral library path
---@param config Config
---@return string path
function H.provide_deferral_library(config)
  ---@type string
  local pname = config.settings.deferral.pname

  return config.plugin(pname) .. '/lua'
end

-- Module Exports =============================================================

return manager
