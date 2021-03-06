require("utils").define_augroups({
    _general_settings = {
        {
            "TextYankPost",
            "*",
            'lua require("vim.highlight").on_yank({higroup = "Search", timeout = 200})',
        },
        {
            "BufWinEnter",
            "*",
            "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
        },
        {
            "BufRead",
            "*",
            "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
        },
        {
            "BufNewFile",
            "*",
            "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
        },
        { "VimLeavePre", "*", "set title set titleold=" },
        { "VimLeave", "*", "set guicursor=a:ver100-blinkoff700-blinkon700" }, -- Restore alacritty cursor on exit
        { "FileType", "qf", "set nobuflisted" },
    },

    -- Add a call to the setup() function (in their config) of any plugin using the autogenerated highlight groups
    _colors = {
        {
            "ColorScheme",
            "*",
            [[
                lua require("colors").gen_highlights();
            ]],
            -- FIX: Calling feline's setup in its config at this point crashes
            -- lua require("plugins.configs.feline");
            -- ]]
        },
    },

    _lsp = {
        {
            "CursorHold",
            "*",
            "Lspsaga show_line_diagnostics",
        },
    },

    _markdown = {
        { "FileType", "markdown", "setlocal wrap" },
        { "FileType", "markdown", "setlocal spell" },
    },

    _buffer_bindings = {
        { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
    },
})
