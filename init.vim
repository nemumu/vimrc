scriptencoding utf-8

"==================================
" Install dein.vim
"==================================
" Install dein.vim if not installed
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let g:denops#deno = $HOME . "/.deno/bin/deno"

"==================================
" Load plugins
"==================================

" Load plugins
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " denops
    call dein#add('vim-denops/denops.vim')

    " Filer
    call dein#add('Shougo/defx.nvim')

    " Color scheme
    call dein#add('joshdick/onedark.vim')

    " lightline
    call dein#add('itchyny/lightline.vim')

    " deol.vim (Terminal)
    call dein#add('Shougo/deol.nvim')

    " fzf (fuzzy finder)
    call dein#add('junegunn/fzf', { 'build': './install' })
    call dein#add('junegunn/fzf.vim', { 'depends': 'junegunn/fzf' })

    " vim-fugitive (Git)
    call dein#add('tpope/vim-fugitive')

    " indent-guide
    call dein#add('nathanaelkane/vim-indent-guides')

    " auto completion
    call dein#add('Shougo/ddc.vim')
    call dein#add('Shougo/ddc-around')
    call dein#add('Shougo/ddc-matcher_head')
    call dein#add('Shougo/ddc-sorter_rank')
    call dein#add('Shougo/ddc-converter_remove_overlap')
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('Shougo/ddc-nvim-lsp')
    call dein#add('hrsh7th/nvim-cmp')
    call dein#add('hrsh7th/cmp-nvim-lsp')
    call dein#add('hrsh7th/cmp-path')
    call dein#add('hrsh7th/cmp-buffer')

    call dein#end()
    call dein#save_state()
endif

" Install plugins if not installed
if dein#check_install()
    call dein#install()
endif

"==================================
" Plugins
"==================================
" Defx
call defx#custom#option('_', {
    \ 'winwidth': 25,
    \ 'split': 'vertical',
    \ 'direction': 'topleft',
    \ 'show_ignored_files': 1,
    \ 'buffer_name': 'defxplorer',
    \ 'toggle': 1,
    \ 'resume': 1,
    \ })

autocmd FileType defx call s:defx_settings()
function! s:defx_settings() abort
    " Open
    nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')

    " Open new tab
    nnoremap <silent><buffer><expr> t defx#do_action('open','tabnew')

    " Open or Close dir
    nnoremap <silent><buffer><expr> <Space> defx#do_action('open_or_close_tree')

    " Back directory
    nnoremap <silent><buffer><expr> .. defx#do_action('cd', ['..'])

    " Quit
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
endfunction
noremap ff : <C-u> Defx <CR>

" lightline
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'onedark'
\}

" indent-guide
let g:indent_guides_enable_on_vim_startup = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1

" ddc
call ddc#custom#patch_global('sources', ['around', 'nvim-lsp'])

call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank'],
    \   'converters': ['converter_remove_overlap'],
    \ },
    \ 'around': {'mark': 'A'},
    \ 'nvim-lsp': {
    \   'mark': 'lsp',
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
    \ },
    \ })
call ddc#custom#patch_global('sourceParams', {
    \ 'around': {'maxSize': 500},
    \ 'nvim-lsp': { 'kindLabels': { 'Class': 'c' } },
    \ })

call ddc#enable()

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        autostart = true
    }
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
}
EOF

"==================================
" UI config
"==================================
" Set color scheme
colorscheme onedark

" Display line number
set number

" Always display status
set laststatus=2

" Display window title
set title

"==================================
" Indent
"==================================
set tabstop=4
set shiftwidth=4
set softtabstop=0

" Tab to space
set smarttab
set expandtab

" autoindent
set autoindent

"==================================
" Search
"==================================
" Include both uppercase and lowercase
set ignorecase

" Distinguish in case of uppercase input
set smartcase

" Searches wrap around the end
set wrapscan

" Realtime search
set incsearch

"==================================
" Charset
"==================================
" Internal encoding
set encoding=utf-8

" encoding for current buffer
set fileencoding=utf-8

"==================================
" Other
"==================================
" No create swap file
set noswapfile

" No create backup file
set nobackup

" No bell
set visualbell

" Display search highlight
set hlsearch

" Detect filetype
filetype plugin indent on

" Open in closed line
if has("autocmd")
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
endif

"==================================
" Key bind
"==================================
nnoremap s <Nop>

" == Tab ==
" Open next tab
nnoremap sn gt

" Open back tab
nnoremap sp gT

" Create new tab
nnoremap st : <C-u>tabnew<CR>
nnoremap ts : <C-u>tabnew<CR>

" == Window ==
" Split horizontal
nnoremap ss : <C-u>sp<CR>

" Split vertical
nnoremap sv : <C-u>vs<CR>

" Move down window
nnoremap sJ : <C-w>J

" Move up window
nnoremap sK : <C-w>K

" Move right window
nnoremap sL : <C-w>L

" Move left window
nnoremap sH : <C-w>H

" Close window
nnoremap sq :  <C-u>q<CR>

" == Change mode ==
" Ctrl+h to ESC
imap <C-h> <esc>

" Ctrl+j to ESC
imap <C-j> <esc>

" Ctrl+k to ESC
imap <C-k> <esc>

" Ctrl+l to ESC
imap <C-l>  <esc>

" jj to ESC
imap jj <ESC>

" == Move key shortcut ==
" Ctrl+n to half window down
noremap <C-n> <C-d>

" Change Ctrl+d to Ctrl+b
" Ctrl+d to half window down
noremap <C-d> <C-b>

" Change Ctrl+b to Ctrl+d
" Ctrl+d to half window up
noremap <C-b> <C-d>

" == Other keybind ==
" ESC to clear highlight
nnoremap <silent> <ESC><ESC> :noh<C-L><CR>

" sw to save
nnoremap sw : <C-u>w<CR>

" w!! to save with root privileges
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

" sz to open shell
nnoremap sz : <C-u>Deol -split=vertical<CR>

" sx to ptest
nnoremap jx : <C-u>Deol ptest -split=vertical<CR>

" sf to ag (the_silver_searcher) search
nnoremap sf : <C-u>Ag<CR>

" sr to rg(ripgrep) search
nnoremap sr : <C-u>Rg<CR>

" fs to Files(fzf) search
nnoremap fs : <C-u>Files<CR>
