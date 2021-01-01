# check environment and install zinit
__zsh::zinit::install()
{
    git clone https://github.com/zdharma/zinit $ZINIT_HOME
    chmod -R 755 $ZINIT_HOME
}

__zsh::zinit::check()
{
    local _ZINIT_HOME_DEFAULT="$HOME/.zinit"
    local _ZINIT_HOME_MACOS="/usr/local/opt/zinit"

    if [ -z "$ZINIT_HOME" ]; then
        if [ -d $_ZINIT_HOME_DEFAULT ]; then
            export ZINIT_HOME="$_ZINIT_HOME_DEFAULT"
        elif [ -d $_ZINIT_HOME_MACOS ]; then
            export ZINIT_HOME="$_ZINIT_HOME_MACOS"
        else
            export ZINIT_HOME="$_ZINIT_HOME_DEFAULT"
            __zsh::zinit::install
        fi
    elif [ ! -d $ZINIT_HOME ]; then
        __zsh::zinit::install
    fi
}

__zsh::zinit::check

# zinit
source $ZINIT_HOME/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# plugins
zinit wait lucid light-mode for \
      b4b4r07/enhancd \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
  from"gh-r" as"program" atinit"export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'" \
      junegunn/fzf-bin \
# history search
zstyle ":history-search-multi-word" page-size "30"
zinit ice wait"1" lucid
zinit load zdharma/history-search-multi-word

# snippet
zinit is-snippet for \
      OMZL::git.zsh \
      OMZP::git \
      PZT::modules/helper/init.zsh
