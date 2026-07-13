-- ============================================================================
-- [HAVIX] Configuration
-- ============================================================================

-- Module Requirements ========================================================

---@type MetaDataC
local MetaData = require('havix.util.metadata')
---@type ConfigC
local Config = require('havix.util.config')
---@type DeferralC
local Deferral = require('havix.util.deferral')
---@module "havix.core"
local Core = require('havix.core')
---@module "havix.plugins"
local Plugins = require('havix.plugins')

-- Module Definition ==========================================================

local H = {}

---@class HavixC
---@field setup fun()
local HavixC = {}

-- Helper functionality =======================================================

function H.setup()
  local metadata = MetaData.new()
  local config = Config.new(metadata, MetaData.getter(metadata))

  local deferral = Deferral.new(config)

  Config.new_global(deferral, config)

  local handlers = {}

  for _, handler in ipairs(Deferral.handlers) do
    table.insert(handlers, handler(config))
  end

  deferral.register_handlers(handlers)

  Core.setup(deferral, config)

  local specs = Plugins.setup(deferral, config)

  deferral.load(specs)
end

-- Module Exports =============================================================

HavixC.setup = H.setup

return HavixC
