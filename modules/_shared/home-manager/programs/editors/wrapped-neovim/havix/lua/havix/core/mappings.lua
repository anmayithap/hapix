-- ============================================================================
-- [HAVIX] Core > Mappings
-- ============================================================================

-- Module Requirements ========================================================

---@type MappingC
local Mapping = require('havix.util.mappings')
---@type FunctionC
local Function = require('havix.util.functions')

local map = Mapping.map
local L = Mapping.L
local C = Mapping.C

-- Module Definition ==========================================================

-- Basic mappings -------------------------------------------------------------

-- Scroll half page with center cursor
map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')

-- Scroll page with center cursor
map('n', '<C-b>', '<C-b>zz')
map('n', '<C-f>', '<C-f>zz')

-- Move selected lines with indenting support
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

-- Join lines and save cursor position
map('n', 'J', 'mzJ`z')

-- Indenting paragraph with save cursor position
map('n', '=ap', "ma=ap'z")

-- Move by visible lines. Notes:
-- - Don't map in Operator-pending mode because it severely changes behavior:
--   like `dj` on non-wrapped line will not delete it.
-- - Condition on `v:count == 0` to allow easier use of relative line numbers.
map({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Reselect latest changed, put, or yanked text
map('n', 'gV', '"g`[" . strpart(getregtype(), 0, 1) . "g`]"', {
  expr = true,
  replace_keycodes = false,
  desc = 'Visually select changed text',
})

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make affect immediately.
map(
  'x',
  'g/',
  '<esc>/\\%V',
  { silent = false, desc = 'Search inside visual selection' }
)

-- Searching with center cursor
map('n', 'n', "'Nn'[v:searchforward] . 'zzzv'", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward] . 'zzzv'", { expr = true, desc = 'Prev search result' })

-- Toggle options
map('n', '\\c', C('setlocal cursorline!'), { desc = "Toggle 'cursorline'" })
map('n', '\\w', C('setlocal wrap!'), { desc = "Toggle 'wrap'" })
map('n', '\\s', C('setlocal spell!'), { desc = "Toggle 'spell'" })

-- Toggle something
map(
  'n',
  '\\d',
  C('lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())'),
  { desc = "Toggle 'diagnostic'" }
)

map('n', '\\U', '<Nop>', { desc = "Toggle 'undotree'" })
map('n', '\\i', '<Nop>', { desc = "Toggle 'inlay_hint'" })
map('n', '\\I', '<Nop>', { desc = "Toggle 'inline_completion'" })
map('n', '\\l', '<Nop>', { desc = "Toggle 'codelens'" })

-- Motions & Operators
map('n', '(', '<Nop>', { desc = 'Move argument left' })
map('n', ')', '<Nop>', { desc = 'Move argument right' })
map({ 'n', 'x', 'o' }, 'sj', '<Nop>', { desc = 'Leap anywhere' })
map({ 'n', 'x', 'o' }, 'st', '<Nop>', { desc = 'Treesitter select' })
map('n', 'sw', '<Nop>', { desc = 'Leap window' })

-- Frequently Used Terminal ---------------------------------------------------
map('t', '<esc><esc>', [[<C-\><C-n>]], { desc = 'Escape' })

-- Frequently Used Pickers ----------------------------------------------------

map('n', L(' '), '<Nop>', { desc = 'Find files' })
map('n', L(','), '<Nop>', { desc = 'Switch buffer' })
map('n', L('/'), '<Nop>', { desc = 'Resume' })
map('n', L([[\]]), '<Nop>', { desc = 'Pick terminal' })

-- Leader mappings ------------------------------------------------------------

-- `c` is for 'clipboard'

map('n', L('cy'), '"+y', { desc = 'Copy to system clipboard' })
map('x', L('cy'), '"+y', { desc = 'Copy selected to system clipboard' })
map('n', L('cY'), '"+Y', { desc = 'Copy line to system clipboard' })
map('n', L('cp'), '"+p', { desc = 'Paste from system clipboard' })
map(
  'x',
  L('cp'),
  '"+P',
  { desc = 'Paste over selection from system clipboard' }
)
map(
  'x',
  L('cP'),
  '"_dP',
  { desc = 'Paste over selection without clobbering register' }
)

-- `v` is for 'void'

map(
  { 'n', 'v' },
  L('vd'),
  '"_d',
  { desc = 'Delete to void (black hole) register' }
)

-- `b` is for 'buffer'

map('n', L('bn'), Function.new_scratch_buffer, { desc = 'New scratch' })
map('n', L('bs'), C('silent! update | redraw'), { desc = 'Save' })
map('n', L('ba'), C('b#'), { desc = 'Alternate' })
map('n', L('bl'), C('buffers'), { desc = 'List' })
map('n', L('bo'), C('%bd|e#|bd#'), { desc = 'Delete others' })
-- NOTE: Will be set later
map('n', L('bd'), '<Nop>', { desc = 'Delete' })
map('n', L('bD'), '<Nop>', { desc = 'Delete!' })
map('n', L('bu'), '<Nop>', { desc = 'Unload' })
map('n', L('bU'), '<Nop>', { desc = 'Unload!' })
map('n', L('bw'), '<Nop>', { desc = 'Wipeout' })
map('n', L('bW'), '<Nop>', { desc = 'Wipeout!' })

-- `e` is for 'explorer'

map('n', L('eq'), Function.toggle_quickfix, { desc = 'Quickfix' })
map('n', L('el'), Function.toggle_locations, { desc = 'Locations' })

-- `g` is for 'git'

-- NOTE: Will be set later
map('n', L('go'), '<Nop>', { desc = 'Toggle overlay' })
map('n', L('gq'), '<Nop>', { desc = 'Quickfix diffs' })
map('n', L('ga'), '<Nop>', { desc = 'Added diff' })
map('n', L('gA'), '<Nop>', { desc = 'Added diff buffer' })
map('n', L('gc'), '<Nop>', { desc = 'Commit' })
map('n', L('gC'), '<Nop>', { desc = 'Commit append' })
map('n', L('gd'), '<Nop>', { desc = 'Diff' })
map('n', L('gD'), '<Nop>', { desc = 'Diff buffer' })
map('n', L('gl'), '<Nop>', { desc = 'Log' })
map('n', L('gL'), '<Nop>', { desc = 'Log buffer' })
map('n', L('gs'), '<Nop>', { desc = 'Show at cursor' })
map('x', L('gs'), '<Nop>', { desc = 'Show at selection' })
map('n', L('gg'), '<Nop>', { desc = 'Lazygit' })

-- `d` is for 'Diagnostic'

map('n', L('dq'), Function.toggle_diagnostic_quickfix, { desc = 'Quickfix' })
map('n', L('dl'), Function.toggle_diagnostic_locations, { desc = 'Locations' })
map('n', L('dd'), C('lua vim.diagnostic.open_float()'), { desc = 'Diagnostic' })

-- `l` is for 'LSP'

map('n', L('lr'), C('lsp restart'), { desc = 'Restart' })
map(
  'n',
  L('lw'),
  C('lua vim.lsp.buf.add_workspace_folder()'),
  { desc = 'Add workspace folder' }
)
map(
  'n',
  L('lW'),
  C('lua vim.lsp.buf.remove_workspace_folder()'),
  { desc = 'Remove workspace folder' }
)

-- `a` is for 'DAP'

-- NOTE: Will be set later
map('n', L('ab'), '<Nop>', { desc = 'Breakpoint' })
map('n', L('al'), '<Nop>', { desc = 'Clear' })
map('n', L('ae'), '<Nop>', { desc = 'Run' })
map('n', L('aE'), '<Nop>', { desc = 'Run to cursor' })
map('n', L('ar'), '<Nop>', { desc = 'Restart' })
map('n', L('aR'), '<Nop>', { desc = 'Reruns last' })
map('n', L('at'), '<Nop>', { desc = 'Terminate' })
map('n', L('av'), '<Nop>', { desc = 'View' })
map('n', L('aw'), '<Nop>', { desc = 'Watch' })
map('x', L('aw'), '<Nop>', { desc = 'Watch selected' })

-- `w` is for 'Window'

map('n', L('wr'), '<Nop>', { desc = 'Resize' })
map('n', L('wz'), '<Nop>', { desc = 'Zoom' })

-- `f` is for 'Find'

map('n', L('f/'), '<Nop>', { desc = "'/' history" })
map('n', L('f:'), '<Nop>', { desc = "':' history" })
map('n', L('fa'), '<Nop>', { desc = 'Added hunks (all)' })
map('n', L('fA'), '<Nop>', { desc = 'Added hunks (buf)' })
map('n', L('fc'), '<Nop>', { desc = 'Commits (all)' })
map('n', L('fC'), '<Nop>', { desc = 'Commits (buf)' })
map('n', L('fd'), '<Nop>', { desc = 'Diagnostic (workspace)' })
map('n', L('fD'), '<Nop>', { desc = 'Diagnostic (buf)' })
map('n', L('fg'), '<Nop>', { desc = 'Grep live' })
map('n', L('fG'), '<Nop>', { desc = 'Grep current word' })
map('n', L('fh'), '<Nop>', { desc = 'Help tags' })
map('n', L('fH'), '<Nop>', { desc = 'Highlight groups' })
map('n', L('fl'), '<Nop>', { desc = 'Lines (all)' })
map('n', L('fL'), '<Nop>', { desc = 'Lines (buf)' })
map('n', L('fm'), '<Nop>', { desc = 'Modified hunks (all)' })
map('n', L('fM'), '<Nop>', { desc = 'Modified hunks (buf)' })
map('n', L('fr'), '<Nop>', { desc = 'References (LSP)' })
map('n', L('fs'), '<Nop>', { desc = 'Symbols (workspace)' })
map('n', L('fS'), '<Nop>', { desc = 'Symbols (buf)' })
map('n', L('fv'), '<Nop>', { desc = 'Visit (all)' })
map('n', L('fV'), '<Nop>', { desc = 'Visit (cwd)' })
map('n', L('fe'), '<Nop>', { desc = 'Commands' })
map('n', L("f'"), '<Nop>', { desc = 'Marks (all)' })
map('n', L('f`'), '<Nop>', { desc = 'Marks (buf)' })
map('n', L('f"'), '<Nop>', { desc = 'Registers' })

-- `s` is for 'Session'

map('n', L('sd'), '<Nop>', { desc = 'Delete' })
map('n', L('sr'), '<Nop>', { desc = 'Read' })
map('n', L('sn'), '<Nop>', { desc = 'New' })
map('n', L('ss'), '<Nop>', { desc = 'Write' })

-- `z` is for 'Visits'

map('n', L('zc'), '<Nop>', { desc = 'Core visits (all)' })
map('n', L('zC'), '<Nop>', { desc = 'Core visits (buf)' })
map('n', L('zz'), '<Nop>', { desc = "Add 'core' label" })
map('n', L('zZ'), '<Nop>', { desc = "Remove 'core' label" })
map('n', L('za'), '<Nop>', { desc = 'Add label' })
map('n', L('zA'), '<Nop>', { desc = 'Remove label' })

-- `m` is for 'Map'

map('n', L('mf'), '<Nop>', { desc = 'Focus' })
map('n', L('mr'), '<Nop>', { desc = 'Refresh' })
map('n', L('ms'), '<Nop>', { desc = 'Switch sides' })
map('n', L('mt'), '<Nop>', { desc = 'Toggle' })
