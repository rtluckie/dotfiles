#█▓▒░ history
HIST_STAMPS=yyyymmddhhmmss
HISTFILE=$XDG_DATA_HOME/zsh/zhistory
mkdir -p $(dirname $HISTFILE)
setopt APPEND_HISTORY
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
