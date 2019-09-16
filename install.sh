
install_pkg_config()
{
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install pkg-config
}

install_pkg_config()
{
    brew install guntls
}

install_emacs()
{
    brew install emacs
}

install_git()
{
    brew install git
}

install_htop()
{
    brew install htop
}

install_python3()
{
    brew install python3
}

install_tmux()
{
    brew install tmux
}

ln -s $PWD/.j ../.j
source $PWD/.j
#install_pkg_config
#install_gnutls
#install_emacs 
#install_git
#install_htop
#install_python3
#install_tmux
