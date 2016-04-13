"========================================
"   SYSTEM
"========================================
"判定当前操作系统类型
if has("win32") || has("win32unix")
    let g:OS#name = "win"
    let g:OS#win = 1
    let g:OS#mac = 0
    let g:OS#unix = 0
elseif has("mac")
    let g:OS#name = "mac"
    let g:OS#mac = 1
    let g:OS#win = 0
    let g:OS#unix = 0
elseif has("unix")
    let g:OS#name = "unix"
    let g:OS#unix = 1
    let g:OS#win = 0
    let g:OS#mac = 0
endif
if has("gui_running")
    let g:OS#gui = 1
else
    let g:OS#gui = 0
endif

"设置用户路径
if g:OS#win
    source $VIMRUNTIME/mswin.vim
    behave mswin
    let $VIUMFILES = $VIM.'/vimfiles'
    let $HOME = $VIUMFILES
elseif g:OS#unix
    let $VIM = $HOME
    let $VIMFILES = $HOME.'~/.vim'
elseif g:OS#mac
    let $VIM = $HOME
    let $VIMFILES = $HOME.'~/.vim'
endif

if g:OS#win
    " MyDiff
    set diffexpr=MyDiff()
    function! MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" Win平台下窗口全屏组件 gvimfullscreen.dll
" Alt + Enter 全屏切换
" Shift + t 降低窗口透明度
" Shift + y 加大窗口透明度
" Shift + r 切换Vim是否总在最前面显示
" Vim启动的时候自动使用当前颜色的背景色以去除Vim的白色边框
if has('gui_running') && has('gui_win32') && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'
    function! ToggleFullScreen()
        call libcall(g:MyVimLib, 'ToggleFullScreen', 1)
    endfunction

    let g:VimAlpha = 235
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction
    "映射 Alt+Enter 切换全屏vim
    map <a-enter> <esc>:call ToggleFullScreen()<cr>
    "切换Vim是否在最前面显示
    nmap <a-c-right> <esc>:call SwitchVimTopMostMode()<cr>
    "增加Vim窗体的不透明度
    nmap <a-c-up> <esc>:call SetAlpha(10)<cr>
    "增加Vim窗体的透明度
    nmap <a-c-down> <esc>:call SetAlpha(-10)<cr>
    " 默认设置透明
    autocmd GUIEnter * call libcallnr(g:MyVimLib, 'SetAlpha', g:VimAlpha)
endif

"配置文件自动载入
if g:OS#win
    " autocmd! bufwritepost source $VIM/_vimrc %
    augroup reload_vimrc " {
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    augroup END " }
elseif g:OS#uinx
    autocmd! bufwritepost source $HOME/.vimrc %
elseif g:OS#mac
    autocmd! bufwritepost source $HOME/.vimrc %
endif
"========================================
"Vundel Plugins
"========================================
set nocompatible

"Vundle设置
set rtp+=$VIUMFILES/bundle/Vundle.vim/
let path='$VIUMFILES/bundle'
call vundle#begin(path)

Plugin 'gmarik/Vundle.vim'

" ui
Plugin 'Lucius'
Plugin 'kshenoy/vim-signature'
Plugin 'lilydjwg/colorizer'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'Valloric/MatchTagAlways'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'ntpeters/vim-better-whitespace'

" git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
"Plugin 'Xuyuanp/nerdtree-git-plugin'


"file path
Plugin 'Shougo/unite.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'ctrlpvim/ctrlp.vim'


"coding
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-commentary'
Plugin 'Chiel92/vim-autoformat'
"syntax
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
"complete
Plugin 'mattn/emmet-vim'
Plugin 'ternjs/tern_for_vim'
Plugin 'Shougo/neocomplcache.vim'
"Plugin 'Valloric/YouCompleteMe'

" movement
Plugin 'unblevable/quick-scope'
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'terryma/vim-multiple-cursors'

"操作增强
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'gcmt/wildfire.vim'
Plugin 'godlygeek/tabular'
" nerdtree-git-plugin config
" "==================================================
"
call vundle#end()
filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



"========================================
"   set config
"========================================

"==================================================
"   FILE
"==================================================
"中文乱码
"set fenc=utf-8
"set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

if g:OS#win
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
endif
"if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
"set ambiwidth=double
"endif

"新文件格式
set fileformat=unix
set fileformats=unix,dos,mac

"禁止UTF-8 BOM
set nobomb

"自动识别文件类型
filetype on

"上次文件编辑位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 自动切换目录为当前编辑文件所在目录
"cd d:/vim/test/
au BufRead,BufNewFile,BufEnter * cd %:p:h

"自动切换为当前文件所在目录
" set bsdir=buffer
" set autochdir

"session setting

" "sessionoptions设置MS UNIX通用
" set sessionoptions+=unix,slash

" "启动自动加载上次未关闭的文件（会话SESSION）
" " Go to last file(s) if invoked without arguments.
" autocmd VimLeave * nested if (!isdirectory($VIM . "/vimsession")) |
"     \ call mkdir($VIM. "/vimsession") |
"     \ endif |
"     \ execute "mksession! " . $VIM . "/vimsession/Session.vim"

" autocmd VimEnter * nested if argc() == 0 && filereadable($VIM . "/vimsession/Session.vim") |
"     \ execute "source " . $VIM . "/vimsession/Session.vim"

"==================================================
"   UI
"==================================================
"界面设置
set number
set relativenumber
autocmd InsertEnter * :set norelativenumber " no relativenumber in insert mode
autocmd InsertLeave * :set relativenumber   " show relativenumber when leave insert mode
set ruler " show the current line number and column number
set numberwidth=5
set wrap
set cursorline
set history=100 " keep 100 lines of command line history

if has("win32")
    set guifont=DejaVu_Sans_Mono_for_Powerline:h12
endif
"set gfw=Microsoft\ Yahei\ Mono:h12:cGB2312

set shortmess=atI

set showmatch         " show matched brackets
set mat=2             " How many tenths of a second to blink when matching brackets

set hlsearch          " highlight the searching words
set ignorecase        " ingnore case when do searching
set incsearch         " instant search
set smartcase         " ignore case if search pattern is all lowercase, case-sensitive otherwise

set showcmd        " show the current typing command
set noshowmode     " Show current mode
"set scrolloff=7    " Set 7 lines to the cursor - when moving vertically using j/k
"隐藏菜单栏
if g:OS#gui
    "set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    "set guioptions-=L " 隐藏左侧滚动条
    "set guioptions-=r " 隐藏右侧滚动条
    "set guioptions-=b " 隐藏底部滚动条
    "set showtabline=0 " 隐藏Tab栏
endif

"默认窗口位置和大小
"winpos 235 235
"set lines=25 columns=108

"代码高亮
colorscheme Lucius
" colorscheme monokai
LuciusBlack
syntax enable
syntax on

"设置制表符缩进
set smartindent       " Do smart autoindenting when starting a new line
set autoindent        " always set autoindenting on
set tabstop=4         " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4      " number of spaces to use for autoindenting
set softtabstop=4     " Number of spaces that a <Tab> counts for while performing editing operations
set smarttab
set expandtab         " when typing <Tab>, use <space> instead
set shiftround        " use multiple of shiftwidth when indenting with '<' and '>'

set laststatus=2

"根据编辑模式更改输入法光标颜色，同时禁用IME自动切换
if has('multi_byte_ime')
    hi Cursor guifg=bg guibg=Skyblue gui=NONE
    hi CursorIM guifg=NONE guibg=Orange gui=NONE
    set iminsert=0 imsearch=0
endif
"==================================================
"   Other
"==================================================

set nobackup

set completeopt=longest,menu " behaviour of insert mode completion
set wildmenu                 " auto complete command
set wildmode=longest:full,full
set wildignore=**.o,*~,.swp,*.bak,*.pyc,*.class,.git " Ignore compiled files

set viminfo^=% " Remember info about open buffers on close
set magic      " For regular expressions turn magic on

"create undo file
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    set undodir=~/.undodir/
endif

set scrolloff=7
"==================================================
"   key mappings:customized keys
"==================================================
nnoremap W :w<CR>
" Leader key is comma
let mapleader = ","

" Tweak ESC to be 'jk' typed fast
imap jk <ESC>
" Do not disable it, since kinesis has cool remap to the left thumb
" imap <ESC> <nop>
"}}}

"编辑配置文件
nmap <Leader>r :tabedit $MYVIMRC<CR>

"与windows共享剪贴板
set clipboard+=unnamed
" use ctrl-c to copy to system clipboard
vnoremap <C-c> "*y
" use <c-v> to paste yanked content
" inoremap <C-v> <C-R>"
"粘帖来自系统的复制内容
inoremap <c-v> <esc>"+pa
"paste next line
nnoremap <Leader>p o<esc>p
" select all
noremap <Leader>sa ggVG"

" better command line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Go to home and end using capitalized directions
noremap H 0
noremap L $
"noremap Y y$

"no Highlight
"noremap <silent><leader>/ :nohls<CR>

" I can type :help on my own, thanks.
noremap <F1> <Esc>"

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

"Use 'm/M' to move among buffers
"noremap m :bn<CR>
"noremap M :bp<CR>
" toggle between two buffers
" nnoremap t <C-^>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

"" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

" Move visual block
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv
" nnoremap <Leader>w :w<cr>

nnoremap <leader>f :<C-u>Unite file<CR>
" Quickly cd to directory
nnoremap <leader>d :Unite -start-insert directory -profile-name=files<CR>
" Paste from the yank history
"nnoremap <leader>p :Unite -start-insert history/yank<CR>
" Trigger the git menu
" nnoremap <leader>g :Unite -silent -start-insert menu:git<CR>
" Open all menus with useful stuff
" nnoremap <leader>j :Unite -silent -start-insert menu:all menu:git<CR>
" Select across all buffers
nnoremap <leader>b :Unite -start-insert buffer<CR>

"temp
cnoremap pi PluginInstall
cnoremap pls PluginList
nnoremap <c-]> I"<esc>
nnoremap <c-f2> :NERDTreeToggle<CR>
"==================================================
"   styles hignlight
"==================================================
" hi! link SignColumn   LineNr
" hi! link ShowMarksHLl DiffAdd
" hi! link ShowMarksHLu DiffChange

" " for error highlight
" highlight clear SpellBad
" highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
" highlight clear SpellCap
" highlight SpellCap term=underline cterm=underline
" highlight clear SpellRare
" highlight SpellRare term=underline cterm=underline
" highlight clear SpellLocal
" highlight SpellLocal term=underline cterm=underline


"==================================================
"   Plugins Config
"==================================================
"
"
"
"==================================================
"   airline config
"==================================================
let g:airline_detect_spell=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '»'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
"let g:airline_theme='dark'
let g:airline_theme='light'
"let g:airline_theme='molokai'

let g:airline#extensions#bufferline#enabled = 0
"==================================================
"   nerdtree-git-plugin config
"==================================================
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ "Unknown"   : "?"
"     \ }

"==================================================
"    emmet config
"==================================================
let g:user_emmet_leader_key='<C-e>' " c-e , 连打，注意逗号别忘记
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

"==================================================
"    neocompletecache config
"==================================================
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


"==================================================
"    AutoPairs config
"==================================================
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<C-S-B>'

"==================================================
"    easymotion config
"==================================================
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader><Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

"==================================================
"   incsearch config
"==================================================
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
"" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

"==================================================
"   incsearch-fuzzy config
"==================================================
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

"==================================================
"   wildfire config
"==================================================
map <SPACE> <Plug>(wildfire-fuel)
let g:wildfire_objects = {
            \ "*" : ["i'", 'i"', "i)", "i]", "i}"]
            \ }

cal wildfire#triggers#Add("<ENTER>", {
            \ "html,xml" : ["at", "it"],
            \ })
nmap <leader>s <Plug>(wildfire-quick-select)

"==================================================
"   wildfire config
"==================================================
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
"let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"==================================================
"   multiple-cursors config
"==================================================
set selection=inclusive
" let g:multi_cursor_use_default_mapping=1
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" Map start key separately from next key
"let g:multi_cursor_start_key='<F6>'
"
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
    endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
    endif
endfunction

"==================================================
"   quick-scope config
"==================================================
"" Trigger a highlight in the appropriate direction when pressing these keys:
"let g:qs_highlight_on_keys = ['f', 'F']
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"let g:qs_first_occurrence_highlight_color = '#afff5f' " gui vim
let g:qs_first_occurrence_highlight_color = '#D15B03' " gui vim
"let g:qs_first_occurrence_highlight_color = 155       " terminal vim
"let g:qs_second_occurrence_highlight_color = '#5fffff'  " gui vim
let g:qs_second_occurrence_highlight_color = '#D40CDB'  " gui vim
"let g:qs_second_occurrence_highlight_color = 81         " terminal vim
" Map the leader key + q to toggle quick-scope's highlighting in normal/visual mode.
" Note that you must use nmap/vmap instead of their non-recursive versions (nnoremap/vnoremap).
"nmap <leader>q <plug>(QuickScopeToggle)
"vmap <leader>q <plug>(QuickScopeToggle)
