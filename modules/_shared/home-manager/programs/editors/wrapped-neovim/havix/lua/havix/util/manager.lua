-- ============================================================================
-- [HAVIX] Util > Manager
-- ============================================================================

-- Module Definition ==========================================================

local H = {}

--- HAVIX plug in manager constructor
--- @class (exact) ManagerC
--- @field new fun(modules: string[], specs: ManagerSpec[]?): Manager
local ManagerC = {}

-- Helper functionality =======================================================

--- `Manager` constructor
---

--- @alias SpecFactory fun(deferral: Deferral, config: Config): lze.Spec[]
--- @alias ManagerSpec lze.Spec | SpecFactory

--- @param modules string[]
--- @param specs ManagerSpec[]?
--- @return Manager
function H.new(modules, specs)
  ---@type Manager[]
  local managers = {}
  ---@type ManagerSpec[]
  local manager_specs = specs or {}

  for _, module in ipairs(modules) do
    --- @type Manager
    local manager = require(module)

    if type(manager) == 'table' then table.insert(managers, manager) end
  end

  --- @class (exact) Manager
  --- @field managers Manager[]
  --- @field specs ManagerSpec[]?
  --- @field setup fun(deferral: Deferral, config: Config): lze.Spec[]
  local manager = {
    managers = managers,
    specs = manager_specs,

    setup = function(deferral, opts)
      for _, _manager in ipairs(managers) do
        _manager.setup(deferral, opts)

        for _, spec in ipairs(_manager.specs) do
          local result

          if type(spec) == 'function' then
            result = spec(deferral, opts)
          else
            result = spec
          end

          table.insert(manager_specs, result)
        end
      end

      return manager_specs
    end,
  }

  return manager
end

-- Module Exports =============================================================

ManagerC.new = H.new

return ManagerC
