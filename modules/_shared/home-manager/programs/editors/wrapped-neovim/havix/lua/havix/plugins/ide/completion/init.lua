-- ============================================================================
-- [HAVIX] Plugins > IDE > Completion
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')

-- Module Definition ==========================================================

local manager = Factory.new({
  'havix.plugins.ide.completion.mini-completion',
})

-- Module Exports =============================================================

return manager
