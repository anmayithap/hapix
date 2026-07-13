-- ============================================================================
-- [HAVIX] Plugins > UI > Colorscheme > kanagawa
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')

-- Module Definition ==========================================================

local manager = Factory.new({}, {
  function(_, config)
    return {
      'kanagawa-nvim',
      auto_enable = true,
      disable_for_vscode = true,
      for_spec = 'colorscheme',

      after = function() end,

      colorscheme = config.settings.colorscheme.name,
    }
  end,
})

-- Module Exports =============================================================

return manager
