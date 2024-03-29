# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
if [[ -x $(which go) ]]; then
    export PATH="$PATH:$(go env GOPATH)/bin"
fi

alias dim="docker image"
alias dc="docker-compose"
alias dct="docker container"
alias dsp="docker system prune"
alias dspa="docker system prune --all"
alias dspv="docker system prune --volumes"
alias ll="ls -al"
alias lal="ls -al"
alias dotfiles="~/dotfiles"
alias cdotfiles="cd ~/dotfiles"

# git aliases
alias gpull='git pull';
alias gpush='git push';
alias gs="git status"

if [[ -x $(which nvim) ]]; then
    alias vim="nvim"
    alias gv="git difftool --tool=nvimdiff"
    alias gsv="git difftool --staged --tool=nvimdiff"
    if [[ ! -f ~/.config/nvim/init.vim ]]; then
        ln -s init.vim ~/.config/nvim/init.vim 
    fi
else
    if [[ ! -f ~/.vimrc ]]; then
        ln -s .vimrc ~/.vimrc
    fi
    alias gv="git difftool --tool=vimdiff"
    alias gsv="git difftool --staged --tool=vimdiff"
fi

alias gcm="git commit -m"
alias gau="git add --update"
alias gpso="git push --set-upstream origin"
alias grv="git remote -v"

# Install fzf when it's not installed.
if [[ ! -x $(which fzf) ]]; then
    if [[ -x $(which brew) ]]; then
        brew install fzf || (echo "Failed to install fzf with brew." && exit 1);
        # Set up fzf key bindings and fuzzy completion
        eval "$(fzf --zsh)"
    else
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
        ~/.fzf/install || ( echo "Failed to install fzf" && exit 1);
    fi
else
    echo "fzf already installed";
fi

if [[ -x $(which fzf) ]]; then
    # Set up fzf key bindings and fuzzy completion
    eval "$(fzf --zsh)";
    # set up some fzf alias
    alias gcb='git checkout $(git branch | fzf)';
    alias llf="ls -al | fzf";
    alias cdf="cd \$(ls -al | fzf)";
fi

# use vim key binding for terminal
set -o vi

