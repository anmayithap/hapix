--- *hapix.sched* module

--- Module definition =========================================================

local HapixSched = {}
local H = {}

--- Module setup
---
--- @param config table|nil Module config table. See |HapixSched.config|.
HapixSched.setup = function(config)
    _G.HapixSched = HapixSched

    config = H.setup_config(config)

    H.apply_config(config)
end

HapixSched.config = {
    -- Whether to disable showing non-error feedback
    silent = false,
}

--- Execute function now
---
--- @param f function Callable to execute.
HapixSched.now = function(f)
    local ok, err = pcall(f)
    if not ok then table.insert(H.cache.exec_errors, err) end
    H.schedule_finish()
end

--- Execute function later
---
---
---@param f function Callable to execute.
HapixSched.later = function(f)
    table.insert(H.cache.later_callback_queue, f)
    H.schedule_finish()
end

--- Helper data ===============================================================
-- Module default config
H.default_config = HapixSched.config

--- Various cache
H.cache = {
    -- Whether finish of `now()` or `later()` is already scheduled
    finish_is_scheduled = false,

    -- Callback queue for `later()`
    later_callback_queue = {},

    -- Errors during execution of `now()` or `later()`
    exec_errors = {},
}

--- Helper functionality ======================================================
--- Settings ------------------------------------------------------------------
H.setup_config = function(config)
    H.check_type('config', config, 'table', true)
    config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})

    H.check_type('silent', config.silent, 'boolean')

    return config
end

H.apply_config = function(config)
    HapixSched.config = config
end

H.get_config = function(config)
    return vim.tbl_deep_extend('force', HapixSched.config, vim.b.hapix_sched_config or {}, config or {})
end

-- Two-stage execution --------------------------------------------------------
H.schedule_finish = function()
    if H.cache.finish_is_scheduled then return end
    vim.schedule(H.finish)
    H.cache.finish_is_scheduled = true
end

H.finish = function()
    local timer, step_delay = vim.loop.new_timer(), 1
    local f = nil
    f = vim.schedule_wrap(function()
        local callback = H.cache.later_callback_queue[1]
        if callback == nil then
            H.cache.finish_is_scheduled, H.cache.later_callback_queue = false, {}
            H.report_errors()
            return
        end

        table.remove(H.cache.later_callback_queue, 1)
        HapixSched.now(callback)
        timer:start(step_delay, 0, f)
    end)
    timer:start(step_delay, 0, f)
end

H.report_errors = function()
    if #H.cache.exec_errors == 0 then return end
    local error_lines = table.concat(H.cache.exec_errors, '\n\n')
    H.cache.exec_errors = {}
    H.notify('There were errors during two-stage execution:\n\n' .. error_lines, 'ERROR')
end

-- Utilities ------------------------------------------------------------------
H.error = function(msg) error('(hapix.sched) ' .. msg, 0) end

H.check_type = function(name, val, ref, allow_nil)
    if type(val) == ref or (ref == 'callable' and vim.is_callable(val)) or (allow_nil and val == nil) then return end
    H.error(string.format('`%s` should be %s, not %s', name, ref, type(val)))
end

H.notify = vim.schedule_wrap(function(msg, level)
    level = level or 'INFO'
    if H.get_config().silent and level ~= 'ERROR' and level ~= 'WARN' then return end
    if type(msg) == 'table' then msg = table.concat(msg, '\n') end
    vim.notify(string.format('(hapix.sched) %s', msg), vim.log.levels[level])
    vim.cmd('redraw')
end)

return HapixSched
