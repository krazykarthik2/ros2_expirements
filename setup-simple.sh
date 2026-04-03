#!/bin/bash

# Simple ROS 2 Setup for Ubuntu 24.04 (Non-interactive)
set -e

export LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive

echo "=== ROS 2 Jazzy Setup for Ubuntu 24.04 ==="

# Update package lists
echo "Updating package lists..."
sudo apt-get update -qq

# Install ROS 2 Desktop
echo "Installing ROS 2 Jazzy Desktop..."
sudo apt-get install -y -qq ros-jazzy-desktop

# Install development tools
echo "Installing development tools..."
sudo apt-get install -y -qq python3-colcon-common-extensions python3-rosdep git

# Initialize rosdep
echo "Initializing rosdep..."
sudo rosdep init 2>/dev/null || true
rosdep update

# Setup environment
echo "Configuring environment..."
if ! grep -q "source /opt/ros/jazzy/setup.bash" ~/.bashrc; then
    echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
fi

# Source the setup file for current session
source /opt/ros/jazzy/setup.bash

echo ""
echo "=== ROS 2 Jazzy Installation Complete ==="
echo "To use ROS 2, run: source /opt/ros/jazzy/setup.bash"
echo "Or restart your terminal."
