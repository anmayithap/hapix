-- ============================================================================
-- [HAVIX] Core > Autocmds
-- ============================================================================

-- Module Requirements ========================================================

---@type AutocmdC
local Autocmd = require('havix.util.autocmds')

-- Module Definition ==========================================================

Autocmd.new('TextYankPost', {
  pattern = '*',
  callback = function() vim.hl.on_yank() end,
  desc = 'Highlight yanked text',
})
