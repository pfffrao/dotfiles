syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set hlsearch
set showmatch
set autoindent
set number
colorscheme industry

set wildmode=longest,list
set mouse=a
set clipboard=unnamedplus
filetype plugin on
set cursorline
set ttyfast

" copy and paste into the system clipboard
nmap <C-p> "+p
vmap <C-y> "+y

" move between panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
 
