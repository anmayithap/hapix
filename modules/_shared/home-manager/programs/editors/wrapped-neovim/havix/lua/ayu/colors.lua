--- *ayu.colors* Ayu color palette definitions
---
--- MIT License Copyright (c) 2026 Ruslan Torbeev

--- The single source of truth for all ayu color values. Exposes the raw
--- palette for all three schemes - `dark`, 'light' and `mirage` - organized
--- into semantic groups: `syntax`, `editor`, `ui`, `terminal`, `vcs` and
--- `common`
---
--- The palette is available at runtime via `_G.AyuColors.config.palette`
--- after |ayu.colors.setup()| is called.
---
--- Colors are defined as `#RRGGBB` hex strings. Values derived from the
--- original `HEXA` source (e.g. `selectionActive`) are precomputed via alpha
--- compositing using `utils.blend_hex`
---
--- Source: https://github.com/ayu-theme/ayu-colors

---@class (exact) AyuPalette
---@field syntax AyuPaletteSyntax
---@field terminal AyuPaletteTerminal
---@field vcs AyuPaletteVCS
---@field editor AyuPaletteEditor
---@field ui AyuPaletteUI
---@field common AyuPaletteCommon

--- Syntax token colors
---@class (exact) AyuPaletteSyntax
---@field tag string HTML/XML tags and built-in type names
---@field func string Function and method names
---@field entity string Type and class names
---@field string string String literals
---@field regexp string Regular expressions and escape sequences
---@field markup string Markup emphasis and member variables
---@field keyword string Language keywords
---@field special string Decorators and macros
---@field comment string Comments
---@field constant string Static variables and number literals
---@field operator string Language operators

--- Terminal colors (16-color ANSI palette + `fg`/`bg`)
---@class (exact) AyuPaletteTerminal
---@field fg string Default foreground
---@field bg string Default background
---@field black string ANSI black
---@field red string ANSI red
---@field green string ANSI green
---@field yellow string ANSI yellow
---@field blue string ANSI blue
---@field magenta string ANSI magenta
---@field cyan string ANSI cyan
---@field white string ANSI white
---@field brightBlack string ANSI bright black
---@field brightRed string ANSI bright red
---@field brightGreen string ANSI bright green
---@field brightYellow string ANSI bright yellow
---@field brightBlue string ANSI bright blue
---@field brightMagenta string ANSI bright magenta
---@field brightCyan string ANSI bright cyan
---@field brightWhite string ANSI bright white

--- Version control status colors
---@class (exact) AyuPaletteVCS
---@field added string Added lines
---@field modified string Modified lines
---@field removed string Removed lines

--- Editor chrome colors (gutters, selections, line highlight)
---@class (exact) AyuPaletteEditor
---@field fg string Default foreground
---@field bg string Default background
---@field selectionActive string Active selection background (blended)
---@field selectionInactive string Inactive selection background (blended)
---@field findMatchActive string Active find match background
---@field findMatchInactive string Inactive find match background (blended)
---@field lineNumberActive string Active line number foreground (blended)
---@field lineNumberNormal string Normal line number foreground (blended)
---@field indentGuideActive string Active indent guide color (blended)
---@field indentGuideNormal string Normal indent guide color (blended)
---@field line string Current line hightlight background

--- UI panel and popup colors
---@class (exact) AyuPaletteUI
---@field fg string Default foreground
---@field bg string Default background
---@field selectionActive string Active selection background (blended)
---@field selectionNormal string Normal selection background (blended)
---@field panelBG string Panel background
---@field panelShadow string Panel shadow (blended)
---@field popupBG string Popup background
---@field popupShadow string Popup shadow (blended)
---@field line string UI line separator

--- Common accent and semantic colors
---@class (exact) AyuPaletteCommon
---@field accentTint string Primary accent color
---@field accentOn string Foreground color for use on top of accentTint
---@field error string Error color

--- Module config. Modify via |ayu.colors.setup()|, not directly.
---@class (exact) AyuColorsConfig
---@field palette { dark: AyuPalette, light: AyuPalette, mirage: AyuPalette } Per-scheme palette definitions

-- Module requirements ========================================================

---@module "ayu.utils"
local utils = require('ayu.utils')

local Validator = nil

-- Falls back too built-in `vim.validate()` if `havidate` is unavailable
local ok, ValidationModule = pcall(require, 'havidate')

if ok then
  Validator = ValidationModule.check_type
else
  Validator = vim.validate
end

-- Module definition ==========================================================

local AyuColors = {}
local H = {}

--- Set up ayu.colors and optionally override palette values.
---
--- Must be called before any highlight application. Merges {config} deeply
--- over built-in defaults, so partial overrides are safe - only the keys
--- you provide will change
---
--- After setup, the resolved config is available at `_G.AyuColors.config`.
---
---@param config AyuColorsConfig? Pratial config to merge over defaults
---
---@usage >lua
---   require('ayu.colors').setup() -- setup with default colors
---   -- OR
---   require('ayu.colors').setup({}) -- replace {} with your config table
--- <
AyuColors.setup = function(config)
  -- Export module
  _G.AyuColors = AyuColors

  -- Set up config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)
end

---@type AyuColorsConfig
AyuColors.config = {
  palette = {
    dark = {
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
        brightBlack = '#0a0000',
        brightRed = '#f07178',
        brightGreen = '#aad94c',
        brightYellow = '#ffb454',
        brightBlue = '#59c2ff',
        brightMagenta = '#d2a6ff',
        brightCyan = '#95e6cb',
        brightWhite = '#ffffff',
      },
      vcs = {
        added = '#70bf56',
        modified = '#73b8ff',
        removed = '#f26d78',
      },
      editor = {
        fg = '#bfbdb6',
        bg = '#10141c',
        selectionActive = utils.blend_hex('#3388ff', '#10141c', 0.25),
        selectionInactive = utils.blend_hex('#80b5ff', '#10131c', 0.15),
        findMatchActive = '#4c4126',
        findMatchInactive = utils.blend_hex('#4c4126', '#10131c', 0.5),
        lineNumberActive = '#5a6378',
        lineNumberNormal = utils.blend_hex('#5a6378', '#10141c', 0.65),
        indentGuideActive = utils.blend_hex('#5a6378', '#10131c', 0.63),
        indentGuideNormal = utils.blend_hex('#5a6378', '#10131c', 0.26),
        line = '#161a24',
      },
      ui = {
        fg = '#5a6378',
        bg = '#0d1017',
        selectionActive = utils.blend_hex('#475266', '#0d1017', 0.25),
        selectionNormal = utils.blend_hex('#475266', '#0d1017', 0.2),
        panelBG = '#141821',
        panelShadow = utils.blend_hex('#000000', '#0d1017', 0.5),
        popupBG = '#0f131a',
        popupShadow = utils.blend_hex('#000000', '#0d1017', 0.5),
        line = '#1b1f29',
      },
      common = {
        accentTint = '#e6b450',
        accentOn = '#765b24',
        error = '#d95757',
      },
    },
    light = {
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
        brightBlack = '#939498',
        brightRed = '#f07171',
        brightGreen = '#86b300',
        brightYellow = '#eba400',
        brightBlue = '#22a4e6',
        brightMagenta = '#a37acc',
        brightCyan = '#4cbf99',
        brightWhite = '#c5c5c8',
      },
      vcs = {
        added = '#6cbf43',
        modified = '#478acc',
        removed = '#ff7383',
      },
      editor = {
        fg = '#5c6166',
        bg = '#fcfcfc',
        selectionActive = utils.blend_hex('#035bd6', '#fcfcfc', 0.15),
        selectionInactive = utils.blend_hex('#035bd6', '#fcfcfc', 0.07),
        findMatchActive = '#ffe294',
        findMatchInactive = utils.blend_hex('#ffe294', '#fcfcfc', 0.5),
        lineNumberActive = utils.blend_hex('#828e9f', '#fcfcfc', 0.8),
        lineNumberNormal = utils.blend_hex('#828e9f', '#fcfcfc', 0.4),
        indentGuideActive = utils.blend_hex('#828e9f', '#fcfcfc', 0.35),
        indentGuideNormal = utils.blend_hex('#828e9f', '#fcfcfc', 0.18),
        line = utils.blend_hex('#828e9f', '#fcfcfc', 0.1),
      },
      ui = {
        fg = '#828e9f',
        bg = '#f8f9fa',
        line = utils.blend_hex('#6b7d8f', '#f8f9fa', 0.12),
        selectionActive = utils.blend_hex('#6b7d8f', '#f8f9fa', 0.24),
        selectionNormal = utils.blend_hex('#6b7d8f', '#f8f9fa', 0.12),
        panelBG = '#fafafa',
        panelShadow = utils.blend_hex('#6b7d8f', '#f8f9fa', 0.07),
        popupBG = '#ffffff',
        popupShadow = utils.blend_hex('#6b7d8f', '#f8f9fa', 0.1),
      },
      common = {
        accentTint = '#f29718',
        accentOn = '#7e4b01',
        error = '#e65050',
      },
    },
    mirage = {
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
        brightBlack = '#0a0000',
        brightRed = '#f39184',
        brightGreen = '#d5ff80',
        brightYellow = '#ffcd66',
        brightBlue = '#73d0ff',
        brightMagenta = '#dfbfff',
        brightCyan = '#95e6cb',
        brightWhite = '#e3e6ea',
      },
      vcs = {
        added = '#87d96c',
        modified = '#80bfff',
        removed = '#f27983',
      },
      editor = {
        fg = '#cccac2',
        bg = '#242936',
        selectionActive = utils.blend_hex('#409FFF', '#242936', 0.25),
        selectionInactive = utils.blend_hex('#409FFF', '#242936', 0.13),
        findMatchActive = '#736950',
        findMatchInactive = utils.blend_hex('#736950', '#242936', 0.4),
        lineNumberActive = '#707a8c',
        lineNumberNormal = utils.blend_hex('#707a8c', '#242936', 0.5),
        indentGuideActive = utils.blend_hex('#707a8c', '#242936', 0.44),
        indentGuideNormal = utils.blend_hex('#707a8c', '#242936', 0.23),
        line = '#1a1f29',
      },
      ui = {
        fg = '#707a8c',
        bg = '#1f2430',
        line = '#171b24',
        selectionActive = utils.blend_hex('#637599', '#1f2430', 0.15),
        selectionNormal = utils.blend_hex('#69758c', '#1f2430', 0.12),
        panelBG = '#282e3b',
        panelShadow = utils.blend_hex('#000000', '#1f2430', 0.2),
        popupBG = '#1c212c',
        popupShadow = utils.blend_hex('#000000', '#1f2430', 0.3),
      },
      common = {
        accentTint = '#ffcc66',
        accentOn = '#735923',
        error = '#ff6666',
      },
    },
  },
}

-- Helper data ================================================================

--- Module default config
---@type AyuColorsConfig
H.default_config = vim.deepcopy(AyuColors.config)

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------

---@param config AyuColorsConfig?
---@return AyuColorsConfig
H.setup_config = function(config)
  Validator('config', config, 'table', true)
  config =
    vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})

  Validator('config.palette', config.palette, 'table', false)

  return config
end

---@param config AyuColorsConfig
H.apply_config = function(config) AyuColors.config = config end

-- Module export ==============================================================

return AyuColors
