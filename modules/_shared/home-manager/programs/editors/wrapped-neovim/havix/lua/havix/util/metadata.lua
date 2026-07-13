-- ============================================================================
-- [HAVIX] Util > Metadata
-- ============================================================================

-- Module Definition ==========================================================

local H = {}

--- HAVIX environment MetaData constructor
--- @class (exact) MetaDataC
--- @field new fun(): MetaData
--- @field getter fun(metadata: MetaData): fun(default: any, ...: string): any
local MetaDataC = {}

--- `MetaData.settings` item
--- @class (exact) MetaDataItemS
--- @field enable boolean A flag that indicates whether a specification should be disabled
--- @field name string? The name of the plugin module, usually the same as the name of the `required` module
--- @field pname string? The name of the plugin
---
--- @field [string] any The __index metamethod implementation
local SettingItem = {
  enable = false,
  name = nil,
  pname = nil,
}

--- `SettingItem` constructor
--- @protected
--- @param opts { [string]: any }?
--- @return MetaDataItemS
function SettingItem:new(opts)
  opts = opts or {}

  setmetatable(opts, self)

  self.__index = self

  return opts
end

-- Helper data ================================================================

--- `MetaData.settings.explorer` item
--- @class (exact) MetaDataExplorerS
--- @field enable boolean A flag that indicates whether a specification should be disabled
--- @field default? "as_buffer" | "as_tree" Which explorer using as default
--- @field as_buffer MetaDataItemS Buffer like explorer configuration
--- @field as_tree MetaDataItemS Tree like explorer configuration
local ExplorerSettingItem = {
  enable = false,
  default = nil,
  as_buffer = SettingItem:new(),
  as_tree = SettingItem:new(),
}

--- `MetaData.settings.git` item
--- @class (exact) MetaDataGitS
--- @field enable boolean A flag that indicates whether a specification should be disabled
--- @field git MetaDataItemS Configuration for git specific spec
--- @field diff MetaDataItemS Configuration for diff specific spec
local GitSettingItem = {
  enable = false,
  git = SettingItem:new(),
  diff = SettingItem:new(),
}

--- `MetaData.settings`
--- @class (exact) MetaDataS
--- @field specs table<string, boolean>
--- @field colorscheme MetaDataItemS
--- @field explorer MetaDataExplorerS
--- @field deferral MetaDataItemS
--- @field clues MetaDataItemS
--- @field git MetaDataGitS
--- @field icons MetaDataItemS
--- @field notifier MetaDataItemS
--- @field starter MetaDataItemS
--- @field statusline MetaDataItemS
--- @field tabline MetaDataItemS
--- @field picker MetaDataItemS
--- @field session MetaDataItemS
local MetaDataSettings = {
  specs = {},
  colorscheme = SettingItem:new(),
  explorer = ExplorerSettingItem,
  deferral = SettingItem:new(),
  clues = SettingItem:new(),
  git = GitSettingItem,
  icons = SettingItem:new(),
  notifier = SettingItem:new(),
  starter = SettingItem:new(),
  statusline = SettingItem:new(),
  tabline = SettingItem:new(),
  picker = SettingItem:new(),
  session = SettingItem:new(),
}

--- The default `MetaData` configuration
---
--- @alias MetaDataPlugins { lazy: table<string, string>[], start: table<string, string>[] }
---
--- @class (exact) MetaData
--- @field settings MetaDataS
--- @field plugins MetaDataPlugins
H.default_config = {
  settings = MetaDataSettings,
  plugins = {},
}

-- Helper functionality =======================================================

--- `MetaData` constructor
---
--- We are attempting to extract Nix metadata from the environment.
--- This metadata will allow us to identify available plugins and specifications.
---
--- @return MetaData
function H.new()
  local ok, __meta__ = pcall(require, vim.g.nix_info_plugin_name)

  if not ok then
    package.loaded[vim.g.nix_info_plugin_name] = setmetatable({}, {
      __call = function(_, default) return default end,
    })

    __meta__ = require(vim.g.nix_info_plugin_name)

    -- Fill default values
    __meta__ = vim.tbl_extend('force', H.config, __meta__)
  end

  return __meta__
end

--- Extract `getter` from `nixInfo`.
---
--- @param metadata MetaData
--- @generic T: any, V: any
--- @return fun(default: T, ...: string): V | T
function H.provide_getter(metadata)
  local mt = getmetatable(metadata)

  local wrapper = function(default, ...)
    return mt.__call(metadata, default, ...)
  end

  return wrapper
end

-- Module Exports =============================================================

MetaDataC.new = H.new
MetaDataC.getter = H.provide_getter

return MetaDataC
