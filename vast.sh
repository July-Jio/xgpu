#!/bin/bash

# Update package list and install necessary packages

sudo apt update
sleep 5
echo "---------------------------"

sudo apt -y install ocl-icd-opencl-dev
sleep 5
echo "---------------------------"

sudo apt -y install nano
sleep 5
echo "---------------------------"

sudo apt -y install htop
sleep 5
echo "---------------------------"

# sudo apt -y install nvtop
sudo apt -y install cmake
sleep 5
echo "---------------------------"

sudo apt -y install python3-pip
sleep 5
echo "---------------------------"

sudo apt install tmux
sleep 5
echo "--------------------------"

# Clone the repository and build the project
git clone https://github.com/shanhaicoder/XENGPUMiner.git
sleep 5
echo "---------------------------"

cd XENGPUMiner
sleep 5
echo "---------------------------"

chmod +x build.sh
sleep 5
echo "---------------------------"

./build.sh
sleep 5
echo "---------------------------"

# Update the configuration file
sed -i 's/account = 0x24691e54afafe2416a8252097c9ca67557271475/account = 0x056640dBeA17979292BC0056A3eE7E259AD03927/g' config.conf
sleep 5
echo "---------------------------"

# Install Python requirements
sudo pip install -U -r requirements.txt
sleep 5
echo "---------------------------"

#  original cmd
# sudo nohup python3 miner.py --gpu=true > miner.log 2>&1 &
# sleep 5
# echo "---------------------------"

# sudo nohup ./xengpuminer > xengpuminer.log 2>&1 &
# sleep 5
# echo "---------------------------"

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
