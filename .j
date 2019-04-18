
source $HOME/configuration/bashrc

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=/usr/local/Cellar/emacs/26.2/bin/:$PATH
export PATH=$HOME/env/git/bin/:$PATH
export PATH=$HOME/env/htop/bin/:$PATH
export PATH=$HOME/env/tmux/bin/:$PATH

git config --global user.name "Jooho Yoon"
git config --global user.email "jooho.yoon.91@gmail.com"
git config --global core.editor "emacs"
