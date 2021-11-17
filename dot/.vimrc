# set default shell if needed
# set -g default-shell /bin/zsh

"Vundle stuff
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tmux-plugins/vim-tmux-focus-events'

call vundle#end()
filetype plugin indent on
""

"enable 256 colours
set t_Co=256

"change colours
syntax on
colorscheme codedark
set background=dark

"enable scrolling
"set ttymousse=xterm2
set mouse=a

"turn on bracket matching
set showmatch
set matchpairs=(:),{:},[:],<:>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"encoding
set encoding=utf8

"indentation
set autoindent
set smarttab
"insert 2 spaces on tab
set expandtab
"visu of the 4 tabs
set tabstop=4
set softtabstop=4
"4 tab with > too
set shiftwidth=4
set ruler

set number

set backspace=indent,eol,start

set wrap
set linebreak

"highlight search mode
set hls

"show colour column at 100 chars 
set colorcolumn=100

"json handling
command Js %!python -m json.tool
command Cw %s/\s\+//g | noh

"autoread
set autoread

"tree startup
"autocmd vimenter * NERDTree

"tree toggle key
nmap <F6> :NERDTreeToggle %<CR>

"map W to w 
cabb W w

set rtp+=~/.fzf
