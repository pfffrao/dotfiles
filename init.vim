" Use ~/.vimrc as the configuration
" Reference: https://neovim.io/doc/user/nvim.html#nvim-from-vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" Install the comment.nvim (step 2). Plugin is installed in the vim setting,
" but only nvim is able to execute this.
lua require('Comment').setup()

