vim.cmd [[highlight ExtraWhitespace ctermbg=red guibg=#602725]]

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
    callback = function(args)
        local buftype = vim.bo[args.buf].buftype
        local filetype = vim.bo[args.buf].filetype
        local excluded = { "help", "qf", "terminal", "TelescopePrompt", "lazy" }

        if buftype == "" and not vim.tbl_contains(excluded, filetype) then
            vim.cmd [[match ExtraWhitespace /\s\+$/]]
        else
            vim.cmd [[match none]]
        end
    end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    command = [[match none]]
})
