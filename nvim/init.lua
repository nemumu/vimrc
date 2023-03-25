-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("plugins")
require("keymaps")
require("options")
require("colorscheme")
require("lsp")
require("completion")
require("telescope")
