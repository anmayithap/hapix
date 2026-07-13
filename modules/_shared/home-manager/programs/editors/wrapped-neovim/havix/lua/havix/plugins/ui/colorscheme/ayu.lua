-- ============================================================================
-- [HAVIX] Plugins > UI > Colorscheme > Ayu
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new({}, {
  function(_, config)
    return {
      'trigger_configure_ayu',
      auto_enable = true,
      disable_for_vscode = true,
      for_spec = 'colorscheme',

      after = function()
        require('ayu').setup()
      end,

      colorscheme = config.settings.colorscheme.name,
    }
  end,
})

-- Module Exports =============================================================

return manager
