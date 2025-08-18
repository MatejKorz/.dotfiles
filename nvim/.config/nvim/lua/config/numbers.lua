vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "alpha" then
            vim.opt.relativenumber = true
        end
    end
})

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "alpha" then
        vim.opt.relativenumber = false
        end
    end
})
