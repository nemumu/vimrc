return {
  {
    "folke/trouble.nvim",
    lazy = true,
    event = "VeryLazy",
    priority = 500,
    config = function()
      require("trouble").setup({
        cmd = "Trouble",
      })
    end,
  },
}
