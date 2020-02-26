
# emacs
alias emacsd="emacs --daemon"
alias emax="emacsclient -t"
alias emacsk="emacsclient -e '(kill-emacs)'"
alias mketags="find -H ./ -name '*.[csSh]' | etags -"

# HTTP
alias serve="python3 -m http.server"

# Image Viewer
alias show="curl https://raw.githubusercontent.com/gimmeyoon/imageme/master/imageme.py | python3"

# sbt
alias sbtnewenv="sbt new sbt/scala-seed.g8"