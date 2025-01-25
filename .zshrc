echo "Using ~/.zshrc"

# Set up some font colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
NORMAL="\e[0m"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# Start the zinit package manager
source "$HOME/.zsh_zinit"

#ZSH_THEME="powerlevel10k/powerlevel10k"


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

# Configure command history tracking
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space	# do not save to history if leading space. Used to run commands without being tracked in history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # make autocomplete search case insensitive
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color $realpath'

# Fuzzy Finder shell integration
eval "$(fzf --zsh)"

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

# SSH Agent should be running, ONCE and only ONCE
#runcount=$(ps -ef | grep "ssh-agent" | grep -v "grep" | wc -l)
#echo "ssh-agent runcount: $runcount"
#if [ $runcount -eq 0 ]; then
#    echo Starting ssh-agent
#    eval $(ssh-agent -s)
#fi

# Use keychain to manage ssh-agent
SSH_PATH=$HOME/.ssh
eval $(keychain --eval --quiet --confhost $SSH_PATH/id_ed25519)

# Github ssh key
GITHUB_KEY_PRIVATE_KEY=$HOME/.ssh/id_ed25519
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

echo "Setting mouse scroll to natural"
MOUSE_NAME="Logitech MX Master 2S"

# 1. List all input devices
# 2. Filter to the mouse name identified above
# 3. Filter to only of type pointer (instead of keyboard)
# 4. Use regex to extract just the numeric id (after "...id=" and before the next "[")
# 5. Use xargs to remove any leading/trailing whitespace
MOUSE_ID=$(xinput list | grep $MOUSE_NAME | grep 'pointer' | sed -e 's/.*id=//;s/\[.*//' | xargs)

echo "Logitech MX Master 2S id in .zshrc: $MOUSE_ID"
xinput set-prop "$MOUSE_ID" "libinput Natural Scrolling Enabled" 1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export XDG_CONFIG_HOME="/home/jeremy/.config"

# Remap Capslock to Control and Shift+Capslock to normal Capslock
setxkbmap -option "caps:ctrl_shifted_capslock"
