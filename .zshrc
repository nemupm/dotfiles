# tmux
if [ "$(tmux display-message -p '#S')" != '0' ]; then
  tmux attach || tmux
fi

for f in zinit language aliases setopt prompt
do
  source $HOME/.zsh/${f}.zsh
done
