"change colours
syntax on
colorscheme lucius
set background=dark

"enable scrolling
set ttymousse=xterm2
set mouse=a

"turn on bracket matching
set showmatch
set matchpairs=(:),{:},[:],<:>

"encoding
set encoding=utf8

"indentation
set autoindent
set smarttab
"insert 2 spaces on tab
set expandtab
"visu of the 2 tabs
set tabstop=2
set softtabstop=2
"2 tab with > too in visual
set shiftwidth=2
set ruler

set backspace=indent,eol,start

set wrap
set linebreak

"highlight search mode
set hls

"json handling
command Js %!python -m json.tool
command Cw %s/\s\+//g | noh
