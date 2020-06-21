"powerline bar
set rtp+=/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/powerline/bindings/vim
"always show statusline
set laststatus=2
"enable 256 colours
set t_Co=256


"change colours
syntax on
colorscheme luna
set background=dark

"enable scrolling
"set ttymousse=xterm2
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
"2 tab with > too
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

"tree startup
"autocmd vimenter * NERDTree

"tree toggle key
nmap N :NERDTreeToggle<CR>
