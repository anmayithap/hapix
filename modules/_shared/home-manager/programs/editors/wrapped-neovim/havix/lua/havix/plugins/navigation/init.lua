-- ============================================================================
-- [HAVIX] Plugins > Navigation
-- ============================================================================

local manager_factory = require("havix.util.manager")

local manager = manager_factory.new(
    {
        "havix.plugins.navigation.explorer",
        "havix.plugins.navigation.picker",
        "havix.plugins.navigation.session",
    }
)

return manager
