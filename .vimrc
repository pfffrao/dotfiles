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

" color schemes
if (has("termguicolors"))
         set termguicolors
endif

syntax enable

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" copy and paste into the system clipboard
nmap <C-p> "+p
vmap <C-y> "+y

set mouse=a

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" Run :PlugUpdate to update the plugins. After the update is finished, you can 
" review the changes by pressing D in the window. Or you can do it later by running :PlugDiff.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
 " Plugin Section
 Plug 'dracula/vim', { 'as': 'dracula' }
 Plug 'mhinz/vim-startify'
 " Install the comment.nvim (step 1)
 Plug 'numToStr/Comment.nvim'
call plug#end()

colorscheme dracula

