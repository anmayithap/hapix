-- ============================================================================
-- [HAVIX] Plugins > IDE > DAP
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')
---@type AutocmdC
local Autocmd = require('havix.util.autocmds')
---@type MappingC
local Mapping = require('havix.util.mappings')

local map = Mapping.map
local C = Mapping.C
local L = Mapping.L

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new({}, {
  function(_, config)
    return {
      'nvim-dap',
      auto_enable = true,
      disable_for_vscode = true,
      for_spec = 'dap',

      after = function()
        local m = require('dap')

        -- Configure DAP signs
        vim.fn.sign_define('DapBreakpoint', {
          text = config.icons.dap.break_point,
          texthl = 'DiagnosticSignError',
        })
        vim.fn.sign_define('DapStopped', {
          text = config.icons.dap.stopped,
          texthl = 'DiagnosticSignHint',
          linehl = 'DiagnosticSignHint',
        })
        vim.fn.sign_define('DapBreakpointCondition', {
          text = config.icons.dap.break_point_condition,
          texthl = 'DiagnosticSignInfo',
        })
        vim.fn.sign_define('DapLogPoint', {
          text = config.icons.dap.log_point,
          texthl = 'DiagnosticSignWarn',
        })
        vim.fn.sign_define('DapBreakpointRejected', {
          text = config.icons.dap.break_point_rejected,
          texthl = 'DiagnosticUnnecessary',
        })

        -- Configure REPL autocompletion
        Autocmd.new('FileType', {
          pattern = 'dap-repl',
          callback = function() require('dap.ext.autocompl').attach() end,
          desc = '[DAP]: Configure REPL autocompletion',
        })

        -- Configure global DAP mappings
        map('n', L('ab'), m.toggle_breakpoint, { desc = 'Breakpoint' })
        map('n', L('al'), m.clear_breakpoints, { desc = 'Clear' })
        map('n', L('ae'), m.continue, { desc = 'Run' })
        map('n', L('aE'), m.run_to_cursor, { desc = 'Run to cursor' })
        map('n', L('ar'), m.restart, { desc = 'Restart' })
        map('n', L('aR'), m.run_last, { desc = 'Reruns last' })
        map('n', L('at'), m.terminate, { desc = 'Terminate' })

        -- Configure DAP on attaching
        H.on_attach()

        -- Decides when and how to jump when stopping at a breakpoint
        -- The order matters!
        --
        -- (1) If the line with the breakpoint is visible, don't jump at all
        -- (2) If the buffer is opened in a tab, jump to it instead
        -- (3) Else, create a new tab with the buffer
        --
        -- This avoid unnecessary jumps
        m.defaults.fallback.switchbuf = 'usevisible,usetab,newtab'
      end,

      lazy = false,
    }
  end,
  {
    'nvim-dap-virtual-text',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'dap',

    ---@diagnostic disable-next-line: missing-parameter
    after = function() require('nvim-dap-virtual-text').setup() end,

    on_plugin = {
      'nvim-dap',
    },
  },
  {
    'nvim-dap-view',
    auto_enable = true,
    disable_for_vscode = true,
    for_spec = 'dap',

    after = function()
      require('dap-view').setup({
        winbar = {
          sections = {
            'console',
            'watches',
            'scopes',
            'exceptions',
            'breakpoints',
            'threads',
            'repl',
          },
          default_section = 'console',
          controls = {
            enabled = true, -- Enables the controls buttons
          },
        },

        windows = {
          terminal = {
            -- Use the actual names for the adapters you want to hide
            hide = { 'delve' }, -- `delve` is known to not use the terminal.
          },
        },

        help = {
          border = vim.o.winborder or 'bold',
        },
      })

      map('n', L('av'), C('DapViewToggle'), { desc = 'View' })
      map('n', L('aw'), C('DapViewWatch'), { desc = 'Watch' })
      map('x', L('aw'), C('DapViewWatch'), { desc = 'Watch selected' })
    end,

    on_plugin = {
      'nvim-dap',
    },
  },
})

-- Helper functionality =======================================================

function H.on_attach()
  local m = require('dap')

  ---@type {buffer: integer, lhs: string, mode: string, old: table | nil}[]
  local keys_to_restore = {}

  ---@type {mode: string, lhs: string, rhs: string | fun(), opts: table}[]
  local new_keymaps = {
    hover = {
      mode = 'n',
      lhs = 'K',
      rhs = C("lua require('dap.ui.widgets').hover()"),
      opts = { desc = 'DAP Hover', silent = true },
    },
    continue = {
      mode = 'n',
      lhs = L('1'),
      rhs = m.continue,
      opts = { desc = 'Continue' },
    },
    step_over = {
      mode = 'n',
      lhs = L('2'),
      rhs = m.step_over,
      opts = { desc = 'Step over' },
    },
    step_into = {
      mode = 'n',
      lhs = L('3'),
      rhs = m.step_into,
      opts = { desc = 'Step into' },
    },
    step_out = {
      mode = 'n',
      lhs = L('4'),
      rhs = m.step_out,
      opts = { desc = 'Step out' },
    },
  }

  -- Create mappings when DAP attaching
  m.listeners.after['event_initialized']['me'] = function()
    for _, buffer in pairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buffer) then
        local keymaps = vim.api.nvim_buf_get_keymap(buffer, 'n')

        for _, new_keymap in pairs(new_keymaps) do
          local existing = nil

          for _, keymap in pairs(keymaps) do
            local lhs_equal = keymap.lhs == new_keymap.lhs
            if
              lhs_equal
              or keymap.lhs
                == vim.api.nvim_replace_termcodes(
                  new_keymap.lhs,
                  true,
                  true,
                  true
                )
            then
              existing = keymap
              break
            end
          end

          table.insert(keys_to_restore, {
            buffer = buffer,
            lhs = new_keymap.lhs,
            mode = new_keymap.mode,
            old = existing,
          })

          vim.keymap.set(
            new_keymap.mode,
            new_keymap.lhs,
            new_keymap.rhs,
            vim.tbl_extend('force', new_keymap.opts, { buffer = buffer })
          )
        end
      end
    end
  end

  -- Remove mappings when DAP detaching
  m.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keys_to_restore) do
      if vim.api.nvim_buf_is_valid(keymap.buffer) then
        if keymap.old then
          local opts = {
            silent = keymap.old.silent == 1,
            noremap = keymap.old.noremap == 1,
          }
          if keymap.old.callback then
            vim.keymap.set(keymap.mode, keymap.lhs, keymap.old.callback, {
              buffer = keymap.buffer,
              silent = opts.silent,
              noremap = opts.noremap,
            })
          else
            vim.api.nvim_buf_set_keymap(
              keymap.buffer,
              keymap.mode,
              keymap.lhs,
              keymap.old.rhs or '',
              opts
            )
          end
        else
          pcall(
            vim.api.nvim_buf_del_keymap,
            keymap.buffer,
            keymap.mode,
            keymap.lhs
          )
        end
      end
    end

    keys_to_restore = {}
  end
end

-- Module Exports =============================================================

return manager
