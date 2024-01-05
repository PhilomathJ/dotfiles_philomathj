##################################################################################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="agnoster"

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
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# This should fix issue with snap apps not showing up in application launcher
shareApps="$HOME/.local/share/applications"
snapApps="/var/lib/snapd/desktop/applications"

# Detect all installed applications by snap
# for file in $snapApps/*.desktop
# do
#   # Get a not-ugly version of the .desktop
#   # Example: todoist_todoist.desktop -> todoist.desktop
#   link="$shareApps/$(echo $file | cut -d '_' -f2)"

#   # Create new link if none exists
#   [[ -f $link ]] || ln -s $file $link
# done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add to PATH to support python3
export PATH="$PATH:/usr/bin"

# zsh auto-complete in command prompt
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# To add syntax highlighting to the command prompt, this MUST be the last line of .zshrc
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use the  custom alias file ~/.zsh_aliases for all custom aliases
ALIASES_FILE=$HOME/.zsh_aliases
if test -f "$ALIASES_FILE"; then
    # Use the  custom alias file ~/.zsh_aliases for all custom aliases
    source $ALIASES_FILE
    echo "Using $ALIASES_FILE"
else
    echo "404: $ALIASES_FILE does not exist"
fi

# Use the  custom alias file ~/.zsh_aliases for all custom aliases
FUNCTIONS_FILE=$HOME/.zsh_functions
if test -f "$FUNCTIONS_FILE"; then
    source $FUNCTIONS_FILE
    echo "Using $FUNCTIONS_FILE"
else
   echo "404: $FUNCTIONS_FILE does not exist"
fi

# SSH Agent should be running, once
#runcount=$(ps -ef | grep "ssh-agent" | grep -v "grep" | wc -l)
#echo "ssh-agent runcount: $runcount"
#if [ $runcount -eq 0 ]; then
#    echo Starting ssh-agent
#    eval $(ssh-agent -s)
#fi

# Use keychain to manage ssh-agent
SSH_PATH=$HOME/.ssh
eval $(keychain --eval --quiet --confhost $SSH_PATH/id_philomath $SSH_PATH/id_philomath_github)

# Github ssh key
GITHUB_KEY_PRIVATE_KEY=$HOME/.ssh/id_philomath_github
if test -f "$GITHUB_KEY_PRIVATE_KEY"; then
    ssh-add $GITHUB_PRIVATE_KEY
#    echo "Github private key added to ssh-agent"
else
    echo "Github private key missing"
fi

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/jeremy/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jeremy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/home/jeremy/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jeremy/google-cloud-sdk/completion.zsh.inc'; fi

# Create 'dtf' function for working with dotfiles instead of git 
source /home/jeremy/.dotfiles/dotfiles_functions

echo "Setting mouse scroll to natural"
xinput set-prop 10 "libinput Natural Scrolling Enabled" 1
