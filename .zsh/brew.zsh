if [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH=$(echo "$PATH" | sed -e 's/\/usr\/local\/bin://')
  export PATH=$PATH:$HOME/.bin:/usr/local/bin
fi

