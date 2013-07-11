" Modeline and Notes {
" vim: foldmarker={,} foldlevel=2 foldmethod=marker nospell
" Latest update: Fri Jul  5 22:00:13 2013
"
" A lot of what follows is specific to my setup:
" I use ViM on Win32, MacOS X and various UNIX/Linux boxes
" Both console and gui version
" }

" Environment {

" Basic bundle setup using Vundle {
set nocompatible " must be first line
filetype off                   " required!

"Set up Vundle first
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" My Bundles here:
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-scriptease'
Bundle 'tpope/vim-git'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'altercation/vim-colors-solarized'
Bundle 'xolox/vim-colorscheme-switcher'
Bundle 'xolox/vim-misc.git'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'vimez/vim-showmarks'
Bundle 'thisivan/vim-taglist'
Bundle 'flazz/vim-colorschemes'
Bundle 'Lokaltog/powerline'
Bundle 'joeybeninghove/bufexplorer'
Bundle 'fs111/pydoc.vim'
Bundle 'kevinw/pyflakes-vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-ragtag'
Bundle 'xolox/vim-session'
Bundle 'cburroughs/pep8.py'
Bundle 'nvie/vim-flake8'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Gundo'
Bundle 'ScrollColors'
Bundle 'vim-autopep8'
Bundle 'bufexplorer.zip'
Bundle 'YankRing.vim'
Bundle 'vimpager'
Bundle 'TaskList.vim'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
" Bundle 'file:///Users/gmarik/path/to/plugin'
" ...
filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" }

" Windows specifics {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    set guifont=Terminus_for_Powerline:h14:cRUSSIAN
endif
" }

" Mac OS X specifics {
" On Mac, set up the GUI font
if has('mac') || has('macunix')
    set guifont=Inconsolata:h14
endif
" }

" }

" General {

if !has('win32') && !has('win64')
    set term=$TERM " Make arrow and other keys work
endif

" If you use command-t plugin, it conflicts with this, comment it out.
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
scriptencoding utf-8

set t_Co=256 " try forcing ViM to use 256 colors
set mouse=a " automatically enable mouse usage
set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore " allow for cursor beyond last character
set nospell " spell checking off
set hidden
set linebreak

" Setting up the directories for services like undo, backups etc {
set backup " backups are nice ...
if version > 703 
    set undofile " so is persistent undo ...
    set undolevels=1000 "maximum number of changes that can be undone
    set undoreload=10000 "maximum number lines to save for undo on a buffer reload
    set undodir=$HOME/.vim/.cache/undo/
endif
set wildignore=*.swp,*.bak,*.pyc,*.tmp
set directory=$HOME/.vim/.cache/swap/
"
"au BufWinLeave * silent! mkview "make vim save view (state) (folds, cursor, etc)
"au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
" }

" Misc {
let b:match_ignorecase = 1
" }
" }

" Vim UI {
set showmode " display the current mode
set background=dark " Assume a dark background
set cursorline " highlight current line
hi cursorline guibg=#333333 " highlight bg color of current line
hi CursorColumn guibg=#333333 " highlight cursor

if has('cmdline_info')
    set ruler " show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd " show partial commands in status line and
    " selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\ " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=\ [%{&ff}/%Y] " filetype
    set statusline+=\ [%{getcwd()}] " current dir
    set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
    set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

set linespace=0 " No extra spaces between rows
set nu " Line numbers on
if version > 703
    set relativenumber " Show oinly relative line numbers
endif
set hlsearch " highlight search terms
set winminheight=0 " windows can be 0 line high
set ignorecase " case insensitive search
set smartcase " case sensitive when uc present
set wildmenu " show list instead of just completing
set wildmode=list:longest,full " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,] " backspace and cursor keys wrap to
set scrolljump=5 " lines to scroll when cursor leaves screen
set scrolloff=3 " minimum lines to keep above and below cursor
set foldenable " auto fold code
set gdefault " the /g flag on :s substitutions by default
set list

" GUI Settings {
" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=T " remove the toolbar
    set lines=50 " 50 lines of text instead of 24,
    set columns=120 " set for making a GUI window useful
"    au FocusLost * :wa " write all files when losing focus
    colorscheme solarized
else
"    set term=builtin_ansi " Make arrow and other keys work
"    colorscheme desert256
    colorscheme wombat256
endif
" }

" }

" Formatting {
set wrap " wrap long lines
set textwidth=79 " wrap at this position
set formatoptions=qrn1
set copyindent " Copy previous indentation on autoindent
set shiftwidth=4 " use indents of 4 spaces
set expandtab " tabs are spaces, not tabs
set tabstop=8 " a Tab char is equal to 8 spaces
set softtabstop=4 " let backspace delete indent
set matchpairs+=<:> " match, to be used with %
set pastetoggle=<F12> " pastetoggle (sane indentation on pastes)
set comments=sl:/*,mb:*,elx:*/ " auto format comment blocks
set clipboard=unnamed
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
set foldmethod=indent
set foldlevel=99
" }

" Key (re)Mappings {

"The default leader is '\', but I  prefer ',' as it's in a standard location
let mapleader = ','

" Making ; work like : for commands.
" Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :

" nnoremap <Tab> %
" vnoremap <Tab> %

" Space in normal mode moves one page down, Shift-Space moves one page up
nmap <Space> <C-F>
nmap <S-Space> <C-B>

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Map two combinations to make ViM customization easier
nmap <silent> <leader>ev :e $MYVIMRC<CR>   " Edit .vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>  " Reload .vimrc

" Turn off F1 for help
nnoremap <F1> <nop>
inoremap <F1> <nop>

" Turn line number on and off with F2
nnoremap <F2> :set nonumber!<CR>
inoremap <F2> :set nonumber!<CR>

" Turn off cursor keys in normal mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

inoremap jj <ESC>

" Some tabbing mappings
map <silent> <C-Tab> :tabnext<CR>

" Stupid shift key fixes for common commands
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

""" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Insert current date using F3 in Insert mode
inoremap <F3> <C-R>=strftime("%c")<CR>
" }

" Plugins {
" Supertab {
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" }
" ShowMarks {
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Don't leave on by default, use :ShowMarksOn to enable
let g:showmarks_enable = 0
" For marks a-z
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
" For marks A-Z
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
" For all other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
" For multiple marks on the same line.
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
" }
" OmniComplete {
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

" Popup menu hightLight Group
"highlight Pmenu ctermbg=13 guibg=DarkBlue
"highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=LightBlue
"highlight PmenuSbar ctermbg=7 guibg=DarkGray
"highlight PmenuThumb guibg=Black

hi Pmenu guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" some convenient mappings
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" and make sure that it doesn't break supertab
let g:SuperTabCrMapping = 0
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,longest,preview
" }
" Ctags {
" This will look in the current directory for 'tags', and work up the tree towards root until one is found.
set tags=./tags;/,$HOME/vimtags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR> " A-] - Open the definition in a vertical split
" }
" SnipMate {
" Setting the author var
" If forking, please overwrite in your .vimrc.local file
let g:snips_author = 'Konstantin Zverev <konstantin.zverev@gmail.com>'
" Shortcut for reloading snippets, useful when developing
nnoremap <leader>smr <esc>:exec ReloadAllSnippets()<cr>
" }
" NerdTree {
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
" }
" Powerline {
let g:Powerline_symbols='fancy'
" }
" Scratch buffer {
nmap <leader><tab> :Scratch<CR>
" }
" Fuzzy Finder {
""" Fuzzy Find file, tree, buffer, line
nmap <leader>ff :FufFile **/<CR>
nmap <leader>ft :FufFile<CR>
nmap <leader>fb :FufBuffer<CR>
nmap <leader>fl :FufLine<CR>
nmap <leader>fr :FufRenewCache<CR>
let g:fuf_dataDir=$HOME . '/.vim/.cache/fuzzyfind/'
" }
" Session List {
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
let g:session_autosave = 'no'
let g:session_autoload = 'no'
nmap <leader>os :OpenSession<CR>
nmap <leader>ss :SaveSession<CR>
nmap <leader>vs :ViewSession<CR>
" }
" Buffer explorer settings {
nmap <leader>b :BufExplorer<CR>
" }
" Ctrl-P settings {
let g:ctrlp_cache_dir=$HOME . '.vim/.cache/ctrlp/'
" }
" Taglist settings {
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Update = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1

let g:ctags_statusline=1
" Override how taglist does javascript
let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method;p:property;v:global'
" }
" YankRing settings {
let g:yankring_history_dir=$HOME . '/.vim/.cache/yankring/'
let g:yankring_history_file='yankring.hist'
" }
" }

" NERDTree helper function {
function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction
" }

" Use local vimrc if available {
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
" }

" Language-related settings {
" Python {
autocmd FileType python set foldmethod=indent foldlevel=99
au Filetype python set omnifunc=pythoncomplete#Complete
" set colorcolumn=85 " Make this column red, so I can see if the line is too long
let g:SuperTabDefaultCompletionType='context'
let g:pyflakes_use_quickfix=0
let g:pep8_map='<leader>8'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchWindows = 1
let g:miniBufExplModSelTarget = 1

" }
" }
