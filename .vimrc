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
set tabstop=4
set expandtab
set ruler

set backspace=indent,eol,start

set wrap
set linebreak

"highlight search mode
set hls

"json handling
command Js %!python -m json.tool
command Cw %s/\s\+//g | noh
