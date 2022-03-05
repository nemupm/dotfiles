# java
export JAVA_HOME=$(/usr/libexec/java_home)

# sdkman!
export SDKMAN_DIR="$HOME/.sdkman"
zinit ice wait lucid as"program" pick"$HOME/.sdkman/bin/sdk" id-as'sdkman' run-atpull \
    atclone"wget https://get.sdkman.io/?rcupdate=false -O $HOME/.sdkman/scr.sh; bash $HOME/.sdkman/scr.sh" \
    atpull"sdk selfupdate" \
    atinit"source $HOME/.sdkman/bin/sdkman-init.sh"
zinit light zdharma-continuum/null

# nvm
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  zinit ice wait lucid \
      atclone"" \
      atinit'source "$NVM_DIR/nvm.sh"'
  zinit light zdharma-continuum/null
fi

# rbenv
if which rbenv > /dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  zinit ice wait lucid \
      atclone"" \
      atinit'eval "$(rbenv init -)"'
  zinit light zdharma-continuum/null
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
zinit ice wait lucid atclone'$HOME/.pyenv/libexec/pyenv init - > zpyenv.zsh' \
    atinit'eval "$(pyenv virtualenv-init -)"' atpull"%atclone" \
    as'command' pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zinit light pyenv/pyenv

# gvm
if [[ -s "$HOME/.gvm/scripts/gvm" ]]; then
  zinit ice wait lucid \
      atclone"" \
      atinit'source "$HOME/.gvm/scripts/gvm"'
  zinit light zdharma-continuum/null
fi

# direnv
zinit ice wait lucid from"gh-r" as"program" mv"direnv* -> direnv"
zinit light direnv/direnv
