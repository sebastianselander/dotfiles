Using alias: `alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'`
we can add, commit, push using `config add, `config commit, `config push`

## Clone the repo by:

cloning to a temporary empty directory

`git clone --separate-git-dir=$HOME/.dotfiles git@github.com:sebastianselander/dotfiles.git $HOME/.dotfiles-tmp`

then removing the temporary directory
