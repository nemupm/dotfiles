# check environment and install zplug
__zsh::zplug::install()
{
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
}

__zsh::zplug::check()
{
    local _ZPLUG_HOME_DEFAULT="$HOME/.zplug"
    local _ZPLUG_HOME_MACOS="/usr/local/opt/zplug"

    if [ -z "$ZPLUG_HOME" ]; then
        if [ -d $_ZPLUG_HOME_DEFAULT ]; then
            export ZPLUG_HOME_DEFAULT="$_ZPLUG_HOME_DEFAULT"
        elif [ -d $_ZPLUG_HOME_MACOS ]; then
            export ZPLUG_HOME_MACOS="$_ZPLUG_HOME_MACOS"
        else
            export ZPLUG_HOME_DEFAULT="$_ZPLUG_HOME_DEFAULT"
            __zsh::zplug::install
        fi
    elif [ ! -d $ZPLUG_HOME ]; then
        __zsh::zplug::install
    fi
}

__zsh::zplug::check

# zplug
source $ZPLUG_HOME/init.zsh

# history search
zplug "zsh-users/zsh-history-substring-search"
# Load theme file
zplug 'dracula/zsh', as:theme
# Supports oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh
# Also prezto
zplug "modules/prompt", from:prezto
# enhancd
zplug "b4b4r07/enhancd", use:init.sh
# vagrant global-status/box controller
zplug 'gongo/pecrant', as:command
# peco
zplug "peco/peco", \
    as:command, \
    from:gh-r
# peco history search
zplug "jimeh/zsh-peco-history"
# zsh plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
# typora-notebook
zplug "nemupm/typora-notebook", use:init.sh
# md2conflu
zplug "nemupm/md2conflu", \
    as:command, \
    use:"exe/md2conflu"
# ecs-deploy
zplug "silinternational/ecs-deploy", as:command

# install plugins
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
