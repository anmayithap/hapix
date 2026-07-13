-- ============================================================================
-- [HAVIX] Util > Mappings
-- ============================================================================

-- Module Definition ==========================================================

local H = {}

--- HAVIX `MappingC` namespace
--- @class (exact) MappingC
--- @field map fun(mode: string | string[], lhs: string, rhs: string | fun(), opts: vim.api.keyset.keymap?)
--- @field map_extend fun(mode: string, lhs: string, rhs: fun(), opts: vim.api.keyset.keymap?)
--- @field map_batch fun(mappings: { mode: string | string[], lhs: string, rhs: string | fun(), opts: vim.api.keyset.keymap? })
--- @field L fun(key: string): string
--- @field LL fun(key: string): string
--- @field C fun(cmd: string): string
local MappingC = {}

-- Helper functionality =======================================================

--- Create Neovim mapping
---
--- @param mode string | string[]
--- @param lhs string
--- @param rhs string | fun()
--- @param opts vim.api.keyset.keymap?
function H.map(mode, lhs, rhs, opts)
  if lhs == '' then return end

  opts = vim.tbl_deep_extend('force', { silent = true }, opts or {})

  vim.keymap.set(mode, lhs, rhs, opts)
end

--- Create Neovim extended mapping
---
--- @param mode string
--- @param lhs string
--- @param callback fun()
--- @param opts vim.api.keyset.keymap?
function H.map_extend(mode, lhs, callback, opts)
  local original = vim.fn.maparg(lhs, mode, false, true)

  H.map(mode, lhs, function()
    if original.callback then
      original.callback()
    elseif original.rhs then
      local flags = original.noremap == 1 and 'n' or 'm'
      local keys =
        vim.api.nvim_replace_termcodes(original.rhs, true, true, true)
      vim.api.nvim_feedkeys(keys, flags, false)
    end

    vim.schedule(callback)
  end, opts)
end

--- Create batch Neovim mappings
---
--- @param mappings { mode: string, lhs: string, rhs: string | fun(), opts: vim.api.keyset.keymap? }[]
function H.map_batch(mappings)
  for _, mapping in ipairs(mappings) do
    H.map(unpack(mapping))
  end
end

--- Create <leader> left-hand side mapping
---
--- @param key string
--- @return string
function H.L(key) return '<leader>' .. key end

--- Create <localleader> left-hand side mapping
---
--- @param key string
--- @return string
function H.LL(key) return '<localleader>' .. key end

--- Create <cmd> right-hand side mapping
---
--- @param cmd string
--- @return string
function H.C(cmd) return '<cmd>' .. cmd .. '<CR>' end

-- Module Exports =============================================================

MappingC.map = H.map
MappingC.map_extend = H.map_extend
MappingC.map_batch = H.map_batch
MappingC.L = H.L
MappingC.LL = H.LL
MappingC.C = H.C

return MappingC
