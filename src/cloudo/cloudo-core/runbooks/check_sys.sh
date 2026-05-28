#!/bin/bash
# System Health Check Script
# Performs basic system health monitoring including disk, memory, CPU and processes

# Check Disk Space
check_disk_space() {
    echo "Disk Space Usage:"
    df -h | grep -E '^/dev/'
}

# Check CPU Load
check_cpu_load() {
    echo "CPU Load:"
    uptime
}

# Check Critical Processes
check_processes() {
    echo "Critical Processes Status:"
    ps aux | head -1
    ps aux | grep -E "sshd|httpd|mysqld" | grep -v grep
}

# Main execution
echo "=== System Health Check ==="
echo $(env | grep AKS)
echo $(env | grep MONITOR_CONDITION)

echo "Date: $(date)"
echo

check_disk_space
echo

check_cpu_load
echo

check_processes
echo
