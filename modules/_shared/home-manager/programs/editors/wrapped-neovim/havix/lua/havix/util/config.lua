-- ============================================================================
-- [HAVIX] Util > Config
-- ============================================================================

-- Module Requirements ========================================================

---@module "havix.util.validation"
local Validator = require('havix.util.validation')
---@module "havix.util.functions"
local Function = require('havix.util.functions')

-- Module Definition ==========================================================

local H = {}

--- HAVIX environment Config constructor
---
--- @class (exact) ConfigC
--- @field new fun(metadata: MetaData, getter: fun(default: any, ...: string): any): Config
--- @field new_global fun(deferral: Deferral, config: Config): any
local ConfigC = {}

-- Helper data ================================================================

--- Predefined diagnostic icons
--- @class (exact) ConfigDiagnosticIcon
--- @field info string
--- @field error string
--- @field warn string
--- @field hint string
local DiagnosticIcon = {
  info = ' ',
  error = ' ',
  warn = ' ',
  hint = ' ',
}

--- Predefined git icons
--- @class (exact) ConfigGitIcon
--- @field added string
--- @field modified string
--- @field removed string
--- @field renamed string
--- @field copied string
--- @field conflict string
--- @field untracked string
--- @field ignored string
local GitIcon = {
  added = ' ',
  modified = ' ',
  removed = ' ',
  renamed = ' ',
  copied = ' ',
  conflict = ' ',
  untracked = ' ',
  ignored = ' ',
}

--- Predefined DAP icons
--- @class (exact) ConfigDAPIcon
--- @field break_point string
--- @field stopped string
--- @field break_point_condition string
--- @field log_point string
--- @field break_point_rejected string
local DAPIcon = {
  break_point = ' ',
  stopped = ' ',
  break_point_condition = ' ',
  log_point = ' ',
  break_point_rejected = ' ',
}

--- Predefined `Config` icons
--- @class (exact) ConfigIcons
--- @field diagnostic ConfigDiagnosticIcon
--- @field git ConfigGitIcon
--- @field dap ConfigDAPIcon
local ConfigIcon = {
  diagnostic = DiagnosticIcon,
  git = GitIcon,
  dap = DAPIcon,
}

--- Always hidden patterns
--- Could use to hide this directories or files
--- in picker or explorer
---
---@type string[]
local AlwaysHiddenPatterns = {
  '%.git',
  '%.DS_Store',
  '%.vscode',
  '%.direnv',
  '%.%w+_cache',
  '%.venv',
  '__pycache__',
}

--- Predefined project directories paths
--- @class (exact) ConfigProjectDirectory
--- @field [1] string Project directory or root of project directories
--- @field type 'project' | 'root' Indicates how to understand this path
--- @type ConfigProjectDirectory[]
local ProjectDirectories = {
  {
    '~/dev',
    type = 'root',
  },
  {
    '~/.config/hapix',
    type = 'project',
  },
  {
    '~/.config/hapix-secret',
    type = 'project',
  },
  {
    '~/learn',
    type = 'root',
  },
}

--- Predefined clues
--- @class (exact) ConfigClue
--- @field mode string nvim mode short-name
--- @field keys string Left-hand-side (lhs) of the mapping
--- @field desc string human-readable description
--- @type ConfigClue[]
local Clues = {
  -- <leader> ---------------------------------------------------------------
  -- `n` mode clues
  { mode = 'n', keys = '<leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<leader>e', desc = '+Explorer' },
  { mode = 'n', keys = '<leader>c', desc = '+Clipboard' },
  { mode = 'n', keys = '<leader>v', desc = '+Void' },
  { mode = 'n', keys = '<leader>g', desc = '+VCS' },
  { mode = 'n', keys = '<leader>S', desc = '+Starter' },
  { mode = 'n', keys = '<leader>l', desc = '+LSP' },
  { mode = 'n', keys = '<leader>d', desc = '+Diagnostic' },
  { mode = 'n', keys = '<leader>a', desc = '+DAP' },
  { mode = 'n', keys = '<leader>w', desc = '+Window' },
  { mode = 'n', keys = '<leader>f', desc = '+Find' },
  { mode = 'n', keys = '<leader>s', desc = '+Session' },
  { mode = 'n', keys = '<leader>z', desc = '+Visits' },
  { mode = 'n', keys = '<leader>m', desc = '+Map' },
  -- `x` clues
  { mode = 'x', keys = '<leader>c', desc = '+Clipboard' },
  { mode = 'x', keys = '<leader>g', desc = '+VCS' },
  { mode = 'x', keys = '<leader>l', desc = '+LSP' },
  -- `v` clues
  { mode = 'v', keys = '<leader>v', desc = '+Void' },

  -- <localleader> ----------------------------------------------------------
  { mode = 'n', keys = '<localleader>v', desc = 'Virtual environment' },
}

--- The default `Config` configuration
--- @class (exact) Config: MetaData
--- @field icons ConfigIcons Predefined icons
--- @field always_hidden string[] Predefined hidden directories | files
--- @field clues_groups ConfigClue[] Predefined clue groups
--- @field projects ConfigProjectDirectory[] Predefined project directories
--- @field is_nix boolean Indicates nix environment
--- @field extract fun(default: any, ...: string): any
--- @field plugin fun(name: string): string?
H.config = {
  icons = ConfigIcon,
  always_hidden = AlwaysHiddenPatterns,
  clues_groups = Clues,
  projects = ProjectDirectories,

  is_nix = false,
}

-- Helper functionality =======================================================

--- `Config` constructor
---
---@param metadata MetaData Nix environment
---@param getter fun(default: any, ...: string): any Metadata getter function which can extract some data
---@return Config config
function H.new(metadata, getter)
  Validator.check_type('metadata', metadata, 'table')
  Validator.check_version('0.12.0')

  --- @type Config
  local config = vim.tbl_extend('error', H.config, metadata)

  config.is_nix = vim.g.nix_info_plugin_name ~= nil

  --- @type fun(default: any, ...: string): any
  config.extract = getter
  --- @type fun(name: string): string?
  config.plugin = function(name)
    ---@type string?
    local lazy = config.extract(nil, 'plugins', 'lazy', name)
    ---@type string?
    local start = config.extract(nil, 'plugins', 'start', name)

    return lazy or start
  end

  return config
end

--- `_G.Config` constructor
--- This is global configuration namespace.
---
---@param deferral Deferral Deferral execturor
---@param config Config Existing `Config` instance
function H.new_global(deferral, config)
  --- `_G.Config`
  ---
  --- @class (exact) GlobalConfig
  --- @field quickfix_toggler fun(): nil
  --- @field locations_toggler fun(): nil
  _G.Config = {
    quickfix_toggler = Function.new_quickfix_toggler(deferral, config),
    locations_toggler = Function.new_locations_toggler(deferral, config),
  }
end

-- Module Exports =============================================================

ConfigC.new = H.new
ConfigC.new_global = H.new_global

return ConfigC
