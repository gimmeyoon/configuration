
DOWNLOAD_PATH=${HOME}/packages
TAR_PATH=${DOWNLOAD_PATH}/downloads
INSTALL_PATH=${HOME}/env

mkdir -p ${TAR_PATH}
mkdir -p ${INSTALL_PATH}

install()
{
    cd ${DOWNLOAD_PATH}

    wget ${2}
    if [ "$3" == "tgz" ]; then
        FILE=${1}-${VERSION}.tgz
    else
        FILE=${1}-${VERSION}.tar.gz
    fi
    tar xzvf ${FILE}
    mv ${FILE}  ${TAR_PATH}
    cd ${1}-${VERSION}
    ./configure --prefix=${INSTALL_PATH}/${1}-${VERSION} ${4}
    make install -j4
    cd ${INSTALL_PATH}
    ln -s ${1}-${VERSION} ${1}
}

install_emacs()
{
    if [ -z "$1" ]; then
	    VERSION=26.1
    else
	    VERSION=$1
    fi

    LINK=http://ftp.kaist.ac.kr/gnu/emacs/emacs-${VERSION}.tar.gz
    install emacs ${LINK} "tar.gz" "--with-xpm=no --with-jpeg=no --with-gif=no --with-tiff=no --with-x-toolkit=lucid"
    ln -s $HOME/myconfig/emacs $HOME/.emacs.d
}

install_git()
{
    if [ -z "$1" ]; then
	    VERSION=2.20.1
    else
	    VERSION=$1
    fi

    LINK=https://www.kernel.org/pub/software/scm/git/git-${VERSION}.tar.gz
    install git ${LINK}
}

install_htop()
{
    if [ -z "$1" ]; then
	    VERSION=2.0.2
    else
	    VERSION=$1
    fi

    LINK=http://hisham.hm/htop/releases/${VERSION}/htop-${VERSION}.tar.gz
    install htop ${LINK}
}

install_cmake()
{
    if [ -z "$1" ]; then
	    VERSION=3.8.1
    else
	    VERSION=$1
    fi

    LINK=https://cmake.org/files/v${VERSION}/cmake-${VERSION}.tar.gz
    install cmake ${LINK}
}

install_python3()
{
    if [ -z "$1" ]; then
	    VERSION=3.6.1
    else
	    VERSION=$1
    fi

    LINK=https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz
    install Python ${LINK} "tgz" "--enable-optimizations"
}

install_python()
{
    if [ -z "$1" ]; then
	    VERSION=2.7.13
    else
	    VERSION=$1
    fi

    LINK=https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz
    install Python ${LINK} "tgz"

    cd ${INSTALL_PATH}/Python-${VERSION}
    wget https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
    pip install virtualenv
}

install_tmux()
{
    if [ -z "$1" ]; then
	    VERSION=2.5
    else
	    VERSION=$1
    fi

    LINK=https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
    install tmux ${LINK}
}

ln -s $PWD/.j ../.j
source $PWD/.j
#install_emacs 26.1
#install_git 2.20.1
#install_htop 2.2.0
#install_python3 3.7.1
#install_cmake 3.8.1
#install_python 2.7.13
#install_tmux 2.7
