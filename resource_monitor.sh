#!/bin/bash

# Function to display CPU usage
cpu_usage() {
    echo "----------------------------------------"
    echo "CPU Usage as of $(date):"
    echo "----------------------------------------"
    echo "Usage:"
    top -bn1 | grep "Cpu(s)"
    echo
}

# Function to display Memory usage
memory_usage() {
    echo "----------------------------------------"
    echo "Memory Usage as of $(date):"
    echo "----------------------------------------"
    free -h
    echo
}

# Function to display Disk I/O
disk_io() {
    echo "----------------------------------------"
    echo "Disk I/O as of $(date):"
    echo "----------------------------------------"
    iostat -xz 1 1 | awk 'NR==1 || NR==3 || NR==4 {print}'
    echo
}

# Function to display Network Activity
network_activity() {
    echo "----------------------------------------"
    echo "Network Activity as of $(date):"
    echo "----------------------------------------"
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
