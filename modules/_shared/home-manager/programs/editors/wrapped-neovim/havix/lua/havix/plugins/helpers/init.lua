-- ============================================================================
-- [HAVIX] Plugins > Helpers
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')

-- Module Definition ==========================================================

local manager = Factory.new({
  'havix.plugins.helpers.clues',
  'havix.plugins.helpers.extra',
})

-- Module Exports =============================================================

return manager
