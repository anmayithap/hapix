-- ============================================================================
-- [HAVIX] Plugins > Git > mini.diff
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')
---@type MappingC
local Mapping = require('havix.util.mappings')
---@type HavixError
local error = require('havix.util.error')('havix.plugins.git.mini-diff')

local map = Mapping.map
local L = Mapping.L

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new({}, {
  {
    'mini.diff',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'git',

    after = function()
      local diff = require('mini.diff')

      diff.setup({
        view = {
          style = 'sign',

          signs = {
            add = '▎',
            change = '▎',
            delete = '',
          },
        },

        options = {
          wrap_goto = true,
        },
      })

      map('n', L('go'), H.toggle_overlay, { desc = 'Toggle overlay' })
      map('n', L('gq'), H.toggle_diff_quickfix, { desc = 'Quickfix diffs' })
    end,

    lazy = false,
  },
})

-- Helper functionality =======================================================

--- Toggle diff overlay
function H.toggle_overlay()
  local buffer = vim.api.nvim_get_current_buf()

  if vim.api.nvim_buf_is_valid(buffer) then MiniDiff.toggle_overlay(buffer) end
end

--- Toggle diff quickfix list
function H.toggle_diff_quickfix()
  if _G.Config == nil then
    error('`_G.Config` is not defined to toggle quickfix list')
  else
    vim.fn.setqflist(MiniDiff.export('qf'))
    _G.Config.quickfix_toggler()
  end
end

-- Module Exports =============================================================

return manager
