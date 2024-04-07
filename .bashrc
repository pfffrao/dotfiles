#/bin/bash

function getScriptDir() {
	# Get the directory of the current script being run and set the variable SCRIPT_PATH to it.
	# Credit to: https://stackoverflow.com/a/179231
	# It works for all versions, including
	# when called via multiple depth soft link,
	# when the file it
	# when script called by command "source" aka . (dot) operator.
	# when arg $0 is modified from caller.
	# "./script"
	# "/full/path/to/script"
	# "/some/path/../../another/path/script"
	# "./some/folder/script"

	pushd . > '/dev/null';
	SCRIPT_PATH="${BASH_SOURCE[0]:-$0}";
	# echo "initial SCRIPT_PATH: ${SCRIPT_PATH}";

	while [ -h "$SCRIPT_PATH" ];
	do
	    cd "$( dirname -- "$SCRIPT_PATH"; )";
	    SCRIPT_PATH="$( readlink -f -- "$SCRIPT_PATH"; )";
            #echo "SCRIPT_PATH updated to: ${SCRIPT_PATH}";
	done

	cd "$( dirname -- "$SCRIPT_PATH"; )" > '/dev/null';
	SCRIPT_PATH="$( pwd; )";
	# echo "Final SCRIPT_PATH: ${SCRIPT_PATH}";
	popd  > '/dev/null';
}

getScriptDir;
echo "Executing .bashrc under ${SCRIPT_PATH}"

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

alias gcm="git commit -m"
alias gca="git commit --amend"
alias gau="git add --update"
alias gpso="git push --set-upstream origin"
alias grv="git remote -v"

# git "logdog"
alias gld="git log --graph --oneline --decorate"

export PATH="$PATH:/opt/nvim-linux64/bin"

if [[ ! -x $(which nvim) ]]; then
	# install neovim
	# Install from pre-built archives
	# Reference: https://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-2
	apt-get install curl tar;
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	rm -rf /opt/nvim
	tar -C /opt -xzf nvim-linux64.tar.gz
fi

if [[ -x $(which nvim) ]]; then
    alias vim="nvim"
    alias gv="git difftool --tool=vimdiff"
    alias gsv="git difftool --staged --tool=vimdiff"
    if [[ ! -f ~/.config/nvim/init.vim ]]; then
	    mkdir -p ~/.config/nvim;
	    ln -s ${SCRIPT_PATH}/init.vim ~/.config/nvim/init.vim 
    fi
else
    alias gv="git difftool --tool=vimdiff"
    alias gsv="git difftool --staged --tool=vimdiff"
fi

if [[ ! -f ~/.vimrc ]]; then
    ln -s ${SCRIPT_PATH}/.vimrc ~/.vimrc
fi

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

# Install vim-plug for neovim and vim (compatible on UNIX and Linux systems)
if [[ ! -f ${XDG_DATA_HOME:-$HOME/.local/share} ]]; then
    echo "installing vim-plug for neovim"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    echo "installing vim-plug for vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# use vim key binding for terminal
set -o vi

