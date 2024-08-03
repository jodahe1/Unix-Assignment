#!/bin/bash

# Function to create a user
create_user() {
    echo "Welcome to User Creation!"
    read -p "Enter username: " username
    useradd "$username"
    passwd "$username"
    echo "User $username created successfully."
    echo -e "\n"  # Add a space after completion
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username

    # Check if the user exists
    if id "$username" &>/dev/null; then
        if userdel -f "$username"; then
            echo "User $username deleted successfully."
        else
            echo "Failed to delete user $username. Check for permission issues or running processes."
        fi
    else
        echo "User $username does not exist."
    fi
    echo -e "\n"  # Add a space after completion
}

# Function to modify user properties
modify_user() {
    echo "Welcome to User Modification!"
    read -p "Enter username to modify: " username
    while true; do
        echo "Select property to modify:"
        echo "1) Change username"
        echo "2) Change password"
        echo "3) Change shell"
        echo "4) Exit"
        read -p "Select an option [1-4]: " option

        case $option in
            1)
                read -p "Enter new username: " new_username
                echo "Changing username from $username to $new_username."
                usermod -l "$new_username" "$username"
                username="$new_username"  # Update variable
                echo "Username changed successfully."
                ;;
            2)
                passwd "$username"
                echo "Password updated for $username."
                ;;
            3)
                current_shell=$(getent passwd "$username" | cut -d: -f7)
                echo "Current shell: $current_shell"
                echo "Available shells:"
                cat /etc/shells
                read -p "Enter new shell: " shell
                chsh -s "$shell" "$username"
                echo "Shell for $username changed to $shell."
                ;;
            4)
                break
                ;;
            *) 
                echo "Invalid option. Please try again." 
                ;;
        esac
        echo -e "\n"  # Add a space after each modification
    done
}

# Function to generate user activity report
user_report() {
    echo "Welcome to User Activity Report!"
    echo "User Account Report:"
    echo "===================="
    printf "%-20s %-10s %-10s %-30s\n" "Username" "UID" "GID" "Comment"
    echo "--------------------------------------------------------"
    awk -F: '{ printf "%-20s %-10s %-10s %-30s\n", $1, $3, $4, $5 }' /etc/passwd
    echo
    echo "Last Login Information:"
    echo "======================="
    last
    echo -e "\n"  # Add a space after report completion
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
        5) 
            echo "Goodbye, $(whoami)!"; 
            exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
    echo -e "\n"  # Add a space after each main menu task
done
