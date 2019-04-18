
# emacs
alias emacsd="emacs --daemon"
alias emax="emacsclient -t"
alias emacsk="emacsclient -e '(kill-emacs)'"
alias mketags="find -H ./ -name '*.[csSh]' | etags -"

# HTTP
alias serve="python2 -m SimpleHTTPServer"

# Image Viewer
alias show="curl https://cdn.rawgit.com/unwitting/imageme/master/imageme.py | python2"
