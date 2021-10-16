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
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'

"==================================
" Load plugins
"==================================
" Load plugins
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/vimfiler')
    call dein#add('Shougo/unite-outline')
    call dein#add('Shougo/neocomplcache')
    call dein#add('itchyny/lightline.vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('scrooloose/syntastic')
    call dein#add('joshdick/onedark.vim')
    call dein#add('nemumu/vim-json')
    call dein#add('Shougo/neoyank.vim')
    call dein#add('mattn/emmet-vim')
    call dein#add('vim-scripts/grep.vim')
    call dein#end()
    call dein#save_state()
endif

" Install plugins if not installed
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

"==================================
" Plugin settings
"==================================
" Unite.vim
let gjunite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
" nnoremap fy :<C-u>Unite history/yank<CR>
nnoremap fb :<C-u>Unite buffer<CR>
nnoremap fr :<C-u>Unite -buffer-name=register register<CR>
nnoremap fm :<C-u>Unite file_mru buffer<CR>

"######## VimFiler ########
let g:vimfiler_as_default_explorer = 1
noremap <silent> :tree :VimFiler -split -simple -winwidth=45 -no-quit
noremap ff :VimFiler -split -simple -winwidth=30 -no-quit<ENTER>
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)

"######## Unite-outline ########
noremap sc :Unite -vertical -winwidth=60 outline<ENTER>

"######## neocomplcache ########
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1

" Use smartcase.
let g:neocomplcache_enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>cr_func()<CR>
function! s:cr_func()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

" <TAB>: select other words.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" <ENTER>; select words and close popup.
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

"######## lightline ########
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ ['mode', 'paste'], ['fugitive', 'filename']]
    \ },
    \ 'component_function': {
    \    'fugitive' : 'MyFugitive',
    \    'filename' : 'MyFileName',
    \}
\}

function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head())
            return '[' . fugitive#head() . ']'
        endif
    catch
    endtry
        return ''
endfunction

function! MyModified()
   return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '\(x_x)/' : ''
endfunction

function! MyFileName()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

"######## vim-indent-guides ########
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
let g:indent_guides_color_change_percent = 50
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

"######## Load onedark theme ########
colorscheme onedark
syntax on

"######## vim-json ########
let g:vim_json_syntax_conceal = 0

"######## grep.vim ########
nnoremap <expr> gr ':Rgrep<CR>'

" 検索で無視するディレクトリ
let Grep_Skip_Dirs = '.svn .git'

" バイナリファイルを検索対象から外す
let Grep_Default_Options = '-I'

" バックアップファイルを検索対象から外す
let Grep_Skip_Files = '*.bak *~'

"######## syntastic ########
let g:syntastic_python_checkers = ['flake8', 'mypy']
let g:syntastic_python_pylint_post_args="--max-line-length=100"

"==================================
"        インデント関連
"==================================
" タブは4つ分のスペース
set tabstop=4
set shiftwidth=4
set softtabstop=0

" Tabを半角スペースにする
set smarttab
set expandtab

" 改行時にインデントを継続
set autoindent

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

"#############検索関連#############
" 大文字小文字を区別なく検索
set ignorecase

" 検索文字列に大文字が含まれている場合は区別
set smartcase

" 最後まで検索すると最初に戻る
set wrapscan

" 入力途中にリアルタイム検索
set incsearch

"==================================
"        キー設定関連
"==================================
" s.に意味を持たせる
nnoremap s <Nop>

"#############タブ関連#############
" 次のタブに移動
nnoremap sn gt

" 前のタブに移動
nnoremap sp gT

" 新規タブ作成
nnoremap st : <C-u>tabnew<CR>

" 新規タブ作成
nnoremap ts : <C-u>tabnew<CR>

"##########ウィンドウ関連##########
" ウィンドウを横に分割
nnoremap ss : <C-u>sp<CR>

" ウィンドウを縦に分割
nnoremap sv : <C-u>vs<CR>

" 下ウィンドウに移動
nnoremap sJ : <C-w>J

" 上ウィンドウに移動
nnoremap sK : <C-w>K

" 右ウィンドウに移動
nnoremap sL : <C-w>L

" 左ウィンドウに移動
nnoremap sH : <C-w>H

" ウィンドウを閉じる
nnoremap sq :  <C-u>q<CR>

"####### ESCキーに割り当て ########
" Ctrl+hでESCキーに変更
imap <C-h> <esc>

" Ctrl+jでESCキーに変更
imap <C-j> <esc>

" Ctrl+kでESCキーに変更
imap <C-k> <esc>

" Ctrl+lでESCキーに変更
imap <C-l>  <esc>

" jjをESCキーに変換
imap jj <ESC>

"####### キー移動割り当て ########
" Ctrl+nで半画面分下へ移動
noremap <C-n> <C-d>

" Ctrl+dとCtrl+bを交換
" (Ctrl+dで反画面上へ移動)
" (Ctrl+bで反画面下へ移動)
noremap <C-d> <C-b>
noremap <C-b> <C-d>

"####### その他キー設定 ########
" ESCでハイライトをクリアにする
nnoremap <silent> <ESC><ESC> :noh<C-L><CR>

" セーブする
nnoremap sw : <C-u>w<CR>

" szでシェルを起動
nnoremap sz : sh<Enter>

" 全角で'あ' や 'い'を入力しても挿入モードにする
nmap あ a
nmap い i

" w!!で権限昇格して保存
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

"==================================
"          その他設定
"==================================
" 内部エンコーディング
set encoding=utf-8

" ファイル書き込み時のエンコーディング
set fileencoding=utf-8

" ファイル保存時にバックアップファイルを作成しない
set nobackup

" swapファイルを作らない
set noswapfile

" .nse(Nmap Scripting Engine)をluaとして認識させる
au BufNewFile,BufRead *.nse setf lua

" 行番号を表示
set number

" 対応する括弧を強調
set showmatch

" ステータスラインを常に表示
set laststatus=2

" タイトルバーにファイル名とパスを表示
set title

" タグファイル読み込み先
set tags=./tags

" ビープ音を鳴らさない
set visualbell

"==================================
"         折りたたみ関連
"==================================
set foldmethod=marker

" モードラインを有効化
set modeline

" 3行目までをモードラインとして検索
set modelines=3

" 検索結果をハイライトする
set hlsearch

"==================================
"             Script
"==================================
" 最後に閉じた位置のカーソル位置で表示
augroup backLine
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END

" 全角スペースをハイライトする
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightred gui=underline guifg=lightred
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
        autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
    augroup END
    call ZenkakuSpace()
endif
