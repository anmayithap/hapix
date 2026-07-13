-- ===========================================================================
-- [HAVIX] Core > Options
-- ===========================================================================

-- Module Requirements ========================================================

---@type OptionC
local Option = require('havix.util.options')

local o = Option.o

-- Module Definition ==========================================================

-- NOTE: These two should be set up before any plugins with keybinds are loaded
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
-- Set `,` as the local leader key
-- See `:help maplocalleader`
vim.g.maplocalleader = ','

-- General --------------------------------------------------------------------

vim.cmd('filetype plugin indent on') -- Enable all filetype plugins
vim.loader.enable() -- Enable experimental Lua loader
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end -- Enable all filetype syntax

o.autoread = true -- Autoread file when changed
o.conceallevel = 2 -- Concealed text is completely hidden unless it has a custom replacement character
o.undofile = true
o.undodir = vim.fn.stdpath('state') .. '/undo'
o.backup = false
o.writebackup = false
o.swapfile = false
o.mouse = 'a' -- Enable mouse for all available modes
o.switchbuf = 'usetab' -- Use already opened buffers when switching
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.inccommand = 'split' -- Preview substitutions live, as type
o.timeoutlen = vim.g.vscode and 1000 or 500
o.updatetime = 250

-- Appearance -----------------------------------------------------------------

o.breakindent = true -- Indent wrapped lines to match line start
o.breakindentopt = 'list:-1' -- Add padding for lists (if 'wrap' set)
o.cursorline = true -- Highlight current line
o.linebreak = true -- Wrap ling lines at `breakat` (if 'wrap' is set)
o.number = true -- Show line numbers
o.relativenumber = true -- Show relative line numbers
o.splitbelow = true -- Horizontal splits will be below
o.splitright = true -- Vertical splits will be to the right
o.splitkeep = 'screen' -- Reduce scroll during window split
o.ruler = false -- Don't show cursor position in command line
o.showmode = false -- Don't show mode in command line
o.wrap = true -- Wrap long lines visually (does not change the buffer)
o.signcolumn = 'auto' -- Always how to sign column (otherwise it will shift text)
o.fillchars = 'foldopen:,foldclose:,fold: ,eob: '
o.winborder = 'bold'
o.pumheight = 10 -- Make popup menu smaller
o.pumborder = 'bold'
o.pummaxwidth = 100 -- Limit maximum width of popup menu
o.list = true -- Show some helper symbols
o.listchars = 'tab:> ,trail:·,nbsp:␣,extends:…,precedes:…' -- Define which helper symbols to show
o.termguicolors = true -- Enable 24-bit RGB color in the TUI
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
o.foldlevel = 99 -- Open all folds by default (higher - more `unfloded`)
o.foldmethod = 'expr' -- Fold based on expression
o.foldnestmax = 10 -- Limit number of fold levels
o.laststatus = 3 -- When and Where to show status line (default last window)
o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
o.showtabline = 2 -- Always show tab line
o.smoothscroll = true -- Enable smooth scrolling
o.shortmess = 'FOSWICacolmrw'
o.completetimeout = 100

Option.set_win_border(o.winborder) -- Use border in floating windows

-- Editing --------------------------------------------------------------------

o.autoindent = true -- Use auto indent
o.expandtab = true -- Convert tabs to spaces
o.shiftwidth = 4 -- Use this number of spaces for indentation
o.shiftround = true
o.tabstop = 4 -- Show tab as this number of spaces
o.virtualedit = 'block' -- Allow going past end of line in block wise mode
o.ignorecase = true -- Ignore case when searching (use '\C' to force not doing that)
o.incsearch = true -- Show search results while typing
o.infercase = true -- Infer letter cases for a richer built-in keyword completion
o.smartcase = true -- Don't ignore case when searching if pattern has upper case
o.smartindent = true -- Make indenting smart
o.formatoptions = 'tcqjrnl1'

-- Pattern for a start of 'numbered' list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

o.completeopt = 'menuone,noselect,fuzzy,nosort'
