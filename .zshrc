# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/qinfeng/.oh-my-zsh"

# Set name of the theme to load --- if set to "random"
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="kphoen"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

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
alias gitgraph='git log --graph --decorate --pretty=tformat:"%C(yellow)%h%Creset %<(80,trunc)%s %Cred%<(50,trunc)%d%Creset %Cblueby %aN%Creset"'
alias gitstat='git log --pretty=format:"[%h] %ae, %ar: %s" --stat'
alias ctagpl="ctags -f tags --recurse --totals --exclude=blib --exclude=.svn --exclude=.git --exclude='*~' --extra=q --languages=Perl --langmap=Perl:+.t"
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'
alias devmode="tmux new-session \; split-window -h -p 70 \; select-pane -t 1 \; split-window -v -p 70"

GPG_TTY=$(tty)
export GPG_TTY
export ZSH="$HOME/.oh-my-zsh"
export LESS='-R -j5'
source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Install Ruby Gems to ~/.gems
export GEM_HOME="$HOME/.gems"
export GEM_PATH="$HOME/.gems"
export PATH="$PATH:$HOME/.gems/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Functions
def() { w3m "https://www.vocabulary.com/dictionary/$1" | tail -n +13 | less }

# VimWiki
vimwiki () {
    if [[ $# == 0 ]]
    then
        nvim +'VimwikiIndex'
    elif [[ $1 == 'git' ]]
    then
        git -C ~/vimwiki/ ${@:2}
    else
        echo 'Usage: vimwiki [git] [args ...]'
    fi
}

convert_pics () {
    size=$1
    i=1
    for p in ${@:2}
    do
        convert $p -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace sRGB -resize $size $i.jpg
        echo $i.jpg
        ((i++))
    done;
}

### SYSTEM SPECIFIC ###
local_rc_file=$HOME/.localrc.sh
if [ -f $local_rc_file ]; then
    source $local_rc_file
fi

if [[ $TERM == "dumb" ]]; then
    export PS1="$ "
fi

alias vim=/usr/local/bin/vim
