local global_on_attach = function(client, bufnr)
    local keymap = vim.keymap
    local opts = { buffer = bufnr }

    -- set keybinds
    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

    opts.desc = "Format code"
    keymap.set("n", "<leader>fc", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

return {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = {
        servers = {
            lua_ls = {
                settings = {
                    Lua = { diagnostics = { globals = { "vim" } } }
                },
            },
            clangd = {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=never"
                },
            }
        },
        on_attach = global_on_attach,
    },
    config = function(_, opts)
        local lspconfig = require("lspconfig")
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        for server, cfg in pairs(opts.servers) do
            cfg.capabilities = vim.tbl_deep_extend("force", cfg.capabilities or {}, capabilities)
            cfg.on_attach = opts.on_attach
            lspconfig[server].setup(cfg)
        end
        local mason_lsp = require("mason-lspconfig")
        local installed_servers = mason_lsp.get_installed_servers()
        for _, value in ipairs(installed_servers) do
            if not opts.servers[value] then
                lspconfig[value].setup({
                    capabilities = capabilities,
                    on_attach = opts.on_attach,
                })
            end
        end
    end
}
