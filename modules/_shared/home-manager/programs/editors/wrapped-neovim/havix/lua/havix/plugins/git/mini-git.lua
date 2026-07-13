-- ============================================================================
-- [HAVIX] Plugins > Git > mini.git
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')
---@type MappingC
local Mapping = require('havix.util.mappings')
---@type AutocmdC
local Autocmd = require('havix.util.autocmds')

local map = Mapping.map
local L = Mapping.L
local C = Mapping.C

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new({}, {
  {
    'mini.git',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'git',

    after = function()
      local git = require('mini.git')

      git.setup({
        command = {
          split = 'vertical',
        },
      })

      map('n', L('ga'), C('Git diff --cached'), { desc = 'Added diff' })
      map(
        'n',
        L('gA'),
        C('Git diff --cached -- %'),
        { desc = 'Added diff buffer' }
      )
      map('n', L('gc'), C('Git commit'), { desc = 'Commit' })
      map('n', L('gC'), C('Git commit --amend'), { desc = 'Commit append' })
      map('n', L('gd'), C('Git diff'), { desc = 'Diff' })
      map('n', L('gD'), C('Git diff -- %'), { desc = 'Diff buffer' })
      map('n', L('gl'), C('Git log --topo-order'), { desc = 'Log' })
      map(
        'n',
        L('gL'),
        C('Git log --topo-order --follow -- %'),
        { desc = 'Log buffer' }
      )
      map('n', L('gs'), H.show_at_cursor, { desc = 'Show at cursor' })
      map('x', L('gs'), H.show_at_cursor, { desc = 'Show at selection' })

      Autocmd.new('FileType', {
        pattern = { 'git', 'diff' },
        callback = function()
          vim.opt_local.foldmethod = 'expr'
          vim.opt_local.foldexpr = 'v:lua.MiniGit.diff_foldexpr()'
        end,
        desc = '[GIT]: Configure folding',
      })
    end,

    lazy = false,
  },
})

-- Helper functionality =======================================================

function H.configure_mappings()
  local mappings = {
    { 'n', L('ga'), C('Git diff --cached'), { desc = 'Added diff' } },
  }

  for _, mapping in ipairs(mappings) do
    map(unpack(mapping))
  end
end

--- Show git related info at cursor
function H.show_at_cursor()
  MiniGit.show_at_cursor({ split = MiniGit.config.command.split })
end

-- Module Exports =============================================================

return manager
