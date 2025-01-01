#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Check if username argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 username"
    exit 1
fi

NEW_USER="$1"
CURRENT_USER=$(logname) # captures the username of the current user

# Create the new user with a home directory
adduser --home "/home/$NEW_USER" --shell /bin/bash --gecos "" "$NEW_USER"
usermod -aG sudo "$NEW_USER"
# Copy the .ssh directory from the current user's home to the new user's home
if [ -d "/home/$CURRENT_USER/.ssh" ]; then
    # Create .ssh directory for the new user if it doesn't already exist
    mkdir -p "/home/$NEW_USER/.ssh"
    
    # Copy the contents of the .ssh directory
    cp -r "/home/$CURRENT_USER/.ssh/." "/home/$NEW_USER/.ssh/"
    
    # Adjust permissions
    chown -R "$NEW_USER:$NEW_USER" "/home/$NEW_USER/.ssh"
    chmod 700 "/home/$NEW_USER/.ssh"
    chmod 600 "/home/$NEW_USER/.ssh/"*
    echo ".ssh directory copied from $CURRENT_USER to $NEW_USER"
else
    echo "No .ssh directory found for $CURRENT_USER"
fi

# Inform the user of the successful creation and SSH copy
echo "User $NEW_USER created successfully."
