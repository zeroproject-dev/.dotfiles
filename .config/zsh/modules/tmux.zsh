### TMUX

function t () {
  local bfor=$(pwd)

  if [ -z "$1" ]; then
    local ZOXIDE_RESULT=$(zoxide query -l | fzf --reverse)
  else
    local ZOXIDE_RESULT=$(zoxide query $1)
  fi

  if [ -z "$ZOXIDE_RESULT" ]; then
    return 1
  fi

  local FOLDER=$(basename $ZOXIDE_RESULT | sed 's/\./_/g')

  local SESSION=$(tmux list-sessions | grep "$FOLDER" | awk '{print $1}')
  local SESSION=${SESSION//:/}

  if [ -z "$TMUX" ]; then
    if [ -z "$SESSION" ]; then
      cd $ZOXIDE_RESULT
      tmux new-session -s $FOLDER
    else
      tmux attach-session -t $SESSION
    fi
  else
    if [[ -z "$SESSION" ]]; then
      cd $ZOXIDE_RESULT
      tmux new-session -d -s $FOLDER
      tmux switch-client -t $FOLDER
    else
      tmux switch-client -t $SESSION
    fi
  fi

  cd $bfor
}

### TMUXIFIER

export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

function tt() {
  local SESSION=""

  if [ ! -z "$1" ]; then
    tmuxifier load-session $1
    return;
  fi

  SESSION=$(/bin/ls "$HOME/.tmuxifier/layouts/" | fzf --reverse --delimiter ' ')

  if [ -z "$SESSION" ]; then
    echo -n "Enter a session name> "
    read SESSION
    tmuxifier new-session $SESSION
    tmuxifier load-session $SESSION
  else
    SESSION=$(basename $SESSION .session.sh)
    tmuxifier load-session $SESSION
  fi
}
