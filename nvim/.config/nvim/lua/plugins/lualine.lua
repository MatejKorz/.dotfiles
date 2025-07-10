return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        icons_enabled = true,
        globalstatus = true,
        disabled_filetypes = {
          "dashboard",
          "help",
          "alpha"
        },
      },
      tabline = {
        lualine_x = {
          {
            "buffers",
            mode = 3,
          },
        },
      },
    },
    config = function(_, opts)
        require("lualine").setup(opts)
    end
}
