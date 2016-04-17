"设置用户路径
source $VIMRUNTIME/mswin.vim
behave mswin
let $VIMFILES = $VIM.'/vimfiles'
let $HOME = $VIMFILES

" MyDiff
"set diffexpr=MyDiff()
"function! MyDiff()
"let opt = '-a --binary '
"if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"let arg1 = v:fname_in
"if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"let arg2 = v:fname_new
"if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"let arg3 = v:fname_out
"if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"let eq = ''
"if $VIMRUNTIME =~ ' '
"if &sh =~ '\<cmd'
"let cmd = '""' . $VIMRUNTIME . '\diff"'
"let eq = '"'
"else
"let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"endif
"else
"let cmd = $VIMRUNTIME . '\diff'
"endif
"silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

" Win平台下窗口全屏组件 gvimfullscreen.dll
" Alt + Enter 全屏切换
" Shift + t 降低窗口透明度
" Shift + y 加大窗口透明度
" Shift + r 切换Vim是否总在最前面显示
" Vim启动的时候自动使用当前颜色的背景色以去除Vim的白色边框
let g:MyVimLib = 'gvimfullscreen.dll'
function! ToggleFullScreen()
    call libcall(g:MyVimLib, 'ToggleFullScreen', 1)
endfunction

let g:VimAlpha = 255
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

"配置文件自动载入
" autocmd! bufwritepost source $VIM/_vimrc %
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"========================================
" Vundle Plugins
"========================================
set nocompatible

"Vundle设置
set rtp+=$VIMFILES/bundle/Vundle.vim/
let path='$VIMFILES/bundle'
call vundle#begin(path)

Plugin 'gmarik/Vundle.vim'

" Theme
Plugin 'Lucius'

" Display
Plugin 'kshenoy/vim-signature'
Plugin 'lilydjwg/colorizer'
"Plugin 'kien/rainbow_parentheses.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'Valloric/MatchTagAlways'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'bling/vim-bufferline'
Plugin 'ntpeters/vim-better-whitespace'

" fast move
Plugin 'easymotion/vim-easymotion'
Plugin 'unblevable/quick-scope'

" fast edit
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-repeat'
Plugin 'gcmt/wildfire.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'tpope/vim-commentary'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'Chiel92/vim-autoformat'

" tools
"Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
"Plug 'ruanyl/vim-eslint', {'do': 'npm install'}
Plugin 'majutsushi/tagbar'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'szw/vim-maximizer'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'moll/vim-bbye'
Plugin 'vim-scripts/BufOnly.vim'
"Plug 'rking/ag.vim'
"Plugin 'ruanyl/vim-caniuse'
" git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
"Plugin 'junegunn/gv.vim'
"Plugin 'Xuyuanp/nerdtree-git-plugin'


"file path
Plugin 'Shougo/unite.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'ctrlpvim/ctrlp.vim'
"Plug 'tacahiroy/ctrlp-funky'
"Plug 'dyng/ctrlsf.vim', {'on': '<Plug>CtrlSFVwordExec'}
"Plugin 'ggVGc/vim-fuzzysearch'


"coding
Plugin 'mbbill/undotree'

"syntax
"Plugin 'pangloss/vim-javascript'
Plugin 'othree/yajs.vim'
Plugin 'elzr/vim-json'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'

"complete
Plugin 'mattn/emmet-vim'
Plugin 'ternjs/tern_for_vim'
Plugin 'Shougo/neocomplcache.vim'

" movement
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'terryma/vim-multiple-cursors'

"操作增强
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
" 设定doc文档目录
let helptags=$VIM."/vimfiles/doc"
set helplang=cn


"========================================
"   file set
"========================================
" history存储容量
set history=2000

"set fenc=utf-8
"set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8

set helplang=cn
"if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
"set ambiwidth=double
"endif

"新文件格式
set fileformat=unix
set fileformats=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B

"禁止UTF-8 BOM
set nobomb

"自动识别文件类型
filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

"上次文件编辑位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 取消备份。 视情况自己改
set nobackup
" 关闭交换文件
set noswapfile

" 文件修改之后自动载入
"set autoread

" 自动切换目录为当前编辑文件所在目录
"cd d:/vim/test/
"au BufRead,BufNewFile,BufEnter * cd %:p:h

"==================================================
"   UI
"==================================================
"界面设置
set shortmess=atI

set number
set relativenumber
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
autocmd InsertEnter * :set norelativenumber " no relativenumber in insert mode
autocmd InsertLeave * :set relativenumber   " show relativenumber when leave insert mode
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber number
    else
        set relativenumber
    endif
endfunc
nnoremap <C-s-n> :call NumberToggle()<cr>

set ruler " show the current line number and column number
set numberwidth=4
set wrap
set cursorline
"set cursorcolumn
set history=100 " keep 100 lines of command line history

set guifont=DejaVu_Sans_Mono_for_Powerline:h12
"set gfw=Microsoft\ Yahei\ Mono:h12:cGB2312

set showmatch         " show matched brackets
set mat=2             " How many tenths of a second to blink when matching brackets

set hlsearch          " highlight the searching words
set ignorecase        " ingnore case when do searching
set incsearch         " instant search
set smartcase         " ignore case if search pattern is all lowercase, case-sensitive otherwise

set scrolloff=7

" 命令行（在状态行下）的高度，默认为1，这里是2
"set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2
if has('statusline')
    set laststatus=2
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

"根据编辑模式更改输入法光标颜色，同时禁用IME自动切换
if has('multi_byte_ime')
    hi Cursor guifg=bg guibg=Skyblue gui=NONE
    hi CursorIM guifg=NONE guibg=Orange gui=NONE
    set iminsert=0 imsearch=0
endif

set showcmd        " show the current typing command
set noshowmode     " Show current mode
"set scrolloff=7    " Set 7 lines to the cursor - when moving vertically using j/k
"隐藏菜单栏
"set guioptions-=m " 隐藏菜单栏
set guioptions-=T " 隐藏工具栏
"set guioptions-=L " 隐藏左侧滚动条
"set guioptions-=r " 隐藏右侧滚动条
"set guioptions-=b " 隐藏底部滚动条
"set showtabline=0 " 隐藏Tab栏

"默认窗口位置和大小
"winpos 235 235
"set lines=25 columns=108

"代码高亮
"colorscheme Lucius
colorscheme monokai
"LuciusBlack
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


"==================================================
"   Other
"==================================================

" 自动补全配置
" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu " behaviour of insert mode completion

" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K

" command-line window
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

" 上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" 增强模式中的命令行自动完成操作
set wildmenu                 " auto complete command
set wildmode=longest:full,full
"set wildmode=list:longest
set wildignore=**.o,*~,.swp,*.bak,*.pyc,*.class,.git " Ignore compiled files

set viminfo^=% " Remember info about open buffers on close
set magic      " For regular expressions turn magic on

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" 00x增减数字时使用十进制
set nrformats=


"create undo file
"if has('persistent_undo')
"set undofile                " So is persistent undo ...
"set undolevels=1000         " Maximum number of changes that can be undone
"set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
"set undodir=~/.undodir/
"endif

" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99
" 代码折叠自定义快捷键 <leader>zz
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" any help file is opened in vertical split
" 帮助文档垂直分割显示
autocmd FileType help wincmd L

"==================================================
"   Key Mappings:customized keys
"==================================================
nnoremap ; :
" Leader key is comma
let mapleader = ","
let g:mapleader = ','

" Tweak ESC to be 'jk' typed fast
imap jk <ESC>
" Do not disable it, since kinesis has cool remap to the left thumb
" imap <ESC> <nop>uuu
"}}}

"编辑配置文件
nmap <Leader>r :edit $MYVIMRC<CR>

" F1 - F6 设置

" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>"

" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber()
    if(&relativenumber == &number)
        set relativenumber! number!
    elseif(&number)
        set number!
    else
        set relativenumber!
    endif
    set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>
" F3 显示可打印字符开关
nnoremap <F3> :set list! list?<CR>
" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" F5 set paste问题已解决, 粘贴代码前不需要按F5了
" F5 粘贴模式paste_mode开关,用于有格式的代码粘贴
" Automatically set paste mode in Vim when pasting in insert mode
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

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
" y$ -> Y Make Y behave like other capitals
map Y y$
" 复制选中区到系统剪切板中
"vnoremap <leader>y "+y
" select all
noremap <Leader>sa ggVG"
" select block
"nnoremap <leader>v V`}

" 交换 ' `, 使得可以快速使用'跳到marked位置
nnoremap ' `
nnoremap ` '

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

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" Go to home and end using capitalized directions
noremap H ^
noremap L $
"noremap Y y$

"no Highlight
"noremap <silent><leader>/ :nohls<CR>

" I can type :help on my own, thanks.
noremap <F1> <Esc>"

" 搜索相关
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
" 进入搜索Use sane regexes"
nnoremap / /\v
vnoremap / /\v

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


" 切换前后buffer
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
" 使用方向键切换buffer
noremap <left> :bp<CR>
noremap <right> :bn<CR>


" tab切换
map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>

map <leader>tj :tabnext<cr>
map <leader>tk :tabprev<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>

map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
" nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr>
" nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
" vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
" <F12>
"==========================================
" coding mapping
"==========================================
" css del default color value with emmet
autocmd FileType css inoremap dc <C-o>3x

" javascript auto semicolon mapping
autocmd FileType javascript inoremap ;<cr> <end>;<cr>
autocmd FileType javascript inoremap ;; <down><end>;<cr>
"==========================================
" FileType Settings  文件类型设置
"==========================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby,javascript,html,css,xml set tabstop=4 shiftwidth=4 softtabstop=4 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
autocmd BufRead,BufNewFile *.part set filetype=html
" disable showmatch when use > in php
au BufWinEnter *.php set mps-=<:>

" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

" 设置可以高亮的关键字
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
    endif
endif



"au BufWrite * :Autoformat

"==================================================
"   styles hignlight
"==================================================
" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

"==========================================
" TEMP 设置, 尚未确定要不要
"==========================================
cnoremap pi PluginInstall
cnoremap pls PluginList
nnoremap <c-]> I"<esc>
nnoremap <c-f2> :NERDTreeToggle<CR>




"==================================================
"   Plugins Config
"==================================================
"
"==================================================
"   airline config
"==================================================
let g:airline_detect_spell=0
let g:airline_powerline_fonts=1
let g:airline_theme='light'

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 1

" full path
let g:airline_section_c = airline#section#create(['%F'])

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

" let g:airline#extensions#bufferline#enabled = 0
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
autocmd FileType css,html imap <tab> <plug>(emmet-expand-abbr)

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
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

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

"==================================================
"   syntastic config
"==================================================
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_error_symbol='✘'
" let g:syntastic_warning_symbol='!'
let g:syntastic_warning_symbol = "\u26A0"
let g:syntastic_style_error_symbol='»'
let g:syntastic_style_warning_symbol='•'
" let g:syntastic_enable_highlighting = 0
" let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline#extensions#syntastic#enabled = 1
"==================================================

"inoremap ;<cr> <end>;<cr>
"inoremap .<cr> <end>.
"inoremap ;;<cr> <down><end>;<cr>
"inoremap ..<cr> <down><end>.

"==================================================
"   Unite config
"==================================================
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
