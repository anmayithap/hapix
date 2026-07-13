--- *haverr* Error utility for Neovim modules
---
--- MIT License Copyright (c) 2026 Ruslan Torbeev

---@alias __message string Error message
---@alias __module string Module name used as error prefix
---@alias __level integer Error level following Lua `error()` semantics
---| 0 # No position information added to message
---| 1 # Points to where `error()` was called
---| 2 # Points to where the caller of `error()` was called (most useful for end-users)
---@alias __module_error fun(message: string, level: __level?): nil

-- Module Definition ==========================================================
local Haverr = {}
local H = {}

--- Create a namespaced error function bound to a module name.
--- All errors thrown via the returned function will be prefixed with `(module)`.
---
---@param module __module
---@return __module_error
Haverr.as_module = function(module) return H.new_namespace(module) end

--- Throw an error, optionally namespaced and with a specific error level.
--- Defaults to level `0`.
---
---@param message __message
---@param module __module?
---@param level __level?
---@return nil error
Haverr.error = function(message, module, level)
  return H.new(message, module, level)
end

-- Helper data ================================================================

---@type __level
H.default_level = 0

-- Helper functionality =======================================================

---@param message __message
---@param module __module?
---@param level __level?
---@return nil error
H.new = function(message, module, level)
  local prefix = ''

  if module ~= nil then prefix = '(' .. module .. ') ' end

  error(prefix .. message, level or H.default_level)
end

---@param module __module
---@return __module_error module_error
H.new_namespace = function(module)
  ---@param message string
  ---@param level __level?
  ---@return nil error
  return function(message, level) return H.new(message, module, level) end
end

-- Module export ==============================================================

return Haverr
