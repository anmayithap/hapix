-- ============================================================================
-- [HAVIX] Health
-- ============================================================================

---@type ValidatorC
local Validator = require('havix.util.validation')
---@type MetaDataC
local Metadata = require('havix.util.metadata')
---@type ConfigC
local Config = require('havix.util.config')

-- Module Definition ==========================================================

local H = {}

-- Helper functionality =======================================================

--- HAVIX health check
function H.check()
  H.verify_minimal_version()
  H.provide_metadata()
end

--- Verify minimal version of Neovim
function H.verify_minimal_version()
  vim.health.start('Requirements:')

  local min_version = '0.12.0'

  local ok, _ = pcall(Validator.check_version, min_version)

  if not ok then
    vim.health.error('Neovim >= ' .. min_version .. ' is required')
  else
    vim.health.ok('Using Neovim >= ' .. min_version)
  end
end

--- Provide HAVIX metadata
function H.provide_metadata()
  vim.health.start('Metadata:')

  local metadata = Metadata.new()
  local config = Config.new(metadata, Metadata.getter(metadata))

  vim.health.info('is_nix: ' .. tostring(config.is_nix))
end

-- Module Exports =============================================================

return {
  check = H.check,
}
