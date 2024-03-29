set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
 " Plugin Section
 Plug 'dracula/vim'
 Plug 'mhinz/vim-startify'
" Install the comment.nvim (step 1)
Plug 'numToStr/Comment.nvim'
call plug#end()

" Install the comment.nvim (step 2)
lua require('Comment').setup()

" color schemes
if (has("termguicolors"))
         set termguicolors
endif

syntax enable
colorscheme dracula

" move between panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
 
" copies filepath to clipboard by pressing yf
:nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard: command yd
:nnoremap <silent> yd :let @+=expand('%:p:h')<CR>

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" copy and paste into the system clipboard
nmap <C-p> "+p
vmap <C-y> "+y

" Tab is 4 spaces.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set hlsearch
set showmatch
set autoindent
set number

filetype plugin on
set cursorline

set mouse=a

