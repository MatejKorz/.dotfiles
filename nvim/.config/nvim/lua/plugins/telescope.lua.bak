return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {'nvim-lua/plenary.nvim', 
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { "nvim-tree/nvim-web-devicons", opts = {} }
    },
    opts = {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            }	
        }
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap
        keymap.set("n", "<leader>ff", builtin.find_files, {desc = "Find files"})
        keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "Live grep"})
        keymap.set("n", "<leader>fb", builtin.buffers, {desc = "Find buffers"})
        keymap.set("n", "<leader>fh", builtin.help_tags, {desc = "Help tags"})
    end   
}
