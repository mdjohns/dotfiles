#!/usr/bin/env bash

current=$(tmux display-message -p '#S')
previous=$(tmux display-message -p '#{client_last_session}')

sessions=$(tmux list-sessions -F '#S' | grep -vx "$current")
# Put previous session first so fzf cursor starts on it
sorted=$(echo "$sessions" | awk -v prev="$previous" 'BEGIN{ORS="\n"} $0==prev{print; next} {rest=rest $0 "\n"} END{printf "%s", rest}')

if [[ -z "$sessions" ]]; then
  selected=$(printf '' | fzf --reverse --print-query --header 'No other sessions — type to create')
else
  selected=$(echo "$sorted" | fzf \
    --reverse \
    --print-query \
    --preview 'tmux capture-pane -ep -t {}' \
    --bind "alt-bspace:execute-silent(tmux kill-session -t {})+reload(tmux list-sessions -F '#S' | grep -vx '$current')")
fi

query=$(echo "$selected" | sed -n '1p')
match=$(echo "$selected" | sed -n '2p')

if [[ -n "$match" ]]; then
  tmux switch-client -t "$match"
elif [[ -n "$query" ]]; then
  dir=$(zoxide query "$query" 2>/dev/null || echo "$HOME")
  # tmux session names can't contain dots
  name=$(echo "$query" | tr '.' '_')
  tmux new-session -d -s "$name" -c "$dir"
  tmux switch-client -t "$name"
fi
