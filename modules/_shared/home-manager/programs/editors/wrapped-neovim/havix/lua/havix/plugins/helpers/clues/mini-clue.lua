-- ============================================================================
-- [HAVIX] Plugins > Helpers > Clues > mini.clue
-- ============================================================================

-- Module Requirements ========================================================

---@type ManagerC
local Factory = require('havix.util.manager')
---@type AutocmdC
local Autocmd = require('havix.util.autocmds')

-- Module Definition ==========================================================

local manager = Factory.new({}, {
  function(_, config)
    return {
      'mini.clue',
      auto_enable = true,
      disable_for_vscode = true,
      for_spec = 'clues',

      after = function()
        local m = require('mini.clue')

        m.setup({
          window = {
            delay = 500, -- Delay before showing clue window

            config = {
              anchor = 'SE', -- Anchor position to bottom-right corner
              width = 'auto',
              border = vim.o.winborder or 'bold',
            },
          },

          triggers = {
            { mode = { 'n', 'x' }, keys = '<leader>' }, -- Leader triggers
            { mode = { 'n', 'x' }, keys = '<localleader>' }, -- Local leader triggers
            { mode = 'i', keys = '<C-x>' }, -- Built-in completion
            { mode = { 'n', 'x' }, keys = 'g' }, -- `g` key
            { mode = { 'n', 'x' }, keys = "'" }, -- Marks
            { mode = { 'n', 'x' }, keys = '`' },
            { mode = { 'n', 'x' }, keys = '"' }, -- Registers
            { mode = { 'i', 'c' }, keys = '<C-r>' },
            { mode = { 'n', 't' }, keys = '<C-w>' }, -- Window commands
            { mode = { 'n', 'x' }, keys = 'z' }, -- `z` key
            { mode = 'n', keys = '\\' }, -- Toggle commands
            { mode = { 'n', 'x' }, keys = '[' }, -- mini.bracketed
            { mode = { 'n', 'x' }, keys = ']' },
            { mode = { 'n', 'x' }, keys = 's' }, -- `s` key (mini.surround)
            { mode = { 'n', 'x' }, keys = 'c' }, -- `c` key (mini.operator `replace`)
          },

          clues = {
            config.clues_groups,
            m.gen_clues.g(),
            m.gen_clues.builtin_completion(),
            m.gen_clues.square_brackets(),
            m.gen_clues.marks(),
            m.gen_clues.registers({
              show_contents = true,
            }),
            m.gen_clues.windows({
              submode_move = true,
              submode_navigate = true,
              submode_resize = true,
            }),
            m.gen_clues.z(),
          },
        })

        -- Change LSP mappings descriptions
        m.set_mapping_desc('n', 'gra', 'Action')
        m.set_mapping_desc('x', 'gra', 'Action')
        m.set_mapping_desc('n', 'gri', 'Implementation')
        m.set_mapping_desc('n', 'grr', 'References')
        m.set_mapping_desc('n', 'grn', 'Rename')
        m.set_mapping_desc('n', 'grt', 'Type definition')
        m.set_mapping_desc('n', 'gO', 'Symbols')

        -- Enable clues for specific filetypes
        Autocmd.new('FileType', {
          pattern = { 'oil', 'toggleterm' },
          callback = function() m.ensure_buf_triggers() end,
          desc = '[CLUES]: Enable clues for specific filetypes',
        })
      end,

      lazy = false,
    }
  end,
})

-- Module Exports =============================================================

return manager
