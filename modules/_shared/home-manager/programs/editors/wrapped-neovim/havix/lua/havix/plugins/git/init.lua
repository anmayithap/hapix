-- ============================================================================
-- [HAVIX] Plugins > Git
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')

-- Module Definition ==========================================================

local manager = Factory.new({
  'havix.plugins.git.mini-diff',
  'havix.plugins.git.mini-git',
})

return manager
