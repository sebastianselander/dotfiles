starship init fish | source

fish_default_key_bindings

#set default editor
set -Ux EDITOR nvim

# Custom functions below
alias cfg='cd ~/.config'
alias vi='nvim'
alias vim='nvim'
alias ls='exa --group-directories-first -1'
alias lsa='exa --group-directories-first -la'
alias lst='exa -s modified -1'
alias rmlatex='rm *.log *.aux *.out *.fdb_latexmk *.fls'
alias ghci='stack repl'

alias aoc='cd ~/Documents/github/aoc21/'

# safer
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

# smoother
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'

#flapper
alias jflap='env GTK_THEME=adwaita jflap %U'

#set PATH $PATH /home/sebastian/.scripts/dotnet
