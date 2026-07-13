--- *ayu* Ayu color scheme for Neovim
---
--- MIT License Copyright (c) 2026 Ruslan Torbeev
---
--- Implementation of [ayu-theme/ayu-colors](https://github.com/ayu-theme/ayu-colors)
--- color scheme (with Copyright (C) 2016 Konstantin Pschera <me@kons.ch>).
---
--- # Supported highlight groups ~
---
--- - Built-in Neovim editor groups
--- - Built-in Neovim syntax groups
--- - Built-in Neovim LSP groups
--- - Built-in Neovim Diagnostic groups
--- - Built-in Neovim Treesitter groups
---
--- # Setup ~
---
--- This module needs a setup with `require('ayu').setup({})` (replace
--- `{}` with your `config` table). It will create a global Lua table `Ayu`
--- which you can use for scripting (with `:lua Ayu.*`).
---
--- See |Ayu.config| for `config` structure and default values.
---
--- # Colorscheme name ~
---
--- `setup()` applies highlights immediately but does not set
--- `vim.g.colors_name`. Set it yourself after the call if needed:
---
--- >lua
---   require('ayu').setup({ scheme = 'dark' })
---   vim.g.colors_name = 'ayu-dark'
--- <

-- Type annotations ============================================================

--- Selected Ayu color palette variant.
---@alias __colorscheme
---| 'dark'   # `ayu-dark`   – dark background, vivid accents
---| 'light'  # `ayu-light`  – light background, muted accents
---| 'mirage' # `ayu-mirage` – dark-medium background, softer accent

--- Overrides for highlight groups produced by this plugin.
---
--- When a function, receives the fully resolved `__palette<__hex_color>` for
--- the active scheme and must return `table<string, vim.api.keyset.highlight>`.
--- Merged with `vim.tbl_extend('force', ...)` on top of generated groups.
---@alias __overrides
---| table<string, vim.api.keyset.highlight>
---| fun(palette: __palette<__hex_color>): table<string, vim.api.keyset.highlight>

--- CSS-style hexadecimal color string in the form `"#rrggbb"`.
---@alias __hex_color string

--- RGB triplet `{ R, G, B }` with each component in the range `[0, 255]`.
---@alias __rgb_color [integer, integer, integer]

--- Opacity level used in alpha-compositing, in the range `[0, 1]`.
--- `0` is fully transparent (shows background only), `1` is fully opaque.
---@alias __alpha number

--- Blend tuple `{ fg, bg, alpha }` resolved to a hex color at load time via
--- alpha-compositing: `result = bg * (1 - alpha) + fg * alpha`.
---@alias __blend_tuple [__hex_color, __hex_color, __alpha]

--- Raw color value — either a ready-to-use hex string or a blend tuple
--- that is resolved to a hex color during palette initialization.
---@alias __raw_color __hex_color | __blend_tuple

--- Palette parameterized over the color value type `T`.
---
--- `T = __raw_color` — raw palette (pre-resolution, may contain blend tuples).
--- `T = __hex_color` — resolved palette (all values are concrete hex strings).
---@class (exact) __palette<T>
---@field syntax   __palette_syntax<T>
---@field terminal __palette_terminal<T>
---@field vcs      __palette_vcs<T>
---@field editor   __palette_editor<T>
---@field ui       __palette_ui<T>
---@field common   __palette_common<T>

--- Syntax token colors used for code highlighting.
---@class (exact) __palette_syntax<T>
---@field tag      T HTML/XML tags; built-in type keywords
---@field func     T Function and method names
---@field entity   T Type and class names
---@field string   T String literals
---@field regexp   T Regular expressions and escape sequences
---@field markup   T Markup emphasis; member/property names
---@field keyword  T Language keywords (`if`, `for`, `return`, …)
---@field special  T Decorators, macros, and special forms
---@field comment  T Comments (typically dimmed)
---@field constant T Constants, static variables, and numeric literals
---@field operator T Language operators

--- Terminal emulator colors – 16-color ANSI palette plus default `fg`/`bg`.
---@class (exact) __palette_terminal<T>
---@field fg             T Default foreground
---@field bg             T Default background
---@field black          T ANSI 0  – black
---@field red            T ANSI 1  – red
---@field green          T ANSI 2  – green
---@field yellow         T ANSI 3  – yellow
---@field blue           T ANSI 4  – blue
---@field magenta        T ANSI 5  – magenta
---@field cyan           T ANSI 6  – cyan
---@field white          T ANSI 7  – white
---@field bright_black   T ANSI 8  – bright black (dark gray)
---@field bright_red     T ANSI 9  – bright red
---@field bright_green   T ANSI 10 – bright green
---@field bright_yellow  T ANSI 11 – bright yellow
---@field bright_blue    T ANSI 12 – bright blue
---@field bright_magenta T ANSI 13 – bright magenta
---@field bright_cyan    T ANSI 14 – bright cyan
---@field bright_white   T ANSI 15 – bright white

--- Version-control status indicator colors.
---@class (exact) __palette_vcs<T>
---@field added    T Added lines / new content
---@field modified T Modified lines / changed content
---@field removed  T Removed lines / deleted content

--- Editor chrome colors: gutters, selections, line highlight.
---@class (exact) __palette_editor<T>
---@field fg                  T Default foreground
---@field bg                  T Default background
---@field selection_active    T Active selection background
---@field selection_inactive  T Inactive (unfocused) selection background
---@field find_match_active   T Active search-match background
---@field find_match_inactive T Inactive search-match background
---@field line_number_active  T Cursor-line number foreground
---@field line_number_normal  T Normal line-number foreground
---@field indent_guide_active T Active indent-guide foreground
---@field indent_guide_normal T Normal indent-guide foreground
---@field line                T Current-line highlight background

--- UI panel and floating-window colors.
---@class (exact) __palette_ui<T>
---@field fg               T Default foreground for UI chrome
---@field bg               T Default background for UI chrome
---@field selection_active T Active selection background
---@field selection_normal T Normal (inactive) selection background
---@field panel_bg         T Background for sidebars and status bars
---@field panel_shadow     T Panel drop-shadow color
---@field popup_bg         T Floating-window / popup background
---@field popup_shadow     T Floating-window drop-shadow color
---@field line             T Separator line color

--- Common accent and semantic colors.
---@class (exact) __palette_common<T>
---@field accent_tint T Primary accent / highlight color
---@field accent_on   T Foreground suitable for rendering on top of `accent_tint`
---@field error       T Error indicator color

--- User-supplied configuration table passed to |Ayu.setup()|.
--- All fields are optional; omitted fields fall back to the defaults
--- documented in |Ayu.config|.
---@class (exact) __user_config
---@field scheme    __colorscheme? Color scheme variant to activate
---@field palette   { dark: __palette<__raw_color>?, light: __palette<__raw_color>?, mirage: __palette<__raw_color>? }?
---                                Palettes to override the defaults
---@field overrides __overrides?   Overrides for generated highlight groups

--- Internal (validated, fully-specified) configuration stored in |Ayu.config|
--- after a successful |Ayu.setup()| call.
---@class (exact) __config: __user_config
---@field scheme    __colorscheme  Active color scheme variant
---@field palette   { dark: __palette<__hex_color>, light: __palette<__hex_color>, mirage: __palette<__hex_color> }
---                                All three palettes fully resolved to hex strings
---@field overrides __overrides?   Highlight-group overrides (may be nil)

-- Module definition ==========================================================

local Ayu                = {}
local H                  = {}

-- Public API =================================================================

--- Set up and immediately apply the Ayu color scheme.
---
--- Validates `config`, deep-merges it with built-in defaults, resolves all
--- palette blend tuples to hex strings, then applies every highlight group.
--- Creates the global Lua table `Ayu` for scripting access.
---
--- Note: does not set `vim.g.colors_name`. Set it yourself afterwards if
--- you need `:colorscheme` integration:
--- >lua
---   require('ayu').setup({ scheme = 'dark' })
---   vim.g.colors_name = 'ayu-dark'
--- <
---
---@param config __user_config?
Ayu.setup                = function(config)
  -- Export module
  _G.Ayu = Ayu

  -- Setup config
  local setup_config = H.setup_config(config)

  -- Apply config
  H.apply_config(setup_config)
end

--- Plugin configuration. See |Ayu.setup()| for how to override these.
---
--- Default values:
---
--- >lua
---   require('ayu').setup({
---     -- Color palette variant. When `nil`, falls back to `vim.o.background`:
---     -- 'dark' background -> 'dark' scheme, anything else -> 'light'.
---     scheme = nil,
---
---     -- Per-scheme raw palette overrides. Deep-merged with built-in defaults
---     -- so only specified sections and color keys are changed.
---     -- Values may be hex strings ("#rrggbb") or blend tuples { fg, bg, alpha }.
---     palette = nil,
---
---     -- Overrides for generated highlight groups.
---     -- A plain table or a function receiving the resolved active palette.
---     overrides = nil,
---   })
--- <
---@type __user_config
Ayu.config               = {
  scheme = nil,
  palette = nil,
  overrides = nil,
}

-- Helper data ================================================================

---@type __palette<__raw_color>
H.default_dark_palette   = {
  syntax = {
    tag = '#39bae6',
    func = '#ffb454',
    entity = '#59c2ff',
    string = '#aad94c',
    regexp = '#95e6cb',
    markup = '#f07178',
    keyword = '#ff8f40',
    special = '#e6c08a',
    comment = '#5a6673',
    constant = '#d2a6ff',
    operator = '#f29668',
  },
  terminal = {
    fg = '#bfbdb6',
    bg = '#10141c',
    black = '#0a0000',
    red = '#e6495a',
    green = '#97c142',
    yellow = '#e89d37',
    blue = '#17acf2',
    magenta = '#c385fe',
    cyan = '#84ceb5',
    white = '#ffffff',
    bright_black = '#0a0000',
    bright_red = '#f07178',
    bright_green = '#aad94c',
    bright_yellow = '#ffb454',
    bright_blue = '#59c2ff',
    bright_magenta = '#d2a6ff',
    bright_cyan = '#95e6cb',
    bright_white = '#ffffff',
  },
  vcs = {
    added = '#70bf56',
    modified = '#73b8ff',
    removed = '#f26d78',
  },
  editor = {
    fg = '#bfbdb6',
    bg = '#10141c',
    selection_active = { '#3388ff', '#10141c', 0.25 },
    selection_inactive = { '#80b5ff', '#10131c', 0.15 },
    find_match_active = '#4c4126',
    find_match_inactive = { '#4c4126', '#10131c', 0.5 },
    line_number_active = '#5a6378',
    line_number_normal = { '#5a6378', '#10141c', 0.65 },
    indent_guide_active = { '#5a6378', '#10131c', 0.63 },
    indent_guide_normal = { '#5a6378', '#10131c', 0.26 },
    line = '#161a24',
  },
  ui = {
    fg = '#5a6378',
    bg = '#0d1017',
    selection_active = { '#475266', '#0d1017', 0.25 },
    selection_normal = { '#475266', '#0d1017', 0.2 },
    panel_bg = '#141821',
    panel_shadow = { '#000000', '#0d1017', 0.5 },
    popup_bg = '#0f131a',
    popup_shadow = { '#000000', '#0d1017', 0.5 },
    line = '#1b1f29',
  },
  common = {
    accent_tint = '#e6b450',
    accent_on = '#765b24',
    error = '#d95757',
  },
}

---@type __palette<__raw_color>
H.default_light_palette  = {
  syntax = {
    tag = '#55b4d4',
    func = '#eba400',
    entity = '#22a4e6',
    string = '#86b300',
    regexp = '#4cbf99',
    markup = '#f07171',
    keyword = '#fa8532',
    special = '#e59645',
    comment = '#adaeb1',
    constant = '#a38acc',
    operator = '#f2a191',
  },
  terminal = {
    fg = '#5c6166',
    bg = '#fcfcfc',
    black = '#86878c',
    red = '#f07171',
    green = '#86b300',
    yellow = '#eba400',
    blue = '#22a4e6',
    magenta = '#a37acc',
    cyan = '#4cbf99',
    white = '#adaeb1',
    bright_black = '#939498',
    bright_red = '#f07171',
    bright_green = '#86b300',
    bright_yellow = '#eba400',
    bright_blue = '#22a4e6',
    bright_magenta = '#a37acc',
    bright_cyan = '#4cbf99',
    bright_white = '#c5c5c8',
  },
  vcs = {
    added = '#6cbf43',
    modified = '#478acc',
    removed = '#ff7383',
  },
  editor = {
    fg = '#5c6166',
    bg = '#fcfcfc',
    selection_active = { '#035bd6', '#fcfcfc', 0.15 },
    selection_inactive = { '#035bd6', '#fcfcfc', 0.07 },
    find_match_active = '#ffe294',
    find_match_inactive = { '#ffe294', '#fcfcfc', 0.5 },
    line_number_active = { '#828e9f', '#fcfcfc', 0.8 },
    line_number_normal = { '#828e9f', '#fcfcfc', 0.4 },
    indent_guide_active = { '#828e9f', '#fcfcfc', 0.35 },
    indent_guide_normal = { '#828e9f', '#fcfcfc', 0.18 },
    line = { '#828e9f', '#fcfcfc', 0.1 },
  },
  ui = {
    fg = '#828e9f',
    bg = '#f8f9fa',
    line = { '#6b7d8f', '#f8f9fa', 0.12 },
    selection_active = { '#6b7d8f', '#f8f9fa', 0.24 },
    selection_normal = { '#6b7d8f', '#f8f9fa', 0.12 },
    panel_bg = '#fafafa',
    panel_shadow = { '#6b7d8f', '#f8f9fa', 0.07 },
    popup_bg = '#ffffff',
    popup_shadow = { '#6b7d8f', '#f8f9fa', 0.1 },
  },
  common = {
    accent_tint = '#f29718',
    accent_on = '#7e4b01',
    error = '#e65050',
  },
}

---@type __palette<__raw_color>
H.default_mirage_palette = {
  syntax = {
    tag = '#5ccfe6',
    func = '#ffcd66',
    entity = '#73d0ff',
    string = '#d5ff80',
    regexp = '#95e6cb',
    markup = '#f28779',
    keyword = '#ffa659',
    special = '#d9be98',
    comment = '#6e7c8f',
    constant = '#dfbfff',
    operator = '#f29e74',
  },
  terminal = {
    fg = '#cccac2',
    bg = '#242936',
    black = '#0a0000',
    red = '#f06b5c',
    green = '#bfe76d',
    yellow = '#e6b752',
    blue = '#3bbbf4',
    magenta = '#d09ffd',
    cyan = '#84ceb5',
    white = '#d2d6dc',
    bright_black = '#0a0000',
    bright_red = '#f39184',
    bright_green = '#d5ff80',
    bright_yellow = '#ffcd66',
    bright_blue = '#73d0ff',
    bright_magenta = '#dfbfff',
    bright_cyan = '#95e6cb',
    bright_white = '#e3e6ea',
  },
  vcs = {
    added = '#87d96c',
    modified = '#80bfff',
    removed = '#f27983',
  },
  editor = {
    fg = '#cccac2',
    bg = '#242936',
    selection_active = { '#409FFF', '#242936', 0.25 },
    selection_inactive = { '#409FFF', '#242936', 0.13 },
    find_match_active = '#736950',
    find_match_inactive = { '#736950', '#242936', 0.4 },
    line_number_active = '#707a8c',
    line_number_normal = { '#707a8c', '#242936', 0.5 },
    indent_guide_active = { '#707a8c', '#242936', 0.44 },
    indent_guide_normal = { '#707a8c', '#242936', 0.23 },
    line = '#1a1f29',
  },
  ui = {
    fg = '#707a8c',
    bg = '#1f2430',
    line = '#171b24',
    selection_active = { '#637599', '#1f2430', 0.15 },
    selection_normal = { '#69758c', '#1f2430', 0.12 },
    panel_bg = '#282e3b',
    panel_shadow = { '#000000', '#1f2430', 0.2 },
    popup_bg = '#1c212c',
    popup_shadow = { '#000000', '#1f2430', 0.3 },
  },
  common = {
    accent_tint = '#ffcc66',
    accent_on = '#735923',
    error = '#ff6666',
  },
}

--- Module default config (includes all three built-in raw palettes).
---@type __user_config
H.default_config         = vim.tbl_deep_extend('force', {
  palette = {
    dark   = H.default_dark_palette,
    light  = H.default_light_palette,
    mirage = H.default_mirage_palette,
  },
}, Ayu.config)

H.colorscheme_names      = { 'dark', 'light', 'mirage' }
H.palette_section_names  = { 'syntax', 'terminal', 'vcs', 'editor', 'ui', 'common' }

-- Helper functionality =======================================================

-- Settings -------------------------------------------------------------------

--- Validate a user config, deep-merge with built-in defaults, resolve all
--- blend tuples in all three palettes, and return a fully-specified config.
---
---@param  config __user_config?
---@return        __config
H.setup_config           = function(config)
  H.check_type('config', config, 'table', true)

  config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})

  -- Validate fields before using them.
  H.check_type('config.scheme', config.scheme, 'string', true)
  H.check_type('config.overrides', config.overrides, { 'table', 'function' }, true)
  H.validate_scheme(config.scheme, 'config.scheme')
  H.validate_palette(config.palette, 'config.palette')

  -- Resolve scheme: explicit value → vim.o.background fallback.
  config.scheme         = config.scheme or (vim.o.background == 'dark' and 'dark' or 'light')
  config.overrides      = config.overrides or nil

  -- Resolve blend tuples to hex strings in all three palettes.
  config.palette.dark   = H.resolve_palette(config.palette.dark)
  config.palette.light  = H.resolve_palette(config.palette.light)
  config.palette.mirage = H.resolve_palette(config.palette.mirage)

  ---@type __config
  return config
end

--- Store config and apply highlights for the active scheme.
---@param config __config
H.apply_config           = function(config)
  Ayu.config = config

  local palette = config.palette[config.scheme]

  H.apply_palette(palette, config.overrides)
end

-- Palette --------------------------------------------------------------------

--- Convert every `__blend_tuple` in a raw palette to a `__hex_color`.
---@param  raw __palette<__raw_color>
---@return     __palette<__hex_color>
H.resolve_palette        = function(raw)
  local resolved = {}
  for section_name, section in pairs(raw) do
    resolved[section_name] = {}
    for color_name, color in pairs(section) do
      if type(color) == 'table' then
        -- Blend tuple: { fg, bg, alpha }
        resolved[section_name][color_name] = H.blend_hex(color[1], color[2], color[3])
      else
        resolved[section_name][color_name] = color
      end
    end
  end
  return resolved
end

-- Highlighting ---------------------------------------------------------------

--- Clear previous highlights and apply all groups for the given palette.
--- User overrides (if any) are merged on top afterwards.
---
---@param palette   __palette<__hex_color>
---@param overrides __overrides?
H.apply_palette          = function(palette, overrides)
  if vim.g.colors_name then vim.cmd('highlight clear') end
  vim.g.colors_name       = nil

  -- Terminal colors
  local t                 = palette.terminal
  vim.g.terminal_color_0  = t.black
  vim.g.terminal_color_1  = t.red
  vim.g.terminal_color_2  = t.green
  vim.g.terminal_color_3  = t.yellow
  vim.g.terminal_color_4  = t.blue
  vim.g.terminal_color_5  = t.magenta
  vim.g.terminal_color_6  = t.cyan
  vim.g.terminal_color_7  = t.white
  vim.g.terminal_color_8  = t.bright_black
  vim.g.terminal_color_9  = t.bright_red
  vim.g.terminal_color_10 = t.bright_green
  vim.g.terminal_color_11 = t.bright_yellow
  vim.g.terminal_color_12 = t.bright_blue
  vim.g.terminal_color_13 = t.bright_magenta
  vim.g.terminal_color_14 = t.bright_cyan
  vim.g.terminal_color_15 = t.bright_white

  local groups            = H.build_highlight_groups(palette)

  if overrides then
    local ov = nil
    if vim.is_callable(overrides) then
      ov = overrides(palette)
    else
      ov = palette
    end

    groups = vim.tbl_extend('force', groups, ov)
  end

  for name, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, name, spec)
  end
end

--- Build the complete table of highlight group specs from a resolved palette.
---
--- Returns `vim.api.keyset.highlight` tables for every built-in Neovim
--- highlight group supported by this plugin.
---
---@param  p __palette<__hex_color>
---@return   table<string, vim.api.keyset.highlight>
H.build_highlight_groups = function(p)
  local s = p.syntax
  local v = p.vcs
  local e = p.editor
  local u = p.ui
  local c = p.common
  local t = p.terminal

  ---@type table<string, vim.api.keyset.highlight>
  return {
    -- =========================================================================
    -- 1. Built-in Neovim editor groups (|highlight-groups|)
    -- =========================================================================
    ColorColumn        = { bg = e.line },
    Conceal            = { bg = s.comment },
    CurSearch          = { fg = e.bg, bg = e.find_match_active, bold = true },
    Cursor             = { fg = e.bg, bg = e.fg },
    lCursor            = { link = 'Cursor' },
    CursorIM           = { link = 'Cursor' },
    CursorColumn       = { bg = e.line },
    CursorLine         = { bg = e.line },
    Directory          = { fg = s.special },
    DiffAdd            = { bg = H.blend_hex(v.added, e.bg, 0.15) },
    DiffChange         = { bg = H.blend_hex(v.modified, e.bg, 0.15) },
    DiffDelete         = { bg = H.blend_hex(v.removed, e.bg, 0.15) },
    DiffText           = { bg = H.blend_hex(v.modified, e.bg, 0.40) },
    DiffTextAdd        = { bg = H.blend_hex(v.added, e.bg, 0.40) },
    EndOfBuffer        = { fg = e.bg },
    TermCursor         = { link = 'Cursor' },
    OkMsg              = { fg = v.added },
    WarningMsg         = { fg = s.keyword },
    ErrorMsg           = { fg = c.error },
    StderrMsg          = { link = 'ErrorMsg' },
    WinSeparator       = { fg = u.line, bg = u.bg },
    Folded             = { fg = u.fg, bg = u.line },
    SignColumn         = { bg = e.bg },
    FoldColumn         = { link = 'SignColumn' },
    IncSearch          = { fg = e.bg, bg = e.find_match_active },
    Substitute         = { link = 'IncSearch' },
    LineNr             = { fg = e.line_number_normal },
    LineNrAbove        = { link = 'LineNr' },
    LineNrBelow        = { link = 'LineNr' },
    CursorLineNr       = { fg = e.line_number_active, bold = true },
    CursorLineFold     = { link = 'CursorLineNr' },
    CursorLineSign     = { link = 'CursorLineNr' },
    MatchParen         = { bg = H.blend_hex(c.accent_tint, e.bg, 0.25), underline = true },
    ModeMsg            = { fg = s.string, bold = true },
    MsgArea            = { fg = e.fg, bg = e.bg },
    StdoutMsg          = { link = 'MsgArea' },
    MsgSeparator       = { fg = u.line, bg = u.line },
    MoreMsg            = { link = 'ModeMsg' },
    NonText            = { fg = u.fg },
    Normal             = { fg = e.fg, bg = e.bg },
    NormalFloat        = { fg = u.fg, bg = u.popup_bg },
    FloatBorder        = { fg = u.line, bg = u.popup_bg },
    FloatShadow        = { bg = u.popup_shadow },
    FloatShadowThrough = { bg = u.popup_shadow },
    FloatTitle         = { fg = e.fg, bg = u.panel_bg, bold = true },
    FloatFooter        = { fg = u.fg, bg = u.panel_bg },
    NormalNC           = { fg = e.fg, bg = u.bg },
    Pmenu              = { fg = u.fg, bg = u.popup_bg },
    PmenuSel           = { fg = u.fg, bg = u.selection_active, bold = true },
  }
end

-- Validators -----------------------------------------------------------------

--- Validate a scheme name; `nil` is accepted (the field is optional).
---@param value      __colorscheme?
---@param value_name string
H.validate_scheme        = function(value, value_name)
  if value == nil then return end
  if not vim.tbl_contains(H.colorscheme_names, value) then
    H.error(string.format(
      '%s: unexpected color scheme %q. Valid values: %s',
      value_name, value, table.concat(H.colorscheme_names, ', ')
    ))
  end
end

--- Validate a palette map (all three schemes, all sections, all color values).
--- Unknown scheme names and unknown section names are treated as errors.
---
---@param value      { dark: __palette<__raw_color>, light: __palette<__raw_color>, mirage: __palette<__raw_color> }
---@param value_name string
H.validate_palette       = function(value, value_name)
  H.check_type(value_name, value, 'table')

  for scheme_name, scheme in pairs(value) do
    local scheme_attr = string.format('%s.%s', value_name, scheme_name)

    if not vim.tbl_contains(H.colorscheme_names, scheme_name) then
      H.error(string.format(
        '%s: unknown scheme %q. Valid values: %s',
        value_name, scheme_name, table.concat(H.colorscheme_names, ', ')
      ))
    end

    H.check_type(scheme_attr, scheme, 'table')

    for section_name, section in pairs(scheme) do
      local section_attr = string.format('%s.%s', scheme_attr, section_name)

      if not vim.tbl_contains(H.palette_section_names, section_name) then
        H.error(string.format(
          '%s: unknown palette section %q. Valid sections: %s',
          scheme_attr, section_name, table.concat(H.palette_section_names, ', ')
        ))
      end

      H.check_type(section_attr, section, 'table')

      for color_name, color in pairs(section) do
        H.validate_raw_color(color, string.format('%s.%s', section_attr, color_name))
      end
    end
  end
end

--- Validate a single raw color value (hex string or blend tuple).
---@param value      __raw_color
---@param value_name string
H.validate_raw_color     = function(value, value_name)
  if type(value) == 'string' then
    H.validate_hex(value, value_name)
  elseif type(value) == 'table' then
    H.validate_blend_tuple(value, value_name)
  else
    H.error(string.format(
      '%s: must be a hex color string "#rrggbb" or a blend tuple { fg, bg, alpha }, got %s',
      value_name, type(value)
    ))
  end
end

--- Validate that `value` is a hex color string of the form `"#rrggbb"`.
---@param value      __hex_color
---@param value_name string
H.validate_hex           = function(value, value_name)
  local ok = type(value) == 'string'
      and #value == 7
      and value:sub(1, 1) == '#'
      and tonumber(value:sub(2), 16) ~= nil

  if not ok then
    H.error(string.format(
      '%s: expected a hex color string "#rrggbb", got %q',
      value_name, tostring(value)
    ))
  end
end

--- Validate a blend tuple `{ fg, bg, alpha }`.
---@param value      __blend_tuple
---@param value_name string
H.validate_blend_tuple   = function(value, value_name)
  if #value ~= 3 then
    H.error(string.format(
      '%s: blend tuple must have exactly 3 elements { fg, bg, alpha }, got %d',
      value_name, #value
    ))
  end

  local fg, bg, alpha = unpack(value)

  H.validate_hex(fg, value_name .. '[1] (fg)')
  H.validate_hex(bg, value_name .. '[2] (bg)')
  H.check_type(value_name .. '[3] (alpha)', alpha, 'number')

  if alpha < 0 or alpha > 1 then
    H.error(string.format('%s[3] (alpha): must be in [0, 1], got %s', value_name, tostring(alpha)))
  end
end

-- Color computing ------------------------------------------------------------

--- Alpha-composite {fg} over {bg} with opacity {alpha} and return a hex string.
---
--- Formula per channel: `result = bg * (1 - alpha) + fg * alpha`
---
---@param fg    __hex_color
---@param bg    __hex_color
---@param alpha __alpha     Opacity in `[0, 1]`
---@return      __hex_color
H.blend_hex              = function(fg, bg, alpha)
  local fR, fG, fB = unpack(H.hex2rgb(fg))
  local bR, bG, bB = unpack(H.hex2rgb(bg))

  return H.rgb2hex({
    H.blend_channel(fR, bR, alpha),
    H.blend_channel(fG, bG, alpha),
    H.blend_channel(fB, bB, alpha),
  })
end

--- Blend a single channel value, rounded to the nearest integer.
---@param fg    integer Foreground channel `[0, 255]`
---@param bg    integer Background channel `[0, 255]`
---@param alpha __alpha
---@return      integer
H.blend_channel          = function(fg, bg, alpha)
  return math.floor(bg * (1 - alpha) + fg * alpha + 0.5)
end

-- Color conversion -----------------------------------------------------------

--- Parse a hex color string into an RGB triplet.
---@param  hex __hex_color
---@return     __rgb_color
H.hex2rgb                = function(hex)
  hex = hex:gsub('#', '')
  return {
    tonumber(hex:sub(1, 2), 16),
    tonumber(hex:sub(3, 4), 16),
    tonumber(hex:sub(5, 6), 16),
  }
end

--- Encode an RGB triplet as a lowercase hex color string.
--- Each channel is clamped to `[0, 255]` and rounded.
---@param  rgb __rgb_color
---@return     __hex_color
H.rgb2hex                = function(rgb)
  local t = vim.tbl_map(function(x)
    return math.floor(math.min(math.max(x, 0), 255) + 0.5)
  end, rgb)
  return string.format('#%02x%02x%02x', t[1], t[2], t[3])
end

-- Utilities ------------------------------------------------------------------

--- Validate the type of an argument.
---
--- `reference` may be:
--- - A Lua type name string (`'string'`, `'number'`, `'table'`, …)
--- - The special token `'callable'` (checked with `vim.is_callable()`)
--- - An array of the above (value must match at least one)
--- - A predicate `fun(v): boolean` (receives the value, returns ok flag)
---
--- When {value} is `nil` and {allow_nil} is `true`, validation is skipped.
---
---@param name      string                              Argument name used in error messages
---@param value     any                                 Value to validate
---@param reference string|string[]|fun(v: any):boolean Expected type(s) or predicate
---@param allow_nil boolean?                            When `true`, `nil` values are accepted
---@param message   string?                             Custom error message (overrides generated one)
H.check_type             = function(name, value, reference, allow_nil, message)
  if value == nil and allow_nil then return end

  local ok = false

  if type(reference) == 'table' then
    for _, t in ipairs(reference) do
      if (t == 'callable' and vim.is_callable(value)) or type(value) == t then
        ok = true
        break
      end
    end
  elseif type(reference) == 'string' then
    ok = reference == 'callable' and vim.is_callable(value) or type(value) == reference
  elseif vim.is_callable(reference) then
    ok = reference(value)
  end

  if not ok then
    local expected = type(reference) == 'table'
        and table.concat(reference, ' or ')
        or tostring(reference)
    H.error(message or string.format('`%s` should be %s, not %s', name, expected, type(value)))
  end
end

--- Raise a plugin-namespaced error.
---@param message string
---@param level   integer?  Error level per `error()` semantics (default: 0)
H.error                  = function(message, level)
  error('[ayu.nvim] ' .. message, level or 0)
end

-- Module export ==============================================================

return Ayu
