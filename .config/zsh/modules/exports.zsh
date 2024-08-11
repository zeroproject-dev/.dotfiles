export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/home/zero/.local/bin"
export PATH="$PATH:/home/zero/bin"

# Pkg-config
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/x86_64-linux-gnu/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/share/pkgconfig
export PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Fnm
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"

# Zoxide
eval "$(zoxide init zsh)"

# Dev dependencies
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

if [[ $(uname -a | grep -ci ARCH) -eq 1 ]]; then
  alias vim="nvim"
  alias vi="nvim"
else
  # GO ENVIRONMENT
  export GOROOT="$HOME/bin/go"
  export GOPATH="$HOME/go"
  export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
fi

export EDITOR="nvim"
