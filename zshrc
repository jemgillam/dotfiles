autoload -U compinit promptinit colors vcs_info
# Autocompletion
compinit
# Prompt
promptinit
# Colours (obviously)
colors

# C-x C-e for editing the command line
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Auto-complete command line switches for aliases
setopt completealiases

# Interpret substitutions in PS1
setopt prompt_subst


# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace

# try to avoid the 'zsh: no matches found...'
setopt nonomatch

# * shouldn't match dotfiles. ever.
setopt noglobdots

# Emacs mode (I find vim mode too slow on command line)
bindkey -e

# Make up and down complete based on currently typed text
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Formatting for VCS
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

last_command_status() {
  if [ "$?" == "0" ]; then
    echo "%{$fg_bold[green]%}➜"
  else
    echo "%{$fg_bold[red]%}➜"
  fi
}


# Theme
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}
if [ "$(hostname)" =~ "^i[mM]ac" ]; then
  PS1='$(last_command_status) %{$fg[cyan]%}$(collapse_pwd) %{$fg_bold[blue]%}$(vcs_info_wrapper)%{$fg_bold[blue]%} % %{$reset_color%}'
elif [ "$(hostname)" =~ "^[bB]enjie" ]; then
  PS1='$(last_command_status) %{$fg[cyan]%}$(collapse_pwd) %{$fg_bold[blue]%}$(vcs_info_wrapper)%{$fg_bold[blue]%} % %{$reset_color%}'
else
  echo "Hostname not recognized, falling back to walters"
  prompt walters
fi

# jump, mark, unmark, marks functions
source ~/.dotfiles/marks

# Common
# HACK for rbenv
export SHELL=/bin/zsh
. ~/.profile_common

fpath=(/usr/local/share/zsh-completions $fpath)

########## NOTES ##########
#
# james147 recommends http://git.grml.org/?p=grml-etc-core.git;a=blob_plain;f=etc/zsh/zshrc;hb=HEAD

export NVM_DIR="/Users/benjiegillam/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
