-- ============================================================================
-- [HAVIX] Util > Options
-- ============================================================================

-- Module Definition ==========================================================

local H = {}

--- @class (exact) OptionC
--- @field o table<string, any>
--- @field opt table<string, any>
--- @field set_win_border fun(border: (Border | BorderFillChars)?)
local OptionC = {}

-- Helper data ================================================================

--- @enum (key) BorderFillChars
H.win_borders_fillchars = {
  bold = 'vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣,msgsep:━',
  dot = 'vert:·,horiz:·,horizdown:·,horizup:·,verthoriz:·,vertleft:·,vertright:·,msgsep:·',
  double = 'vert:║,horiz:═,horizdown:╦,horizup:╩,verthoriz:╬,vertleft:╣,vertright:╠,msgsep:═',
  single = 'vert:│,horiz:─,horizdown:┬,horizup:┴,verthoriz:┼,vertleft:┤,vertright:├,msgsep:─',
  solid = 'vert: ,horiz: ,horizdown: ,horizup: ,verthoriz: ,vertleft: ,vertright: ,msgsep: ',
}

--- @enum (key) Border
H.win_border_map = { none = 'solid', rounded = 'single', shadow = 'solid' }

H.o = setmetatable({}, {
  __newindex = function(_, key, value)
    local was_set =
      vim.api.nvim_get_option_info2(key, { scope = 'global' }).was_set

    if was_set then return end

    vim.o[key] = value
  end,
})

--- @diagnostic disable: redundant-return-value
H.opt = setmetatable({}, {
  __newindex = function(_, key)
    local was_set =
      vim.api.nvim_get_option_info2(key, { scope = 'global' }).was_set

    if was_set then
      return { append = function() end, remove = function() end }
    end

    return vim.opt[key]
  end,
})

-- Helper functionality =======================================================

--- Set win border
---
--- @param border (BorderFillChars | Border)?
function H.set_win_border(border)
  local win_border = border or 'auto'

  local option_value = vim.o.winborder
  win_border = H.win_border_map[option_value] or option_value

  local border_chars = H.win_borders_fillchars[win_border]

  if border_chars ~= nil then vim.opt.fillchars:append(border_chars) end
end

-- Module Exports =============================================================

OptionC.o = H.o
OptionC.opt = H.opt
OptionC.set_win_border = H.set_win_border

return OptionC
