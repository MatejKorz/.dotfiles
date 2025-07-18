return { 
    "ellisonleao/gruvbox.nvim", 
    priority = 1000, 
    opts = {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
            strings = false,
            emphasis = true,
            comments = false,
            operators = false,
            folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
    },
    config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.o.background = "dark"
        vim.cmd([[colorscheme gruvbox]])
    end,
}
