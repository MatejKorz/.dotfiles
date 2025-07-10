return {
    "mason-org/mason-lspconfig.nvim",
    version = "^2.0.0",
    opts = {
        ensure_installed = {"lua_ls", "clangd" },
        automatic_installation = true,
    },
    dependencies = {
        { "mason-org/mason.nvim", opts={} },
        "neovim/nvim-lspconfig",
    }
}
