-- ============================================================================
-- [HAVIX] Util > Validation
-- ============================================================================

-- Module Requirements ========================================================

--- @type HavixError
local error = require('havix.util.error')('hapix.validation')

-- Module Definition ==========================================================

local H = {}

--- `ValidatorC` collection of validators
--- @class (exact) ValidatorC
--- @field check_type fun(name: string, value: any, ref: string, allow_nil: boolean?)
--- @field check_version fun(version: string)
local ValidatorC = {}

-- Helper functionality =======================================================

--- Checks type of value
---
--- @param name string
--- @param value any
--- @param ref string
--- @param allow_nil boolean?
--- @return nil | nil error
function H.check_type(name, value, ref, allow_nil)
  if
    type(value) == ref
    or (ref == 'callable' and vim.is_callable(value))
    or (allow_nil and value == nil)
  then
    return
  end
  error(string.format('`%s` should be %s, not %s', name, ref, type(value)))
end

--- Checks Neovim version
---
--- @param version string
--- @return nil | nil error
function H.check_version(version)
  if not version:match('%d+%.%d+%.%d+') then
    error('`version` should be in format `major.minor.patch`. Now: ' .. version)
  end

  if vim.fn.has('nvim-' .. version) ~= 1 then
    error('neovim >= ' .. version .. ' is required')
  end
end

-- Module Exports =============================================================

ValidatorC.check_type = H.check_type
ValidatorC.check_version = H.check_version

return ValidatorC
