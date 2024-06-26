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

alias di="docker image"
alias dc="docker compose"
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

# aliases for cd to upper directories
alias .1="cd .."
alias .2="cd ../../"
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

export PATH="$PATH:/opt/nvim-linux64/bin"

if [[ ! -x $(which nvim) ]]; then
	# install neovim
	# Install from pre-built archives
	# Reference: https://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-2
	sudo apt-get install curl tar;
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	rm -rf /opt/nvim
	tar -C /opt -xzf nvim-linux64.tar.gz
fi

if [[ -x $(which nvim) ]]; then
    alias nv="nvim"
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

# Install vim-plug for neovim and vim (compatible on UNIX and Linux systems)
NVIM_PLUG_PATH="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim;
echo "Try Installing vim-plug for neovim at ${NVIM_PLUG_PATH}";
if [[ ! -f ${NVIM_PLUG_PATH} ]]; then
    echo "Installing vim-plug for neovim at ${NVIM_PLUG_PATH}";
    curl -fLo ${NVIM_PLUG_PATH} --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
else
    echo "vim-plug seems already installed for nvim";
fi

VIM_PLUG_PATH="${HOME}/.vim/autoload/plug.vim";
echo "Try Installing vim-plug for vim at ${VIM_PLUG_PATH} ]";
if [[ ! -f ${VIM_PLUG_PATH} ]]; then
    echo "Installing vim-plug for vim at ${VIM_PLUG_PATH}";
    curl -fLo ${VIM_PLUG_PATH} --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
else
    echo "vim-plug seems already installed for vim";
fi

# Set up fzf key bindings and fuzzy completion
# This needs to be executed at the end of bashrc.
if [[ -x $(which fzf) ]]; then
    eval "$(fzf --bash)";
fi

# use vim key binding for terminal
set -o vi;

echo "setting up fzf aliases for bash";
if [[ -x $(which fzf) ]]; then
    # set up some fzf alias
    alias gcb='git checkout $(git branch | fzf)';
    alias llf="ls -al | fzf";
    alias cdf="cd \$(ls -al | fzf)";
fi

if [ ! -f ~/.bashrc.done ]; then
    echo "[[ -f ~/dotfiles/.bashrc ]] && source ~/dotfiles/.bashrc;" >> ~/.bashrc
    touch ~/.bashrc.done;
fi

if [ -f ~/dotfiles/.vscode/keybindings.json ]; then
    echo "Coping vscode key bindings";
    mkdir -p ~/.config/Code/User/;
    cp ~/dotfiles/.vscode/keybindings.json ~/.config/Code/User/;
fi

