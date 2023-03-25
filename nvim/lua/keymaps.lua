vim.api.nvim_set_keymap('n', 's', '<Nop>', { noremap = true })

-- jj to ESC
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {})

---- Tab
-- st/ts to new tab
vim.api.nvim_set_keymap('n', 'st', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ts', ':tabnew<CR>', { noremap = true })

-- sn to next tab
vim.api.nvim_set_keymap('n', 'sn', ':tabnext<CR>', { noremap = true })

-- sp to previous tab
vim.api.nvim_set_keymap('n', 'sp', ':tabprevious<CR>', { noremap = true })

---- Save and Exit
-- sq to exit
vim.api.nvim_set_keymap('n', 'sq', ':q<CR>', { noremap = true })

-- sw to save
vim.api.nvim_set_keymap('n', 'sw', ':w<CR>', { noremap = true })

-- sz to terminal
vim.api.nvim_set_keymap('n', 'sz', ':ToggleTerm size=90 direction=vertical<CR>', { noremap = true })

-- st to open filter
vim.api.nvim_set_keymap('n', 'ff', ':NvimTreeOpen<CR>', { noremap = true, silent = true })

-- sf to Telescope live_grep
vim.keymap.set('n', 'sf', "<cmd>lua require('telescope.builtin').live_grep()<CR>")

-- sx to Telescope find_files
vim.keymap.set('n', 'sx', "<cmd>lua require('telescope.builtin').find_files()<CR>")

-- sb to Telescope buffers
vim.keymap.set('n', 'sb', "<cmd>lua require('telescope.builtin').buffers()<CR>")

-- sg to format
vim.keymap.set('n', 'sg', '<cmd>lua vim.lsp.buf.format { async = true }<CR>')

