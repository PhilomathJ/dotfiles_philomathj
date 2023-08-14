# dotfiles
All my dotfiles for Debian machines for [Oh My Z!sh](https://ohmyz.sh/)

## Reference

- Site with full instructions: [dev.to](https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-the-bare-repo-approach-35l3)
- [<img src="https://styles.redditmedia.com/t5_iaosk/styles/communityIcon_jwyv6sinaha41.jpg?width=256&s=15f9d40444aaa70b8d65a0aad2f0dd87ef58d0de" width="48" height="48">](https://www.youtube.com/watch?v=tBoLDpTWVOM&t=21s) DistroTube YouTube on setting this up: [DistroTube]


## Install Bash Script
```
#!/usr/bin/env bash

DOTFILESDIR="$HOME/.dotfiles"
DOTFILESBACKUPDIR="$HOME/.dotfiles-backup"

# Make directory in which to store any pre-existing dotfiles before overwriting
if [ ! -d $DOTFILESBACKUPDIR ]; then
  mkdir -p $DOTFILESBACKUPDIR 2>/dev/null
else
  echo "Directory $DOTFILESBACKUPDIR already exists"
fi

echo  "Created $DOTFILESBACKUPDIR"

# # Make backups of critical files hiding ny errors
function backup_dotfiles() {
  cp $HOME/.bashrc $DOTFILESBACKUPDIR 2>/dev/null;
  cp $HOME/.bash_aliases $DOTFILESBACKUPDIR 2>/dev/null;
  cp $HOME/.bash_functions $DOTFILESBACKUPDIR 2>/dev/null;
  cp $HOME/.zshrc $DOTFILESBACKUPDIR 2>/dev/null;
  cp $HOME/.zsh_aliases $DOTFILESBACKUPDIR 2>/dev/null;
  cp $HOME/.zsh_functions $DOTFILESBACKUPDIR 2>/dev/null;
  cp $HOME/.p10k.zsh $DOTFILESBACKUPDIR 2>/dev/null;
  echo "Made backup copies of crucial dotfiles in $DOTFILESBACKUPDIR";
}
backup_dotfiles;

# If git repo does not already exist, pull down clone github dotfiles repository
if [ ! -d "$DOTFILESDIR" ]; then
  git clone --bare git@github.com:PhilomathJ/dotfiles.git $DOTFILESDIR;
else
  echo  "Dotfiles repo already exists. Not re-cloning";
fi

# Create  new function for use with this bare repo
DOTFILES_FUNCTIONS_FILE="$DOTFILESDIR/dotfiles_functions"
DTF_FUNCTION="function dtf() { \n/usr/bin/git --git-dir=$DOTFILESDIR --work-tree=$HOME \"\$@\" \n}"
# Write function to functions file
echo -e $DTF_FUNCTION > $DOTFILES_FUNCTIONS_FILE
# Append to ~/.zshrc if does not already exist
if ! grep -q "function dtf()" "$HOME/.zshrc"; then
  echo -e "\n# Create 'dtf' function for working with dotfiles instead of git \nsource $DOTFILES_FUNCTIONS_FILE" >> $HOME/.zshrc;
  source $DOTFILES_FUNCTIONS_FILE;
fi
echo "Created 'dtf' function to use instead of 'git' for working with dotfiles only"

# Attempt to deploy cloned dotfiles
dtf checkout -f
# If dotfiles already exist, back them up
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dot files to $DOTFILESBACKUPDIR.";
  dtf checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $DOTFILESBACKUPDIR{}
fi

#dotfiles checkout

# Be sure to only show the dotfiles
#dotfiles config status.showUntrackedFiles no

```
