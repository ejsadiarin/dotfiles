#!/bin/bash

# Function to check for successful SSH logins
check_successful_ssh_logins() {
    echo "Checking successful SSH logins..."
    grep 'sshd.*Accepted' /var/log/auth.log | awk '{print $1, $2, $3, $9, $11}' # Date, User, IP Address
}

# Function to check for failed SSH login attempts
check_failed_ssh_logins() {
    echo "Checking failed SSH login attempts..."
    grep 'sshd.*Failed' /var/log/auth.log | awk '{print $1, $2, $3, $9, $11}' # Date, User, IP Address
}

# Function to block an IP address using UFW (Uncomplicated Firewall)
block_ip() {
    local ip=$1
    echo "Blocking IP: $ip"
    ufw deny from $ip
}

# Function to unblock an IP address using UFW
unblock_ip() {
    local ip=$1
    echo "Unblocking IP: $ip"
    ufw delete deny from $ip
}

# Function to display the UFW status and see if the IP is blocked
check_blocked_ips() {
    echo "Checking blocked IPs using UFW..."
    ufw status | grep 'DENY'
}

# Function to restart the SSH service
restart_ssh_service() {
    echo "Restarting SSH service..."
    systemctl restart sshd
}

# Function to show the last login details for users
show_last_logins() {
    echo "Showing last login information for users..."
    last -i | head -n 20
}

# Function to check for any SSH brute-force attempts by monitoring auth logs
monitor_bruteforce_attempts() {
    echo "Checking for SSH brute-force attempts in auth.log..."
    grep -i "failed" /var/log/auth.log | awk '{print $1, $2, $3, $9, $11}' | sort | uniq -c | sort -n
}

# Function to check UFW status and ensure SSH is allowed
check_ufw_status() {
    echo "Checking UFW status..."
    ufw status
}

# Function to restart the machine (if needed after applying changes)
restart_machine() {
    echo "Restarting the machine to apply changes..."
    shutdown -r now
}

# List all current SSH connections
#
# This function lists all current SSH connections using the ss command (similar to netstat).
list_all_ssh_connections() {
    ss -atp | grep ssh
}

# Watch SSH login attempts in real-time
#
# This function runs tail -f on the auth.log file, which displays the last
# lines of the log file and then waits for new lines to be appended to the
# file, updating the display in real-time.
watch_ssh() {
    tail -f /var/log/auth.log
}
