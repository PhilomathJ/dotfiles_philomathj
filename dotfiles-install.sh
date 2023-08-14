mkdir -p $DOTFILESBACKUPDIR
echo  "Created $DOTFILESDIR and $DOTFILESBACKUPDIR"

# # Make backups of critical files hiding ny errors
cp $HOME/.bashrc $DOTFILESBACKUPDIR 2>/dev/null
cp $HOME/.bash_aliases $DOTFILESBACKUPDIR 2>/dev/null
cp $HOME/.bash_functions $DOTFILESBACKUPDIR 2>/dev/null
cp $HOME/.zshrc $DOTFILESBACKUPDIR 2>/dev/null
cp $HOME/.zsh_aliases $DOTFILESBACKUPDIR 2>/dev/null
cp $HOME/.p10k.zsh $DOTFILESBACKUPDIR 2>/dev/null
echo "Made backup copies of crucial dotfiles in $DOTFILESBACKUPDIR"

# Pull down github dotfiles repository
git clone --bare git@github.com:PhilomathJ/dotfiles.git $DOTFILEDSIR

# Alias new command for this bare repo
function dotfiles {
   /usr/bin/git --git-dir=$DOTFILEDSIR --work-tree=$HOME $@
}

# Attempt to deploy cloned dotfiles
dotfiles checkout
# If dotfiles already exist, back them up
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dot files to $DOTFILESBACKUPDIR.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $DOTFILESBACKUPDIR{}
fi;

dotfiles checkout

# Be sure to only show the dotfiles
dotfiles config status.showUntrackedFiles no
