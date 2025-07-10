vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
    pattern = "*",
    callback = function ()
        vim.opt.relativenumber = true
    end
})

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function ()
        vim.opt.relativenumber = false
    end
})
