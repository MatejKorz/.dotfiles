local opt = vim.opt

opt.relativenumber = false
opt.number = true
opt.scrolloff = 10
opt.sidescrolloff = 6

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "80,110,140"
opt.cursorline = true

opt.undofile = true
opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")

opt.errorbells = false
