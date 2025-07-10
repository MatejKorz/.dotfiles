vim.cmd [[highlight ExtraWhitespace ctermbg=red guibg=#602725]]
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
    pattern = "*",
    command = [[match ExtraWhitespace /\s\+$/]]
})

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    command = [[match none]]
})
