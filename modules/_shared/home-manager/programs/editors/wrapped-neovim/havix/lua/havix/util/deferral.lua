-- ============================================================================
-- [HAVIX] Util > Deferral
-- ============================================================================

-- Module Requirements ========================================================

---@module "havix.util.validation"
local validator = require('havix.util.validation')
---@type HavixError
local error = require('havix.util.error')('havix.util.deferral')

-- Module Definition ==========================================================

local H = {}

--- HAVIX deferral constructor
--- @class (exact) DeferralC
--- @field new fun(config: Config): Deferral
--- @field handlers (fun(config: Config): lze.Handler | lze.HandlerSpec)[]
local DeferralC = {}

-- Helper functionality =======================================================

--- `Deferral` constructor
--- Allowed deferral executors:
--- 1. lze (with mini.misc)
--- @class (exact) Deferral: lze
--- @field later DeferralLaterWrapper

--- @alias DeferralLaterExecutor fun()
--- @alias DeferralLaterWrapper fun(executor: DeferralLaterExecutor)

--- @param config Config
--- @return Deferral
function H.new(config)
  validator.check_type('config', config, 'table')
  validator.check_type('deferral', config.settings.deferral, 'table')
  validator.check_type('specs', config.settings.specs, 'table')

  local deferral_config = config.settings.deferral
  local specs = config.settings.specs

  if not deferral_config.enable then error('`deferral` spec is disabled') end

  if not specs['deferral'] or not config.plugin(deferral_config.pname) then
    error('deferral plugin `' .. deferral_config.pname .. '` is not installed')
  end

  if not config.plugin('mini.misc') then
    error('`mini.misc` is required plugin for later execution')
  end

  local deferral = nil

  if deferral_config.name == 'lze' then
    deferral = require(deferral_config.name)
  else
    error(
      'this deferral plugin `' .. deferral_config.name .. '` is not supported'
    )
  end

  local misc = require('mini.misc')

  deferral.later = function(f) misc.safely('later', f) end

  return deferral
end

--- `Deferral` auto enable handler
--- Allows control whether the plugin is enabled
--- 1. If the plugin is not in the `RUNTIMEPATH`, then false
--- 2. If the plugin is in the `RUNTIMEPATH`, then true
---
--- @param config Config
--- @return lze.Handler
function H.new_auto_enable_handler(config)
  return {
    spec_field = 'auto_enable',
    set_lazy = false,
    modify = function(plugin)
      if type(plugin.auto_enable) == 'table' then
        for _, name in pairs(plugin.auto_enable) do
          if not config.plugin(name) then
            plugin.enabled = false
            break
          end
        end
      elseif type(plugin.auto_enable) == 'string' then
        if not config.plugin(plugin.auto_enable) then plugin.enabled = false end
      elseif type(plugin.auto_enable) == 'boolean' and plugin.auto_enable then
        if not config.plugin(plugin.name) then plugin.enabled = false end
      end

      return plugin
    end,
  }
end

--- `Deferral` for spec handler
--- Allows loading plugins based on their specifications - `MetaData.settings.specs`
---
--- @param config Config
--- @return lze.Handler
function H.new_spec_handler(config)
  return {
    spec_field = 'for_spec',
    set_lazy = false,
    modify = function(plugin)
      if type(plugin.for_spec) == 'string' then
        plugin.enabled = config.settings.specs[plugin.for_spec] or false
      end

      return plugin
    end,
  }
end

--- `Deferral` Visual Studio Code control handler
--- If current Neovim environment contains `vim.g.vscode`
--- force disabling plugin
---
--- @param _ Config
--- @return lze.Handler
function H.new_vscode_handler(_)
  return {
    spec_field = 'disable_for_vscode',
    set_lazy = false,
    modify = function(plugin)
      if vim.g.vscode and plugin.enabled then plugin.enabled = false end

      return plugin
    end,
  }
end

--- `Deferral` Nix control handler
--- If current Neovim environment managing by Nix
--- then enable, else disable
---
--- @param config Config
--- @return lze.Handler
function H.new_nix_handler(config)
  return {
    spec_field = 'with_nix',
    set_lazy = false,
    modify = function(plugin)
      if type(plugin.with_nix) == 'boolean' then
        if plugin.with_nix and not config.is_nix and plugin.enabled then
          plugin.enabled = false
        else
          if not plugin.with_nix and config.is_nix and plugin.enabled then
            plugin.enabled = false
          end
        end
      end

      return plugin
    end,
  }
end

-- Module Exports =============================================================

DeferralC.new = H.new
DeferralC.handlers = {
  H.new_auto_enable_handler,
  H.new_spec_handler,
  H.new_vscode_handler,
  H.new_nix_handler,
}

return DeferralC
