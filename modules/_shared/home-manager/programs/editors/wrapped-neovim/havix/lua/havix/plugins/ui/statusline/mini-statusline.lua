-- ============================================================================
-- [HAVIX] Plugins > UI > Statusline > mini.statusline
-- ============================================================================
-- Module Requirements ========================================================


---@module "lua.havix.util.manager"
local Factory = require("havix.util.manager")
---@module "lua.havix.util.functions"
local Function = require("havix.util.functions")

-- Module Definition ==========================================================

local H = {}

local manager = Factory.new(
    {},
    {
        function(_, opts)
            return {
                "mini.statusline",
                auto_enable = true,
                disable_for_vscode = true,
                for_spec = "statusline",

                after = function()
                    local statusline = require("mini.statusline")

                    statusline.setup(
                        {
                            use_icons = opts.settings.specs["icons"] or false,

                            content = {
                                inactive = function()
                                    local pathname = H.section_pathname({ trunc_width = 120 })

                                    return statusline.combine_groups(
                                        {
                                            { hl = "MiniStatuslineInactive", strings = { pathname } },
                                        }
                                    )
                                end,
                                active = function()
                                    local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
                                    local git           = statusline.section_git({ trunc_width = 40 })
                                    local diff          = statusline.section_diff({ trunc_width = 80 })
                                    local diagnostics   = statusline.section_diagnostics({ trunc_width = 80 })
                                    local lsp           = statusline.section_lsp({ trunc_width = 80 })
                                    local filetype      = H.section_filetype({ trunc_width = 80 })
                                    local pathname      = H.section_pathname({
                                        trunc_width = 120,
                                        filename_hl = "MiniStatuslineFilename",
                                        modified_hl = "MiniStatuslineFilenameModified",
                                        modified_icon = opts.icons.git.modified,
                                    })
                                    local location      = H.section_location({ trunc_width = 120 })
                                    local file_encoding = H.section_file_encoding({ trunc_width = 80 })
                                    local file_format   = H.section_file_format({ trunc_width = 80 })
                                    local tabstop       = H.section_tabstop({ trunc_width = 80 })

                                    return statusline.combine_groups(
                                        {
                                            { hl = mode_hl,                  strings = { mode:upper() } },
                                            { hl = 'MiniStatuslineDevinfo',  strings = { git, diff } },
                                            { hl = 'MiniStatuslineFileinfo', strings = { diagnostics } },
                                            "%<",
                                            { hl = 'MiniStatuslineDirectory', strings = { pathname } },
                                            '%=',
                                            { hl = 'MiniStatuslineDirectory', strings = { tabstop, file_encoding, file_format, } },
                                            { hl = 'MiniStatuslineFileinfo',  strings = { filetype, lsp } },
                                            { hl = mode_hl,                   strings = { location } },
                                            { hl = 'MiniStatuslineDirectory', strings = {} },
                                        }
                                    )
                                end,
                            },
                        }
                    )
                end,

                lazy = false,
            }
        end,
    }
)

-- Helper data ================================================================

H.python = {
    path = nil,
    version = "",
}

-- Helper functionality =======================================================

--- Provide filetype section
---
---@param args { trunc_width: integer }
---@return string
function H.section_filetype(args)
    local filetype = vim.bo.filetype

    if (filetype == "") or (vim.bo.buftype ~= "") then return "" end

    local icon, _ = Function.get_filetype_icon()
    local metadata = ""

    if filetype == "python" then
        local python_version = H.get_python_version()

        if python_version ~= "" then
            metadata = "(" .. python_version .. ")"
        end
    end

    if MiniStatusline.is_truncated(args.trunc_width) then
        if icon ~= "" then
            return string.format("%s %s", icon, metadata)
        else
            return ""
        end
    else
        if icon ~= "" then
            return string.format("%s %s %s", icon, filetype, metadata)
        else
            return string.format("%s %s", filetype, metadata)
        end
    end
end

-- Provide python interpreter section
---
---@return string
function H.get_python_version()
    if vim.bo.filetype ~= "python" then
        return ""
    end

    local ok, m = pcall(require, "venv-selector")

    if not ok then
        return ""
    end

    local python_path = m.python()

    if not python_path then
        return ""
    end

    if python_path ~= H.python.path then
        vim.system({ 'python', '--version' }, { text = true }, function(obj)
            vim.schedule(function()
                if obj.code == 0 then
                    H.python.version = obj.stdout:gsub("Python%s+", ""):gsub("%s+", "")
                else
                    H.python.version = ""
                end
            end)
        end)

        H.python.path = python_path
    end

    return H.python.version
end

--- Provide pathname section
---
---@param args { trunc_width: integer, filename_hl: string?, modified_hl: string?, modified_icon: string? }
---@return string
function H.section_pathname(args)
    args = vim.tbl_extend(
        "force",
        {
            modified_hl = nil,
            modified_icon = nil,
            filename_hl = nil,
            trunc_width = 80,
        },
        args or {}
    )

    if vim.bo.buftype == "terminal" then return "%t" end

    local path = vim.fn.expand("%:p")
    local cwd = vim.uv.cwd() or ""
    cwd = vim.uv.fs_realpath(cwd) or ""

    if path:find(cwd, 1, true) == 1 then path = path:sub(#cwd + 2) end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, sep)
    if MiniStatusline.is_truncated(args.trunc_width) and #parts > 3 then
        parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
    end

    local dir = ""
    if #parts > 1 then dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep end

    local file = parts[#parts]
    local file_hl = ""
    if vim.bo.modified and args.modified_hl then
        file_hl = "%#" .. args.modified_hl .. "#"
    elseif args.filename_hl then
        file_hl = "%#" .. args.filename_hl .. "#"
    end

    local modified_icon = args.modified_icon or "[+]"

    local modified = vim.bo.modified and " " .. modified_icon or ""
    return dir .. file_hl .. file .. modified
end

--- Provide location section
---
---@param args { trunc_width: integer }
---@return string
function H.section_location(args)
    -- Use virtual column number to allow update when past last column
    if MiniStatusline.is_truncated(args.trunc_width) then return "%-2l│%-2v" end

    return "󰉸 %-2l│󱥖 %-2v"
end

--- Provide file encoding section
---
---@param args { trunc_width: integer }
---@return string
function H.section_file_encoding(args)
    if MiniStatusline.is_truncated(args.trunc_width) then return "" end

    return (vim.bo.fileencoding or vim.bo.encoding):upper()
end

--- Provide file format section
---
---@param args { trunc_width: integer }
---@return string
function H.section_file_format(args)
    if MiniStatusline.is_truncated(args.trunc_width) then return "" end

    local format = "UB"

    if vim.bo.fileformat == "dos" then
        format = "CRLF"
    elseif vim.bo.fileformat == "unix" then
        format = "LF"
    elseif vim.bo.fileformat == "mac" then
        format = "CR"
    end

    return format
end

--- Provide file tabstop section
---
---@param args { trunc_width: integer }
---@return string
function H.section_tabstop(args)
    local prefix = "spaces:"

    if MiniStatusline.is_truncated(args.trunc_width) then prefix = "sp:" end

    return prefix .. vim.bo.tabstop
end

-- Module Exports =============================================================

return manager
