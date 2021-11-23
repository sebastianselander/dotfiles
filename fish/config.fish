starship init fish | source

#set default editor
set -Ux EDITOR nvim

# Custom functions below
alias cfg='cd ~/.config'
alias vim='nvim'
alias ls='exa --group-directories-first -1'
alias lsa='exa --group-directories-first  -la'
alias lst='exa -s modified -1'
alias rmlatex='rm *.log *.aux *.out'
alias ghcid='stack exec ghcid'

# safer
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'
