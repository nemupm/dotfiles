# prompt
zinit ice svn silent
zinit snippet PZT::modules/prompt
# theme
setopt promptsubst
zinit snippet OMZT::gnzh
# git repo info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () {
 psvar=()
 LANG=en_US.UTF-8 vcs_info
 [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT=''

# show current mode
function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        main|viins)
            PROMPT_2="%F{cyan}(insert)%f"
            ;;
        vicmd)
            PROMPT_2="%F{white}(normal)%f"
            ;;
    esac

    PROMPT='%F{magenta}[%n@%m]%f $PROMPT_2 %~
%1(v|%F{green}%1v%f|)$ '
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
