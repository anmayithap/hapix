-- ============================================================================
-- [HAVIX] Util > Functions
-- ============================================================================

-- Module Requirements ========================================================

---@module "havix.util.validation"
local Validator = require('havix.util.validation')
---@type HavixError
local error = require('havix.util.error')('havix.util.functions')

-- Module Definition ==========================================================

local H = {}

--- @class (exact) FunctionC
--- @field new_scratch_buffer fun() Open a new scratch buffer
--- @field get_filetype_icon fun() Provides icon and those highlight for current buffer filetype
--- @field new_quickfix_toggler fun(deferral: Deferral, config: Config): fun()
--- @field new_locations_toggler fun(deferral: Deferral, config: Config): fun()
--- @field toggle_quickfix fun()
--- @field toggle_locations fun()
--- @field toggle_diagnostic_quickfix fun()
--- @field toggle_diagnostic_locations fun()
--- @field trunc_by_width fun(str: string, args: TruncArgs): string
--- @field try_conform fun(deferral: Deferral, config: Config): table
--- @field try_nvim_lint fun(deferral: Deferral, config: Config): table
local FunctionC = {}

-- Helper functionality =======================================================

--- Open a new scratch buffer in the current window.
--- This differs from
--- `:enew` in that it creates a new empty buffer rather than reusing
--- the existing empty buffer if one exists. It also sets the buffer to
--- be a scratch buffer (i.e. not listed, not saved to disk).
H.new_scratch_buffer = function()
  local buffer = vim.api.nvim_create_buf(true, true)

  vim.api.nvim_win_set_buf(0, buffer)
end

--- Provides icon and those highlight for current filetype.
---
--- NOTE: Require `mini.icons` plugin
---
--- @return string? icon
--- @return string? highlight
H.get_filetype_icon = function()
  ---@diagnostic disable-next-line: undefined-field
  if _G.MiniIcons ~= nil then
    ---@diagnostic disable-next-line: undefined-global
    local icon, hl, _ = MiniIcons.get('filetype', vim.bo.filetype)

    return icon, hl
  end

  return nil, nil
end

--- Toggle quickfix list
---
--- @param deferral Deferral
--- @param config Config
--- @return fun()
H.new_quickfix_toggler = function(deferral, config)
  return function()
    local quicker_exists = config.plugin('quicker.nvim') ~= nil
    local quicker_enabled = deferral.state('quicker.nvim') == false

    if quicker_exists and quicker_enabled then
      require('quicker').toggle({ focus = true })
    else
      local win_quickfix = vim.fn.getqflist({ winid = true })

      if win_quickfix.winid ~= 0 then
        vim.cmd('cclose')
      else
        vim.cmd('copen')
      end
    end
  end
end

--- Toggle location list
---
--- @param deferral Deferral
--- @param config Config
--- @return fun()
H.new_locations_toggler = function(deferral, config)
  return function()
    local quicker_exists = config.plugin('quicker.nvim') ~= nil
    local quicker_enabled = deferral.state('quicker.nvim') == false

    if quicker_exists and quicker_enabled then
      require('quicker').toggle({ focus = true, loclist = true })
    else
      local win_location_list = vim.fn.getloclist(0, { winid = true })

      if win_location_list.winid ~= 0 then
        vim.cmd('lclose')
      else
        vim.cmd('lopen')
      end
    end
  end
end

-- Toggle quickfix list
H.toggle_quickfix = function()
  if _G.Config == nil then
    error('`GlobalConfig` is not defined to toggle quickfix')
  else
    _G.Config.quickfix_toggler()
  end
end

--- Toggle location list
H.toggle_locations = function()
  if _G.Config == nil then
    error('`GlobalConfig` is not defined to toggle location list')
  else
    _G.Config.locations_toggler()
  end
end

--- Toggle diagnostic quickfix list
H.toggle_diagnostic_quickfix = function()
  if _G.Config == nil then
    error('`GlobalConfig` is not defined to toggle diagnostic quickfix')
  else
    vim.diagnostic.setqflist({
      open = false,
    })

    _G.Config.quickfix_toggler()
  end
end

--- Toggle diagnostic location list
H.toggle_diagnostic_locations = function()
  if _G.Config == nil then
    error('`GlobalConfig` is not defined to toggle diagnostic loclist')
  else
    vim.diagnostic.setloclist({
      open = false,
    })

    _G.Config.locations_toggler()
  end
end

--- Truncate string by current window width

--- @class TruncArgs
--- @field start_col integer? Position of the first str character
--- @field end_col integer? Position of the last str character
--- @field padding TruncPadding | integer | nil Additional padding for the string

--- @class TruncPadding
--- @field left integer? Left padding (columns)
--- @field right integer? Right padding (columns)

--- @param str string Target string which will be truncated
--- @param args TruncArgs Truncate arguments
--- @return string nil Truncated string
H.trunc_by_width = function(str, args)
  Validator.check_type('args', args, 'table')

  local from_start = args.start_col or 1
  local to_end = args.end_col or #str

  local left_padding, right_padding = 0, 0

  if args.padding ~= nil then
    local padding = args.padding

    if type(padding) == 'number' then
      left_padding, right_padding = padding, padding
    elseif type(padding) == 'table' then
      left_padding, right_padding = padding.left or 0, padding.right or 0
    end
  end

  local max_width = vim.o.laststatus == 3 and vim.o.columns
    or vim.api.nvim_win_get_width(0)

  local prepared_max_width = max_width
    - left_padding
    - right_padding
    - from_start

  local extends = '…'

  if to_end < prepared_max_width then return str end

  local result = str:sub(1, prepared_max_width - #extends) .. extends

  return result:match('^%s*(.-)%s*$')
end

--- Try to get access to conform.nvim
---
--- @param deferral Deferral
--- @param config Config
--- @return table confrom
H.try_conform = function(deferral, config)
  local conform_exists = config.plugin('conform.nvim') ~= nil
  local conform_enabled = deferral.state('conform.nvim') == false

  if conform_exists and conform_enabled then
    return require('conform')
  else
    error('`conform.nvim` does not available')
  end
end

--- Try to get access to nvim-lint
---
--- @param deferral Deferral
--- @param config Config
--- @return table nvim-lint
H.try_nvim_lint = function(deferral, config)
  local lint_exists = config.plugin('nvim-lint') ~= nil
  local lint_enabled = deferral.state('nvim-lint') == false

  if lint_exists and lint_enabled then
    return require('lint')
  else
    error('`nvim-lint` does not available')
  end
end

-- Module Exports =============================================================

FunctionC.new_scratch_buffer = H.new_scratch_buffer
FunctionC.get_filetype_icon = H.get_filetype_icon
FunctionC.new_quickfix_toggler = H.new_quickfix_toggler
FunctionC.new_locations_toggler = H.new_locations_toggler
FunctionC.toggle_quickfix = H.toggle_quickfix
FunctionC.toggle_locations = H.toggle_locations
FunctionC.toggle_diagnostic_quickfix = H.toggle_diagnostic_quickfix
FunctionC.toggle_diagnostic_locations = H.toggle_diagnostic_locations
FunctionC.trunc_by_width = H.trunc_by_width
FunctionC.try_conform = H.try_conform
FunctionC.try_nvim_lint = H.try_nvim_lint

return FunctionC
