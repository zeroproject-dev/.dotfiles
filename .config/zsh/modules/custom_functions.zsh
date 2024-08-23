function docker_start() {
  bfo=$(pwd)
  cd ~/docker/$1
  if [ $# -ge 2 ] && [ "$2" = "clear" ]; then
    sudo rm -rf ~/docker/$1/data
  fi
  docker compose up --remove-orphans
  cd "$bfo"
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
