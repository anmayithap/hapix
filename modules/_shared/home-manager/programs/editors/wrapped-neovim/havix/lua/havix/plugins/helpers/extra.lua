-- ============================================================================
-- [HAVIX] Plugins > Helpers > Extra
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')
---@type MappingC
local Mapping = require('havix.util.mappings')

local map = Mapping.map
local L = Mapping.L
local C = Mapping.C

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new({}, {
  {
    'vim-be-good',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'helpers-extra',

    cmd = 'VimBeGood',
  },
  {
    'mini.bracketed',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'helpers-extra',

    after = function() require('mini.bracketed').setup() end,

    lazy = false,
  },
  {
    'mini.bufremove',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'helpers-extra',

    after = function()
      local m = require('mini.bufremove')

      m.setup()

      -- Delete mappings
      map('n', L('bd'), C('lua MiniBufremove.delete()'), { desc = 'Delete' })
      map(
        'n',
        L('bD'),
        C('lua MiniBufremove.delete(0, true)'),
        { desc = 'Delete!' }
      )

      -- `Unshow` mappings
      map('n', L('bu'), C('lua MiniBufremove.unshow()'), { desc = 'Unload' })
      map(
        'n',
        L('bU'),
        C('lua MiniBufremove.unshow(0, true)'),
        { desc = 'Unload!' }
      )

      -- `Wipeout` mappings
      map('n', L('bw'), C('lua MiniBufremove.wipeout()'), { desc = 'Wipeout' })
      map(
        'n',
        L('bW'),
        C('lua MiniBufremove.wipeout(0, true)'),
        { desc = 'Wipeout!' }
      )
    end,

    lazy = false,
  },
  {
    'mini.cmdline',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'helpers-extra',

    after = function()
      require('mini.cmdline').setup({
        autopeek = {
          window = {
            config = {
              border = vim.o.winborder or 'bold',
            },
          },
        },
      })
    end,

    event = 'CmdlineEnter',
  },
  {
    'mini.extra',
    auto_enable = true,
    disable_for_vscode = false,
    for_spec = 'helpers-extra',

    after = function() require('mini.extra').setup() end,

    priority = 100, -- Default: 50

    lazy = false,
  },
  {
    'mini.keymap',
    auto_enable = true,
    disable_for_vscode = false,
    for_spec = 'helpers-extra',

    after = function()
      local m = require('mini.keymap')

      m.setup()

      m.map_multistep(
        'i',
        '<Tab>',
        { 'minisnippets_next', 'minisnippets_expand', 'pmenu_next' }
      )
      m.map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'pmenu_prev' })
      m.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
      m.map_multistep('i', '<BS>', { 'minipairs_bs', 'hungry_bs' })
    end,

    lazy = false,
  },
  {
    'mini.pairs',
    auto_enable = true,
    disable_for_vscode = false,
    dor_spec = 'helpers-extra',

    after = function()
      require('mini.pairs').setup({
        modes = {
          insert = true,
          command = true,
          terminal = true,
        },
      })
    end,

    lazy = false,
  },
  function(_, config)
    return {
      'quicker.nvim',
      auto_enable = true,
      disable_for_vscode = true,
      for_spec = 'helpers-extra',

      after = function()
        local m = require('quicker')

        m.setup({
          opts = {
            wrap = vim.o.wrap,
          },
          keys = {
            { '>', H.expand_quickfix_context, desc = 'Expand context' },
            { '<', H.collapse_quickfix_context, desc = 'Collapse context' },
          },
          type_icons = {
            E = config.icons.diagnostic.error,
            W = config.icons.diagnostic.warn,
            I = config.icons.diagnostic.info,
            N = config.icons.diagnostic.info,
            D = config.icons.diagnostic.hint,
          },
        })
      end,

      ft = 'qf',
    }
  end,
  {
    'overseer.nvim',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'helpers-extra',

    after = function()
      require('overseer').setup({
        form = {
          border = vim.o.winborder or 'bold',
        },
        task_win = {
          border = vim.o.winborder or 'bold',
        },
      })
    end,

    lazy = false,
  },
  {
    'nvim.undotree',
    disable_for_vscode = true,

    after = function()
      map('n', '\\U', C('Undotree'), { desc = "Toggle 'undotree'" })
    end,

    lazy = false,
  },
  {
    'mini.misc',
    auto_enable = true,
    disable_for_vscode = true,

    after = function()
      require('mini.misc').setup()

      MiniMisc.setup_auto_root()
      MiniMisc.setup_restore_cursor()
      MiniMisc.setup_termbg_sync()

      map('n', L('wr'), C('lua MiniMisc.resize_window()'), { desc = 'Resize' })
      map('n', L('wz'), C('lua MiniMisc.zoom()'), { desc = 'Zoom' })
    end,

    lazy = false,
  },
  function(deferral, config)
    return {
      'mini.visits',
      auto_enable = true,
      disable_for_vscode = true,
      for_spec = 'helpers-extra',

      after = function()
        require('mini.extra')

        require('mini.visits').setup()

        map(
          'n',
          L('zc'),
          H.pick_visits(deferral, config, { cwd = '', label = 'core' }),
          { desc = 'Core visits (all)' }
        )
        map(
          'n',
          L('zC'),
          H.pick_visits(deferral, config, { cwd = nil, label = 'core' }),
          { desc = 'Core visits (buf)' }
        )
        map(
          'n',
          L('zz'),
          C("lua MiniVisits.add_label('core')"),
          { desc = "Add 'core' label" }
        )
        map(
          'n',
          L('zZ'),
          C("lua MiniVisits.remove_label('core')"),
          { desc = "Remove 'core' label" }
        )
        map(
          'n',
          L('za'),
          C('lua MiniVisits.add_label()'),
          { desc = 'Add label' }
        )
        map(
          'n',
          L('zA'),
          C('lua MiniVisits.remove_label()'),
          { desc = 'Remove label' }
        )
      end,

      lazy = false,
    }
  end,
})

-- Helper functionality =======================================================

--- Expand quickfix context
function H.expand_quickfix_context()
  require('quicker').expand({
    add_to_existing = true,
  })
end

--- Collapse quickfix context
function H.collapse_quickfix_context() require('quicker').collapse() end

--- mini.visits Picker
---
---@param deferral Deferral
---@param config Config
---@param opts { cwd: string?, label: string }
function H.pick_visits(deferral, config, opts)
  local mini_extra_exists = config.plugin('mini.extra') ~= nil
  local mini_extra_enabled = deferral.state('mini.extra') == false

  if mini_extra_exists and mini_extra_enabled then
    local cwd, label = opts.cwd, opts.label
    return function()
      local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
      local name = 'Visit ' .. label .. ' (' .. (cwd and 'all' or 'cwd') .. ')'
      local local_opts = { cwd = cwd, filter = label, sort = sort_latest }
      MiniExtra.pickers.visit_paths(local_opts, { source = { name = name } })
    end
  else
    error('`mini.extra` is required plugin to configure this Picker')
  end
end

-- Module Exports =============================================================

return manager
