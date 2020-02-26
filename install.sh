
ME=`whoami`
DOWNLOAD_PATH=/home/${ME}/jhome/packages
TAR_PATH=${DOWNLOAD_PATH}/downloads
INSTALL_PATH=/home/${ME}/jhome/env

mkdir -p ${TAR_PATH}
mkdir -p ${INSTALL_PATH}

compile()
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

install_archive()
{
    cd ${TAR_PATH}

    wget ${2}
    FILE=$(basename -- "${2}")
    EXT="${FILE##*.}"
    if [ "${EXT}" == "zip" ]; then
        unzip ${FILE}
    else
        tar xzvf ${FILE}
    fi
    mv $1 ${INSTALL_PATH}
}

install_emacs()
{
    if [ -z "$1" ]; then
	VERSION=26.3
    else
	VERSION=$1
    fi

    LINK=http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-${VERSION}.tar.gz
    compile emacs ${LINK} "tar.gz" "--with-xpm=no --with-jpeg=no --with-gif=no --with-tiff=no --with-x-toolkit=lucid --without-x"
    ln -s $HOME/configuration/emacs $HOME/.emacs.d
    cd ${INSTALL_PATH}/emacs-${VERSION}/bin/
    ./emacs --eval package-install
}

install_git()
{
    if [ -z "$1" ]; then
	VERSION=2.25.0
    else
	VERSION=$1
    fi

    LINK=https://www.kernel.org/pub/software/scm/git/git-${VERSION}.tar.gz
    compile git ${LINK}
}

install_htop()
{
    if [ -z "$1" ]; then
	VERSION=2.2.0
    else
	VERSION=$1
    fi

    LINK=http://hisham.hm/htop/releases/${VERSION}/htop-${VERSION}.tar.gz
    compile htop ${LINK}
}

install_python3()
{
    if [ -z "$1" ]; then
	VERSION=3.8.1
    else
	VERSION=$1
    fi

    LINK=https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz
    compile Python ${LINK} "tgz" "--enable-optimizations"
}

install_golang()
{
    if [ -z "$1" ]; then
        VERSION=1.13.7
    else
        VERSION=$1
    fi

    LINK=https://dl.google.com/go/go${VERSION}.linux-amd64.tar.gz
    install_archive go ${LINK}
}

install_gradle()
{
    if [ -z "$1" ]; then
        VERSION=6.1.1
    else
        VERSION=$1
    fi

    LINK=https://services.gradle.org/distributions/gradle-6.1.1-bin.zip
    install_archive gradle-${VERSION} ${LINK}
}

#ln -s $PWD/.j ../.j
#source $PWD/.j

#install_emacs 26.3
#install_git 2.25.0
#install_htop 2.2.0
#install_python3 3.8.1
#install_golang 1.13.7
install_gradle 6.1.1
