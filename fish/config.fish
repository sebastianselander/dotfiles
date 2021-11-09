starship init fish | source

#set default editor
set -Ux EDITOR nvim

# Custom functions below
alias cfg='cd ~/.config'
alias vim='nvim'
alias ls='exa --group-directories-first'
alias lst='exa -s modified'
alias rmlatex='rm *.log *.aux *.out'

# safer
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

# intellij scuffed lol
alias intellij='_JAVA_AWT_WM_NONREPARENTING=1 idea'
