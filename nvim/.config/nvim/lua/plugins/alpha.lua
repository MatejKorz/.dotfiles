return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local dashboard = {
            layout = {},
            opts = {
                margin = 5,
            }
        }

        local function get_fortune()
           if vim.fn.executable('fortune') == 1 then
               local handle = io.popen("fortune -a")
               local result = handle:read("*a")
               handle:close()

               result = result:gsub("\t", "    ")
               local lines = {}
               for line in result:gmatch("[^\n]+") do
                   table.insert(lines, line)
               end
               return lines
           else
                return {"misfortune"}
           end
        end

        local fortune = {
            type = "text",
            val = get_fortune(),
            opts = {
                position = "center",
                hl = "Type"
            }
        }

        local header = {
            type = "text",
            val = {
                "⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⡆⠀⠀⢀⣶⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣇⣀⣀⣼⣿⠆⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⣠⡟⡝⣿⣿⣿⠿⢯⠀⠀⠀",
                "⣀⠀⢀⣆⠀⠀⣰⣿⣷⣶⣿⣿⣿⣭⣼⣇⠀⠀",
                "⢹⣷⣼⡿⡄⢰⣿⠟⣁⠀⣀⠈⠙⣿⣿⣿⣀⠀",
                "⢸⣦⣿⣷⣷⠈⡏⠈⠉⠈⠉⠈⠓⢿⣿⣿⣿⡇",
                "⢸⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⠟⠀",
                "⠀⠉⠉⠉⠀⠀⠀⠈⠁⠀⠀⠀⠀⠈⠁⠀⠀⠀",
            },
            opts = {
                position = "center",
                hl = "String"
            }
        }

        local buttons = {
            type = "group",
            val = {
                {
                    type = "button",
                    val = " new file",
                    opts = {
                        position = "center",
                        shortcut = "n",
                        align_shortcut = "left",
                        keymap = { "n", "n", "<cmd>enew<CR>", { noremap = true, silent = true } },
                    }
                },
                {
                    type = "button",
                    val = " find files",
                    opts = {
                        position = "center",
                        shortcut = "f",
                        align_shortcut = "left",
                        keymap = { "n", "f", "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true } },
                    }
                },
                {
                    type = "button",
                    val = " quit",
                    opts = {
                        position = "center",
                        shortcut = "q",
                        align_shortcut = "left",
                        keymap = { "n", "q", "<cmd>qa<CR>", { noremap = true, silent = true } },
                    }
                }
            }
        }

        dashboard.layout = {
            { type = "padding", val = 5 },
            fortune,
            { type = "padding", val = 2 },
            header,
            { type = "padding", val = 2 },
            buttons,
            { type = "padding", val = 30 },
        }
        require("alpha").setup(dashboard)
    end
}
