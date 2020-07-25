# tmux
if [ "$(tmux display-message -p '#S')" != '0' ]; then
  tmux attach || tmux
fi

for f in language zplug aliases setopt prompt
do
  source $HOME/.zsh/${f}.zsh
done
