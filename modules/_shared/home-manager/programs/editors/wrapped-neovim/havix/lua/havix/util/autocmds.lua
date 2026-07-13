-- ============================================================================
-- [HAVIX] Util > Autocmds
-- ============================================================================

-- Module Definition ==========================================================

--- HAVIX Autocmd constructor
---
--- @class (exact) AutocmdC: table
--- @field new fun(event: vim.api.keyset.events | vim.api.keyset.events[], opts: vim.api.keyset.create_autocmd)
local AutocmdC = {}
local H = {}

-- Helper data ================================================================

-- Declare default HAVIX group.
-- This group allows you to specify the base namespace for automatic commands.
-- NOTE: `clear = true` is required.
H.default_group = vim.api.nvim_create_augroup('HAVIX', { clear = true })

-- Helper functionality =======================================================

--- Create HAVIX auto command
---
--- @param event vim.api.keyset.events | vim.api.keyset.events[]
--- @param opts vim.api.keyset.create_autocmd
function H.new(event, opts)
  local default_group = H.default_group

  opts.group = opts.group or default_group
  vim.api.nvim_create_autocmd(event, opts)
end

-- Module Exports =============================================================

AutocmdC.new = H.new

return AutocmdC
