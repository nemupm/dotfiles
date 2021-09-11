# tmux
if [ "$(tmux display-message -p '#S')" != '0' ]; then
  tmux attach || tmux
fi

for f in brew zinit language aliases setopt zle prompt
do
  source $HOME/.zsh/${f}.zsh
done
