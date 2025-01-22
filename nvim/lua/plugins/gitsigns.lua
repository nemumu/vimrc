return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "VeryLazy",
    priority = 800,
    config = function()
      require("gitsigns").setup()
    end,
  },
}
