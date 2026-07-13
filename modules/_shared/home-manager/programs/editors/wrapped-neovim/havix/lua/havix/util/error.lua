-- ============================================================================
-- [HAVIX] Util > Error
-- ============================================================================

-- Module Definition ==========================================================

local H = {}

--- HAVIX error constructor
--- @class (exact) ErrorC
--- @overload fun(module: string): HavixError
local ErrorC = {}

-- Helper functionality =======================================================

--- HAVIX error constructor

--- @alias HavixError fun(message: string): nil

--- @param module string
--- @return HavixError
function H.new(module)
  return function(message) error('(' .. module .. ')' .. message, 0) end
end

-- Module Exports =============================================================

ErrorC = H.new

return ErrorC
