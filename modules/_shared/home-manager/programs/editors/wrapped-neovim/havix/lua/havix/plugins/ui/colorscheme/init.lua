-- ============================================================================
-- [HAVIX] Plugins > UI > Colorscheme
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')

-- Module Definition ==========================================================

local manager = Factory.new({
  'havix.plugins.ui.colorscheme.ayu',
  'havix.plugins.ui.colorscheme.kanagawa',
}, {
  function(_, opts)
    return {
      'trigger_colorscheme',
      for_spec = 'colorscheme',

      load = function() vim.cmd.colorscheme(opts.settings.colorscheme.name) end,

      event = 'VimEnter',
    }
  end,
})

-- Module Exports =============================================================

return manager
