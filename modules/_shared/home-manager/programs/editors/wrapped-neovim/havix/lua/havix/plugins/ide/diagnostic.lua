-- ============================================================================
-- [HAVIX] Plugins > IDE > Diagnostic
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')
---@type FunctionC
local Function = require('havix.util.functions')

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new({}, {
  function(deferral, config)
    return {
      'trigger_configure_diagnostics',

      load = function()
        deferral.later(function()
          vim.diagnostic.config({
            -- Show all diagnostics as underline
            underline = {
              severity = {
                min = 'HINT',
                max = 'ERROR',
              },
            },

            virtual_text = {
              current_line = true,

              source = 'if_many',

              format = H.new_virtual_text_formatter(config),
            },

            -- Show signs on top of any other sign, but only for warnings and errors
            signs = {
              text = H.provide_icon_map(config),
              priority = 9999,
              severity = { min = 'WARN', max = 'ERROR' },
            },

            float = {
              source = 'if_many',
            },

            severity_sort = true, -- Sort diagnostics by severity
          })
        end)
      end,

      lazy = false,
    }
  end,
})

-- Helper functionality =======================================================

--- Provides icons map by severity
---
---@param config Config
---@return table<string, string>
function H.provide_icon_map(config)
  return {
    [vim.diagnostic.severity.HINT] = config.icons.diagnostic.hint,
    [vim.diagnostic.severity.INFO] = config.icons.diagnostic.info,
    [vim.diagnostic.severity.WARN] = config.icons.diagnostic.warn,
    [vim.diagnostic.severity.ERROR] = config.icons.diagnostic.error,
  }
end

--- Virtual text formatter factory
---
---@param config Config
---@return fun(diagnostic: {severity: string, message: string, col: integer, end_col: integer}): string
function H.new_virtual_text_formatter(config)
  return function(diagnostic)
    local input_severity = diagnostic.severity

    local icon = H.provide_icon_map(config)[input_severity]

    local message = (icon .. ': ' or '') .. diagnostic.message

    -- Message transformation
    --
    -- 1. Replace all newlines with dots
    -- 2. Trim all spaces with single spaces
    -- 3. Remove all spaces at the beginning and end
    local result = message:gsub('\n', '.'):gsub('%s+', ' ')
    result = result:match('^%s*(.-)%s*$')

    -- Finally truncate result message by window width
    return Function.trunc_by_width(result, {
      start_col = diagnostic.col,
      padding = { right = 3 },
    })
  end
end

-- Module Exports =============================================================

return manager
