#!/bin/sh
# thanks: https://how-to.dev/how-to-create-tmux-session-with-a-script
# info: The second is sending some command to the window & execute it immediately - thanks to adding C-m after the command.

session='code'

tmux new -d -s $session

window=0
tmux rename-window -t $session:$window 'dotfiles'
tmux send-keys -t $session:$window 'cd ~/repositories/dotfiles' C-m

window=1
tmux new-window -t $session:$window -n 'apostrophecms'
tmux send-keys -t $session:$window 'cd ~/repositories/apostrophecms' C-m

window=2
tmux new-window -t $session:$window -n 'docker-library'
tmux send-keys -t $session:$window 'cd ~/repositories/docker-library' C-m

tmux attach-session -t $session
