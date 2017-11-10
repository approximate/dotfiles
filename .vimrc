" Modeline and Notes {
" vim: foldmarker={,} foldlevel=2 foldmethod=marker nospell
" Latest update: Di 06 Sep 2016 12:59:23 CEST
"
" Initial bundle setup using Vundle {

" This is required
filetype off

" Set up Vundle first
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" My Plugins here:

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-repeat'
Plugin 'mhinz/vim-startify'
Plugin 'Romainl/flattened'
Plugin 'Romainl/vim-qf'
Plugin 'dahu/LearnVim'
Plugin 'junegunn/Goyo.vim'
Plugin 'neomutt/neomutt.vim'

" End of Vundle setup
call vundle#end()
filetype plugin indent on

" }

" General options {

" Setup directories for undo, backups etc {
if has('backup')
    set backup " backups are nice ...
    set backupdir=$HOME/.vim/.cache/backup/ " Write backups to a separate location, not in current dir
endif
if has('undofile')
    set undofile " so is persistent undo ...
    set undolevels=1000 "maximum number of changes that can be undone
    set undoreload=10000 "maximum number lines to save for undo on a buffer reload
    set undodir=$HOME/.vim/.cache/undo/
endif

set directory=$HOME/.vim/.cache/swap/
set path=.,**
" }

" Vim UI tweaks {

colorscheme flattened_dark
set background=light " Use lighter colors from the colorscheme
set mouse=a " automatically enable mouse usage

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\  " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=\ [%{&ff}/%Y] " Format / Filetype
    set statusline+=%=[L:%l/%L,C:%c][%p%%] " Right aligned file nav info
endif

" abbrev. of messages (avoids 'hit enter')
set shortmess+=filmnrxoOtT 

" }

" Formatting {
set formatoptions+=qrn1

set copyindent " Copy previous indentation on autoindent
set tabstop=8 " a Tab char is equal to 8 spaces
set shiftwidth=4 " use indents of 4 spaces
set softtabstop=4 " let backspace delete indent
set expandtab " tabs are spaces, not tabs

set matchpairs+=<:> " match, to be used with %

set pastetoggle=<F12> " pastetoggle (sane indentation on pastes)
set comments=sl:/*,mb:*,elx:*/ " auto format comment blocks
" }

" Wildmenu tweaks {
set wildmode=list:longest,full
set wildignorecase
set wildignore=*.swp,*.bak,*.pyc,*.tmp
" }

" Folding {
" set foldenable " auto fold code
" set foldmethod=indent
" set foldlevel=99
" }

" Other options {
" set whichwrap=b,s,h,l,<,>,[,] " backspace and cursor keys wrap to
set diffopt=filler,context:3,icase,iwhite " better diffs
set formatlistpat=^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*]\\s\\+

" allow non-saved buffers
set hidden

" set nu " Line numbers on
set ignorecase " case insensitive search
set smartcase " case sensitive when uc present

" }
" }

" Key (re)Mappings {

"The default leader is '\', but I  prefer ',' as it's in a standard location
let mapleader = ','

" Make ; work like : for commands.
" Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :

" Make ViM customization easier
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>   " Edit .vimrc
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>  " Reload .vimrc

" Quick buffer switch
nnoremap <leader>q :b#<CR>

" Clear highlighted search
nnoremap <silent> <leader>/ :nohlsearch<CR>


" Turn off F1 for help
nnoremap <F1> <nop>
inoremap <F1> <nop>

" Paragraph reflow with Q in normal and visual modes
nnoremap Q gqap
vnoremap Q gq

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

" Wrapped lines goes down/up to next screen row rather than next line in file.
nnoremap j gj
nnoremap k gk

" These will disable char-based navigation, in order to learn a faster way
" nnoremap h <NOP>
" nnoremap j <NOP>
" nnoremap k <NOP>
" nnoremap l <NOP>

" Homerow goodness
inoremap jj <ESC>

" Better bindings for quickfix stuff
nnoremap <silent><leader>n :cn<CR>
nnoremap <silent><leader>p :cp<CR>
nnoremap <silent><leader>l :clist<CR>

" Stupid shift key fixes for common commands
cnoremap W<CR> w<CR>
cnoremap WQ<CR> wq<CR>
cnoremap wQ<CR> wq<CR>
cnoremap Q<CR> q<CR>
cnoremap Tabe tabe

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" For when you forget to sudo.. Really Write the file.
cnoremap w!! w !sudo tee % >/dev/null

" Insert current date using F3 in Insert mode
inoremap <F3> <C-R>=strftime("%c")<CR>

" C-\ - Open the help page for the word under cursor
nnoremap <C-\> :exec("help ".expand("<cword>"))<CR>

" }

" Autocommands {

" Better cursorline formatting {
augroup highlight_follows_focus
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END

augroup highlight_follows_vim
    autocmd!
    autocmd FocusGained * set cursorline
    autocmd FocusLost * set nocursorline
augroup END
" }

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,sh,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" }

" Plugins {

" Use local vimrc if available {
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
" }

" Startify header {
let g:startify_custom_header = [
  \ '                    _,    _   _    ,_ ',
  \ '               .o888P     Y8o8Y     Y888o. ',
  \ '              d88888      88888      88888b ',
  \ '             d888888b_  _d88888b_  _d888888b ',
  \ '             8888888888888888888888888888888 ',
  \ '             8888888888888888888888888888888 ',
  \ '             YJGS8P"Y888P"Y888P"Y888P"Y8888P ',
  \ '              Y888   ''8''   Y8P   ''8''   888Y ',
  \ '               ''8o          V          o8'' ',
  \ '                 `                     ` ',
  \ '' ]
" }

" }
