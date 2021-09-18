# enble to subl command in tmux
alias subl='reattach-to-user-namespace subl'

# git
function ghq::jump(){
    local ghq_root=$(ghq root)
    local repo=$(ghq list | fzf)
    if [ -n "$repo" ]; then
        cd "$ghq_root/$repo"
    fi
}
function ghq::browse(){
    local repo_dir=$(ghq list | fzf)
    if [ -z "$repo_dir" ]; then
        return 1;
    fi
    local github_host=$(echo ${repo_dir}| cut -d "/" -f 1)
    local repo=$(echo ${repo_dir}| cut -d "/" -f 2,3)
    GITHUB_HOST=${github_host} hub browse ${repo}
}
function git::pull(){
    local branch="$(git branch --show-current)"
    git pull origin "$branch"
}
function git::backup(){
    git::pull
    git add -A
    git commit -m "__backup__"
    git push origin HEAD
}
alias g='ghq::jump'
alias gh='ghq::browse'

# gitignore
function gi() { curl -L -s https://www.gitignore.io/api/"$@" ;}

# peco
alias peco='fzf'

# get paths quickly
function expand_path() {
    local cur_dir=$(ls -U -d "$(pwd)"/* 2>/dev/null | head -n 100)
    local parent_dir=$(ls -U -d "$(dirname $(pwd))"/* 2>/dev/null | head -n 100)
    local ghq_dir=$(ghq list -p)
    local ecd_dir=$(cat $ENHANCD_DIR/enhancd.log)
    BUFFER=${LBUFFER}$(echo "${cur_dir}\n${parent_dir}\n${ghq_dir}\n${ecd_dir}"| fzf)${RBUFFER}
}
zle -N expand_path
bindkey "^x^p" expand_path

# md2conflu
alias m2c="pbpaste |md2conflu |pbcopy"

# programming-contest
function programming-contest::jump(){
    local root=$(ghq root)/github.com/nemupm/programming-contest/codes
    local contest=$(ls $root| fzf)
    if [ -n "$contest" ]; then
        cd "$root/$contest"
    fi
}
