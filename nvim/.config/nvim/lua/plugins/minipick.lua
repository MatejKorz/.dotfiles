return {
    'echasnovski/mini.pick',
    version = false,
    opts = {
    },
    config = function(_, opts)
        local pick = require('mini.pick')
        pick.setup(opts)
        local keymap = vim.keymap
        keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "Find files" })
        keymap.set("n", "<leader>fg", pick.builtin.grep_live, { desc = "Live grep" })
        keymap.set("n", "<leader>fb", pick.builtin.buffers, { desc = "Find buffers" })
        keymap.set("n", "<leader>fh", pick.builtin.help, { desc = "Help tags" })
    end
}
