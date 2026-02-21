--- *hapix.helper* module

--- Module definition =========================================================

local HapixHelper = {}

--- Module setup
HapixHelper.setup = function()
    _G.HapixHelper = HapixHelper
end

--- Do something with other buffers
---
--- @param f function Callable to execute.
--- @param ... any Arguments to pass to `f`.
--- @return nil
HapixHelper.with_other_buffers = function(f, ...)
    local current_buffer = vim.api.nvim_get_current_buf()

    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
        if buffer ~= current_buffer then
            f(buffer, ...)
        end
    end
end

return HapixHelper
