#!/bin/bash

# Ensure pacman exists
if ! command -v pacman &> /dev/null; then
    echo "Error: pacman package manager is not available."
    exit 1
fi

# Function to update pacman & all packages
update_system() {
    echo "============================================"
    echo "          Updating MSYS2 Packages"
    echo "============================================"

    # Update package database and core system
    echo "Updating package database..."
    pacman -Sy || { echo "Failed to update package database"; exit 1; }

    echo "Updating pacman itself..."
    pacman -S --noconfirm --needed pacman || { echo "Failed to update pacman"; exit 1; }

    echo "Updating all installed packages..."
    pacman -Su --noconfirm || {
        echo "System update failed!"
        exit 1
    }

    echo "All packages updated successfully!"
}

# Function to check if a restart is needed and relaunch MSYS2
restart_msys2_if_needed() {
    if [ -f "/var/run/reboot-required" ]; then
        echo "System requires a restart. Relaunching MSYS2..."

        # Relaunch MSYS2 and re-run this script
        exec mintty /bin/bash -lc "/c/msys64/update_and_run.sh"

        exit 0  # Ensure the script exits after restarting
    fi
}

# Perform system update
update_system

# Check if a restart is required and relaunch MSYS2 if needed
restart_msys2_if_needed

# Run msys2_aio_installer.sh after update
if [[ -f "/c/msys64/msys2_aio_installer.sh" ]]; then
    echo "Starting MSYS2 AIO Installer..."
    /c/msys64/msys2_aio_installer.sh
else
    echo "Error: msys2_aio_installer.sh not found!"
    exit 1
fi
