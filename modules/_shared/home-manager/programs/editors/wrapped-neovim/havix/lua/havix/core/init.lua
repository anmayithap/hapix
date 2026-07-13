-- ============================================================================
-- [HAVIX] Core
-- ============================================================================

---@type ManagerC
local manager_factory = require('havix.util.manager')

local manager = manager_factory.new({
  'havix.core.options',
  'havix.core.mappings',
  'havix.core.autocmds',
})

return manager
