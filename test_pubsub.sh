#!/bin/bash

# Source ROS 2 setup
source /opt/ros/jazzy/setup.bash

echo "=== ROS 2 Pub/Sub Test ==="
echo "Starting talker and listener..."

# Store PIDs of background processes
declare -a PIDS

# Cleanup function to terminate background processes
cleanup() {
    echo ""
    echo "Terminating background processes..."
    for pid in "${PIDS[@]}"; do
        if kill -0 "$pid" 2>/dev/null; then
            kill "$pid" 2>/dev/null
            echo "Terminated process $pid"
        fi
    done
    wait
    echo "All processes terminated. Exiting."
    exit 0
}

# Trap signals to cleanup
trap cleanup SIGTERM SIGINT EXIT

# Start talker in background
python3 ./talker.py &
TALKER_PID=$!
PIDS+=($TALKER_PID)
echo "Talker started (PID: $TALKER_PID)"

# Small delay to let talker initialize
sleep 1

# Start listener in background


python3 ./listener.py &
LISTENER_PID=$!
PIDS+=($LISTENER_PID)
echo "Listener started (PID: $LISTENER_PID)"

echo ""
echo "Press Ctrl+C to stop both processes..."
echo ""

# Wait for all background processes
wait
