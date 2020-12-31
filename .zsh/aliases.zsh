# enble to subl command in tmux
alias subl='reattach-to-user-namespace subl'

# git
function ghq::jump(){
    ghq_root=$(ghq root)
    repo=$(ghq list | fzf)
    if [ -n "$repo" ]; then
        cd "$ghq_root/$repo"
    fi
}
function ghq::browse(){
    repo_dir=$(ghq list | fzf)
    if [ -z "$repo_dir" ]; then
        return 1;
    fi
    github_host=$(echo ${repo_dir}| cut -d "/" -f 1)
    repo=$(echo ${repo_dir}| cut -d "/" -f 2,3)
    GITHUB_HOST=${github_host} hub browse ${repo}
}
alias g='ghq::jump'
alias gh='ghq::browse'

# gitignore
function gi() { curl -L -s https://www.gitignore.io/api/"$@" ;}

# peco
alias peco='fzf'

# get paths quickly
function expand_path() {
    cur_dir=$(ls -U -d "$(pwd)"/* 2>/dev/null | head -n 100)
    parent_dir=$(ls -U -d "$(dirname $(pwd))"/* 2>/dev/null | head -n 100)
    ghq_dir=$(ghq list -p)
    ecd_dir=$(cat $ENHANCD_DIR/enhancd.log)
    BUFFER=${LBUFFER}$(echo "${cur_dir}\n${parent_dir}\n${ghq_dir}\n${ecd_dir}"| fzf)${RBUFFER}
}
zle -N expand_path
bindkey "^x^p" expand_path

# md2conflu
alias m2c="pbpaste |md2conflu |pbcopy"

# programming-contest
function programming-contest::jump(){
    root=$(ghq root)/github.com/nemupm/programming-contest/codes
    contest=$(ls $root| fzf)
    if [ -n "$contest" ]; then
        cd "$root/$contest"
    fi
}
