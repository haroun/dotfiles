#!/bin/sh
# thanks: https://how-to.dev/how-to-create-tmux-session-with-a-script
# info: The second is sending some command to the window & execute it immediately - thanks to adding C-m after the command.

session='apos'

tmux new -d -s $session

window=0
tmux rename-window -t $session:$window 'apostrophe'
tmux send-keys -t $session:$window 'cd ~/repositories/apostrophecms/apostrophe' C-m

window=1
tmux new-window -t $session:$window -n 'testbed'
tmux send-keys -t $session:$window 'cd ~/repositories/apostrophecms/testbed' C-m

window=2
tmux new-window -t $session:$window -n 'docker-library'
tmux send-keys -t $session:$window 'cd ~/repositories/docker-library' C-m

window=3
tmux new-window -t $session:$window -n 'workspaces'
tmux send-keys -t $session:$window 'cd ~/repositories/apostrophecms/customer-portal' C-m

tmux attach-session -t $session
