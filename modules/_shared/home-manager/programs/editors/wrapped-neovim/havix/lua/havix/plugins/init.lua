-- ============================================================================
-- [HAVIX] Plugins
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')

-- Module Definition ==========================================================

local manager = Factory.new({
  'havix.plugins.ui',
  'havix.plugins.helpers',
  'havix.plugins.navigation',
  'havix.plugins.git',
  'havix.plugins.ide',
  'havix.plugins.languages',
})

-- Module Exports =============================================================

return manager
