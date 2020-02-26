
ME=`whoami`
export HOME=/home/${ME}/jhome
source $HOME/configuration/bashrc

export PATH=$HOME/env/emacs/bin:$PATH

git config --global user.name "Jooho Yoon"
git config --global user.email "jooho.yoon.91@gmail.com"
git config --global core.editor "emacs"
