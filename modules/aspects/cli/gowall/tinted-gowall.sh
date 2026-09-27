${XDG_CONFIG_HOME:=$HOME/.config}
mkdir -p "$XDG_CONFIG_HOME/gowall"

if [ -L "$XDG_CONFIG_HOME/gowall/config.yml" ]; then
  rm "$XDG_CONFIG_HOME/gowall/config.yml"
fi

if [ ! -e "$XDG_CONFIG_HOME/gowall/config.yml" ]; then
  ln -s @config@ "$XDG_CONFIG_HOME/gowall/config.yml"
fi
if [ "${1:-}" = "-sb" ] || [ "${1:-}" = "--smart-batch" ]; then
  shift
  exec @gowall@ "$@"
else
  exec @gowall@ "$@"
fi
