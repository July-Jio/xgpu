# Create split window
# Create a new tmux session, but don't attach to it yet
sudo tmux new-session -d -s gpuminer

# Split the window horizontally
sudo tmux split-window -v

# Run the Python miner command in the top pane (pane 0)
sudo tmux send-keys -t gpuminer:0.0 'python3 miner.py --gpu=true' C-m

# Wait for 3 seconds
sleep 3

# Run the GPU miner command in the bottom pane (pane 1)
sudo tmux send-keys -t gpuminer:0.1 './xengpuminer' C-m

# Finally, attach to the tmux session
sudo tmux attach -t gpuminer
