-- NOTE: You can discover all highlight groups the current colorscheme defines by executing ':hi'
-- TODO: Redefine DAP UI colours (these ones: https://github.com/rcarriga/nvim-dap-ui/blob/master/lua/dapui/config/highlights.lua)

local M = {}

-- Catppuccin
vim.g.catppuccin_flavour = "macchiato"

-- Github
vim.g.github_function_style = "italic"
vim.g.github_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Tokyonight
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Colorscheme
vim.cmd("let g:nvcode_termcolors=256")
vim.g.syntax = true
vim.g.colors_name = "onedark"
vim.cmd("set background=dark")

-- Fixes to default highlight groups
vim.cmd("hi! link NonText LineNr")
vim.cmd("hi! link EndOfBuffer Normal")
vim.cmd([[let &fcs='eob: ']]) -- remove the tilde (~) after EOF

-- Word under cursor highlighting
local cursor_bg = vim.api.nvim_exec('echo synIDattr(synIDtrans(hlID("CursorLine")), "bg")', true)
vim.cmd("hi LspReferenceRead gui=underline guibg=" .. cursor_bg)
vim.cmd("hi LspReferenceText gui=underline guibg=" .. cursor_bg)
vim.cmd("hi LspReferenceWrite gui=underline guibg=" .. cursor_bg)

-- Autogenerated highlight groups based on current colorscheme

local function highlight(group, color)
    local style = color.style and "gui=" .. color.style or "gui=NONE"
    local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
    local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
    local sp = color.sp and "guisp=" .. color.sp or ""
    local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp
    vim.cmd(hl)

    if color.link then
        vim.cmd("highlight! link " .. group .. " " .. color.link)
    end
end

local function fromhl(hl)
    local result = {}
    local list = vim.api.nvim_get_hl_by_name(hl, true)
    for k, v in pairs(list) do
        local status, res = pcall(string.format, "#%06x", v)
        if status then
            local name = k == "background" and "bg" or "fg"
            result[name] = res
        end
    end
    return result
end

local function term(num, default)
    local key = "terminal_color_" .. num
    return vim.g[key] and vim.g[key] or default
end

local function colors_from_theme()
    return {
        normal_bg = fromhl("Normal").bg,
        bg = fromhl("StatusLine").bg,
        alt = fromhl("CursorLine").bg,
        fg = fromhl("StatusLine").fg,
        hint = fromhl("DiagnosticHint").fg or "#5E81AC",
        info = fromhl("DiagnosticInfo").fg or "#81A1C1",
        warn = fromhl("DiagnosticWarn").fg or "#EBCB8B",
        err = fromhl("DiagnosticError").fg or "#EC5F67",
        black = term(0, "#434C5E"),
        red = term(1, "#EC5F67"),
        green = term(2, "#8FBCBB"),
        yellow = term(3, "#EBCB8B"),
        blue = term(4, "#5E81AC"),
        magenta = term(5, "#B48EAD"),
        cyan = term(6, "#88C0D0"),
        white = term(7, "#ECEFF4"),
    }
end

-- This function must be called on an autocmd when the colorscheme is changed
-- After the function is called, UI components using these highlight groups must also be reloaded
M.gen_highlights = function()
    local c = colors_from_theme()
    local sfg = vim.o.background == "dark" and c.black or c.white
    local sbg = vim.o.background == "dark" and c.white or c.black
    M.colors = c

    local groups = {
        -- Feline

        FlnViBlack = { fg = c.white, bg = c.black, style = "bold" },
        FlnViRed = { fg = c.bg, bg = c.red, style = "bold" },
        FlnViGreen = { fg = c.bg, bg = c.green, style = "bold" },
        FlnViYellow = { fg = c.bg, bg = c.yellow, style = "bold" },
        FlnViBlue = { fg = c.bg, bg = c.blue, style = "bold" },
        FlnViMagenta = { fg = c.bg, bg = c.magenta, style = "bold" },
        FlnViCyan = { fg = c.bg, bg = c.cyan, style = "bold" },
        FlnViWhite = { fg = c.bg, bg = c.white, style = "bold" },

        FlnBlack = { fg = c.black, bg = c.white },
        FlnRed = { fg = c.red, bg = c.bg },
        FlnGreen = { fg = c.green, bg = c.bg },
        FlnYellow = { fg = c.yellow, bg = c.bg },
        FlnBlue = { fg = c.blue, bg = c.bg },
        FlnMagenta = { fg = c.magenta, bg = c.bg },
        FlnCyan = { fg = c.cyan, bg = c.bg },
        FlnWhite = { fg = c.white, bg = c.bg },

        FlnHint = { fg = c.hint, bg = c.bg },
        FlnInfo = { fg = c.info, bg = c.bg },
        FlnWarn = { fg = c.warn, bg = c.bg },
        FlnError = { fg = c.err, bg = c.bg },
        FlnStatus = { fg = sfg, bg = sbg, style = "bold" },

        FlnText = { fg = sbg, bg = c.bg },
        FlnBoldText = { fg = sbg, bg = c.bg, style = "bold" },
        FlnSep = { fg = c.bg, bg = c.bg },
        FlnGitBranch = { fg = sbg, bg = c.bg },
        FlnNavic = { fg = sbg, bg = c.bg },

        -- LSPSaga
        LspFloatWinBorder = { fg = sbg, bg = c.normal_bg },
        LspSagaBorderTitle = { fg = sbg, bg = c.normal_bg },
        LspSagaRenameBorder = { fg = sbg, bg = c.normal_bg },
        LspSagaHoverBorder = { fg = sbg, bg = c.normal_bg },
        LspSagaSignatureHelpBorder = { fg = sbg, bg = c.normal_bg },
        LspSagaCodeActionBorder = { fg = sbg, bg = c.normal_bg },
        LspSagaDefPreviewBorder = { fg = sbg, bg = c.normal_bg },
        LspLinesDiagBorder = { fg = sbg, bg = c.normal_bg },
        LspSagaDiagnosticBorder = { fg = sbg, bg = c.normal_bg },
        LspSagaDiagnosticTruncateLine = { fg = sbg, bg = c.normal_bg },
        LspSagaShTruncateLine = { fg = sbg, bg = c.normal_bg },
        LspSagaDocTruncateLine = { fg = sbg, bg = c.normal_bg },
        LspSagaCodeActionTruncateLine = { fg = sbg, bg = c.normal_bg },
    }

    for k, v in pairs(groups) do
        highlight(k, v)
    end
end

M.gen_highlights()

return M
