# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:$(go env GOPATH)/bin"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git iterm2)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


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
	SCRIPT_PATH="${${(%):-%x}:-$0}";
	# echo "initial SCRIPT_PATH: ${SCRIPT_PATH}";

	while [ -h "$SCRIPT_PATH" ];
	do
	    cd "$( dirname -- "$SCRIPT_PATH"; )";
	    SCRIPT_PATH="$( readlink -f -- "$SCRIPT_PATH"; )";
            # echo "SCRIPT_PATH updated to: ${SCRIPT_PATH}";
	done

	cd "$( dirname -- "$SCRIPT_PATH"; )" > '/dev/null';
	SCRIPT_PATH="$( pwd; )";
	# echo "Final SCRIPT_PATH: ${SCRIPT_PATH}";
	popd  > '/dev/null';
}

getScriptDir;
echo "Executing .zshrc under ${SCRIPT_PATH}"
if [[ -x $(which brew) ]]; then
    brew update && "brew formulae updated";
    # brew with github pat
    alias brewgh="dotfiles/brewWithGithubToken.zsh"
fi

export PATH="/Users/raopengfei/riscv/bin:$PATH:/Users/raopengfei/.local/bin"
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

# make alt+arrow key word backward/forward
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# git aliases
alias gpull='git pull';
alias gpush='git push';
alias gs="git status"

alias gcm="git commit -m"
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

if [[ -x $(which nvim) ]]; then
    alias vim="nvim"
    alias gv="git difftool --tool=nvimdiff"
    alias gsv="git difftool --staged --tool=nvimdiff"
    if [[ ! -f ~/.config/nvim/init.vim ]]; then
	    mkdir -p ~/.config/nvim;
	    ln -s ${SCRIPT_PATH}/init.vim ~/.config/nvim/init.vim 
    fi
else
    alias gv="git difftool --tool=vimdiff"
    alias gsv="git difftool --staged --tool=vimdiff"
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

# link .vimrc
if [[ ! -f ~/.vimrc ]]; then
    ln -s ${SCRIPT_PATH}/.vimrc ~/.vimrc
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

# override for doing pintos project
alias pintos-up="docker run -it --rm -v /Users/raopengfei/dotfiles/:/dotfiles -v /Users/raopengfei/Desktop/StanfordPintos/pintos:/pintos pkuflyingpig/pintos bash"

cd;
