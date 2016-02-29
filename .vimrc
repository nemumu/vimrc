scriptencoding utf-8

"==================================
"         NeoBundle関連
"==================================
if has('vim_starting')
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install neobundle..."
        " vim からコマンド呼び出しているだけ neobundle.vim のクローン
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
    " 初回起動時のみruntimepathにneobundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundleを初期化
call neobundle#begin(expand('~/.vim/bundle/'))
"NeoBundleをNeoBundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tomasr/molokai'

call neobundle#end()

"==================================
"         プラグイン関連
"==================================
" プラグインが無い場合はダウンロードしてくる
NeoBundleCheck

" Unite.vimの設定
let gjunite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
"nnoremap fy :<C-u>Unite history/yank<CR>
nnoremap fb :<C-u>Unite buffer<CR>
nnoremap fr :<C-u>Unite -buffer-name=register register<CR>
nnoremap fm :<C-u>Unite file_mru buffer<CR>

"######## VimFiler ########
" VimFIlerを標準ファイラにする
let g:vimfiler_as_default_explorer = 1
noremap <silent> :tree :VimFiler -split -simple -winwidth=45 -no-quit
noremap ff :VimFiler -split -simple -winwidth=45 -no-quit<ENTER>
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)

"######## Unite-outline ########
noremap sc :Unite -vertical -winwidth=60 outline<ENTER>

"##### neocomplcache #####
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

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


"######## vim-indent-guides ########
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
let g:indent_guides_color_change_percent = 50
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

"######## molokai ########
colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

"==================================
"        インデント関連
"==================================
" タブは4つ分のスペース
set tabstop=4
set shiftwidth=4
set softtabstop=0

"Tabを半角スペースにする
set smarttab
set expandtab

" 改行時にインデントを継続
set autoindent

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

"#############検索関連#############
"大文字小文字を区別なく検索
set ignorecase

"検索文字列に大文字が含まれている場合は区別
set smartcase

"最後まで検索すると最初に戻る
set wrapscan

"入力途中にリアルタイム検索
set incsearch

"##############その他############
"行番号を表示
set number

"対応する括弧を強調
set showmatch

"ステータスラインを常に表示
set laststatus=2


"###########キー設定関連###########
"s.に意味を持たせる
nnoremap s <Nop>

"#############タブ関連#############
"次のタブに移動
nnoremap sn gt

"前のタブに移動
nnoremap sp gT

"新規タブ作成
nnoremap st : <C-u>tabnew<CR>

"新規タブ作成
nnoremap ts : <C-u>tabnew<CR>

"##########ウィンドウ関連##########
"ウィンドウを横に分割
nnoremap ss : <C-u>sp<CR>

"ウィンドウを縦に分割
nnoremap sv : <C-u>vs<CR>

"下ウィンドウに移動
nnoremap sJ : <C-w>J

"上ウィンドウに移動
nnoremap sK : <C-w>K

"右ウィンドウに移動
nnoremap sL : <C-w>L

"左ウィンドウに移動
nnoremap sH : <C-w>H

"ウィンドウを閉じる
nnoremap sq :  <C-u>q<CR>

"####### ESCキーの割り当て ########
"Ctrl+hでESCキーに変更
imap <C-h> <esc>

"Ctrl+jでESCキーに変更
imap <C-j> <esc>

"Ctrl+kでESCキーに変更
imap <C-k> <esc>

"Ctrl+lでESCキーに変更
imap <C-l>  <esc>

"jjをESCキーに変換
imap jj <ESC>

"###### Ctrl+dとCtrl+bを交換 ######
"Ctrl+DをCtrl+Bに割り当て
noremap <C-d> <C-b>

"Ctrl+BをCtrl+Dに割り当て
noremap <C-b> <C-d>

"==================================
"            その他
"==================================
"セーブする
nnoremap sw : <C-u>w<CR>

" ESCでハイライトをクリアにする
nnoremap <silent> <ESC><ESC> :noh<C-L><CR>

" エンコーディングをUTF8に設定
set encoding=utf-8

"szでシェルを起動
nnoremap sz : sh<Enter>

"全角で'あ' や 'い'を入力しても挿入モードにする
nmap あ a
nmap い i

"w!!で権限昇格して保存
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

"swapファイルを作らない
set noswapfile

"==================================
"             Script
"==================================
"最後に閉じた位置のカーソル位置で表示
augroup backLine
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END

"全角スペースをハイライトする
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
