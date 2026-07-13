-- ============================================================================
-- [HAVIX] Plugins > Helpers > Clues
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')

-- Module Definition ==========================================================

local manager = Factory.new({
  'havix.plugins.helpers.clues.mini-clue',
})

-- Module Exports =============================================================

return manager
