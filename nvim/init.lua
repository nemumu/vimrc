-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("plugins")
require("keymaps")
require("options")
require("colorscheme")
require("lsp")
require("completion")

local status, telescope = pcall(require, "telescope")
if (not status) then return end

local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    sorting_strategy = "ascending", -- 検索結果を上から下に並べる
    winblend = 4, --若干ウィンドウを透明に
    layout_strategy = 'vertical',
    layout_config = { height = 0.9 },
    file_ignore_patterns = { --検索対象に含めないファイルを指定
      "^.git/",
      "^node_modules/",
    },
  },
  extensions = {
    coc = {
      prefer_locations = false,   
    }
  },
})
