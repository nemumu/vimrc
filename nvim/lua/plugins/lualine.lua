return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "VeryLazy",
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim"},
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin"
        },
      })
    end,
  },
}
