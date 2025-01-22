return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    event = "VeryLazy",
    priority = 500,
    config = function()
      require("toggleterm").setup({})
    end,
  },
}
