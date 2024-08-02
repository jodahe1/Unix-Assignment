#!/bin/bash

# Function to create a user
create_user() {
    read -p "Enter username: " username
    useradd "$username"
    passwd "$username"
    echo "User $username created successfully."
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    userdel -r "$username"
    echo "User $username deleted successfully."
}

# Function to modify user properties
modify_user() {
    read -p "Enter username to modify: " username
    read -p "Enter new shell (or leave blank to keep current): " shell
    if [ -n "$shell" ]; then
        chsh -s "$shell" "$username"
        echo "Shell for $username changed to $shell."
    else
        echo "No changes made to shell."
    fi
}

# Function to generate user activity report
user_report() {
    echo "User Account Report:"
    echo "===================="
    awk -F: '{ print $1, $3, $4, $5 }' /etc/passwd
    echo "Last Login Information:"
    last
}

# Main menu
while true; do
    echo "User Management Menu"
    echo "1. Create User"
    echo "2. Delete User"
    echo "3. Modify User"
    echo "4. User Activity Report"
    echo "5. Exit"
    read -p "Select an option [1-5]: " option

    case $option in
        1) create_user ;;
        2) delete_user ;;
        3) modify_user ;;
        4) user_report ;;
        5) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
