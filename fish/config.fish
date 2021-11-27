starship init fish | source

fish_default_key_bindings

#set default editor
set -Ux EDITOR nvim

# Custom functions below
alias cfg='cd ~/.config'
alias vi='nvim'
alias vim='nvim'
alias ls='exa --group-directories-first'
alias lsa='exa --group-directories-first -la'
alias lst='exa -s modified -1'
alias rmlatex='rm *.log *.aux *.out'
alias ghci='stack repl'

# safer
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

set PATH $PATH /home/sebastian/.scripts/dotnet
