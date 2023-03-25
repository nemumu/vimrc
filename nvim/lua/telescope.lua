local status, telescope = pcall(require, "telescope")
if (not status) then return end

local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    winblend = 4,
    layout_strategy = 'vertical',
    layout_config = { height = 0.9 },
    file_ignore_patterns = {
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
