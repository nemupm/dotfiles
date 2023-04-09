. $(brew --prefix asdf)/libexec/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

function asdf::install(){
  local plugins=($(cat $HOME/.tool-versions| awk '{print $1}'))
  for plugin in ${plugins[@]}; do
    asdf plugin add ${plugin}
  done
  cd $HOME
  asdf install
}

if [ ! -d $HOME/.asdf/plugins ]; then
  asdf::install
fi
