#!/bin/bash

set -e
export LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive

echo "=== ROS 2 Jazzy Setup for Ubuntu 24.04 ==="

echo "Updating package lists..."
sudo apt-get update -qq

# Install prerequisites
echo "Installing prerequisites..."
sudo apt-get install -y -qq software-properties-common curl gnupg lsb-release

# Add ROS 2 GPG key
echo "Adding ROS 2 GPG key..."
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
  -o /usr/share/keyrings/ros-archive-keyring.gpg

# Add ROS 2 repository
echo "Adding ROS 2 repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | \
  sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Update again after adding repo
echo "Updating package lists again..."
sudo apt-get update -qq

# Install ROS 2 Desktop
echo "Installing ROS 2 Jazzy Desktop..."
sudo apt install ros-jazzy-ros-base

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

source /opt/ros/jazzy/setup.bash

echo ""
echo "=== ROS 2 Jazzy Installation Complete ==="
