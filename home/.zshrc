# OS
export EDITOR="micro"

# ZSH
export HISTFILE=~/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward
autoload -Uz compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' menu yes select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''

# Aliases
alias l='lsd -lh'
alias ls='lsd'
alias ll='lsd -lah'
alias lt='lsd --tree'
alias cat='bat -p --theme=OneHalfDark'
alias mc='mc --nosubshell'
alias mcedit='mcedit --nosubshell'
alias z='zellij'

# Starship
eval "$(starship init zsh)"

# spf
export XDG_CONFIG_HOME="$HOME/.config"
alias spf='spf . ~'

# fzf
WALKER_SKIP="--walker-skip .git,node_modules,.cache,.venv,.composer"
export FZF_ALT_C_OPTS=$WALKER_SKIP
export FZF_CTRL_T_OPTS=$WALKER_SKIP
eval "$(fzf --zsh)"

# Composer
export PATH="$HOME/.composer/vendor/bin:$PATH"

# ZSH Plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
