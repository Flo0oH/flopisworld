#!/bin/bash
echo "Starting system update..."
apt-get update && apt-get upgrade -y
sudo apt-get install tree -y
echo "System update baseline complete!"