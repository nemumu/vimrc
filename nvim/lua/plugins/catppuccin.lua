return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    event = "VeryLazy",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
      require('catppuccin').setup {
        flavour = "mocha",
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
        }
      }
      require('catppuccin').load()
    end,
  },
}
