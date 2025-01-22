return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    event = "VeryLazy",
    priority = 500,
    dependencies = { "nvim-tree/nvim-web-devicons"},
    config = function()
      require("nvim-tree").setup()
    end,
  },
}
