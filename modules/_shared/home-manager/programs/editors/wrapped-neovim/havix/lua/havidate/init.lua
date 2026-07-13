--- *havidate* Additional validation for Neovim and Lua
---
--- MIT License Copyright (c) 2026 Ruslan Torbeev

---@alias __version string Semantic version string e.g. `0.10.0`

-- Module Requirements ========================================================

---@type __module_error
local Error = nil
-- Falls back too built-in `error()` without module prefix if `haverr` is unavailable
local ok, ErrorModule = pcall(require, 'haverr')

if ok then
  ---@type __module_error
  Error = ErrorModule.as_module('havidate')
else
  Error = error
end

-- Module Definition ==========================================================
local Havidate = {}

--- Validate the type of an argument
---
--- Supports both Lua primitive types (via `type()`) and callable validators.
--- Callable validators must return `(boolean, string?)` - a success flag and
--- an optional failure message.
---
--- Skips validation entirely when {value} is `nil` and {optional} is `true`
---
---@param name string Argument name (used in error messages)
---@param value any Value to validate
---@param validator vim.validate.Validator Type string (e.g. `'string'`, `'number'`) or a predicate `fun(v): boolean, string?`
---@param optional boolean? When `true`, 'nil' values are accepted without error
---@param message string? Custom error message (overrides the default)
Havidate.check_type = function(name, value, validator, optional, message)
  if value == nil and optional then return end

  local _ok = false
  local validator_message = nil

  if vim.is_callable(validator) then
    -- Validator is a predicate: call it and capture optional failure message
    _ok, validator_message = validator(value)
  elseif type(validator) == 'string' then
    if validator == 'callable' then
      _ok = vim.is_callable(value)
    else
      -- Validator is a Lua type name: compare with type()
      _ok = type(value) == validator
    end
  end

  if not _ok then
    Error(
      message
        or validator_message
        or string.format(
          '`%s` should be %s, not %s',
          name,
          validator,
          type(value)
        )
    )
  end
end

--- Assert that the current Neovim version satisfies a minimum requirement.
---
--- Uses |vim.fn.has()| internally, so the version string must follow the
--- `'nvim-X.Y.Z'` convention (major.minor.patch)
---
---@param required __version Minimum required version e.g. `'0.10.0'`
Havidate.check_neovim_version = function(required)
  if vim.fn.has('nvim-' .. required) ~= 1 then
    Error(
      ('Neovim >= %s required, current version is %s'):format(
        required,
        tostring(vim.version())
      )
    )
  end
end

-- Module export ==============================================================

return Havidate
