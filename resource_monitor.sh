#!/bin/bash

# Function to display CPU usage
cpu_usage() {
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)"
    echo
}

# Function to display Memory usage
memory_usage() {
    echo "Memory Usage:"
    free -h
    echo
}

# Function to display Disk I/O
disk_io() {
    echo "Disk I/O:"
    iostat -xz 1 1
    echo
}

# Function to display Network Activity
network_activity() {
    echo "Network Activity:"
    netstat -i
    echo
}

# Clear the screen and start monitoring
clear
echo "Real-Time System Resource Monitor"
echo "Press [CTRL+C] to stop the monitoring."

# Infinite loop to refresh data
while true; do
    cpu_usage
    memory_usage
    disk_io
    network_activity
    sleep 5  # Refresh every 5 seconds
done
