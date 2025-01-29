#!/bin/bash

# Ensure pacman is installed
if ! command -v pacman &> /dev/null; then
    echo "Error: pacman package manager is not available."
    exit 1
fi

# Define package groups categorized by architecture
declare -A package_groups
package_groups=(
    [base]="compression Database development editors libraries net-utils perl-modules python-modules sys-utils utilities VCS vim-plugins"
    [cross]="mingw-w64-cross mingw-w64-cross-clang-toolchain mingw-w64-cross-toolchain"
    [mingw64]="mingw-w64-x86_64-toolchain mingw-w64-x86_64-qt5 mingw-w64-x86_64-qt5-debug mingw-w64-x86_64-qt6 mingw-w64-x86_64-qt6-debug mingw-w64-x86_64-objfw mingw-w64-x86_64-vulkan-devel mingw-w64-x86_64-texlive-full mingw-w64-x86_64-texlive-scheme-basic mingw-w64-x86_64-texlive-scheme-full mingw-w64-x86_64-texlive-scheme-tetex"
    [clangarm64]="mingw-w64-clang-aarch64-toolchain mingw-w64-clang-aarch64-qt5 mingw-w64-clang-aarch64-qt5-debug mingw-w64-clang-aarch64-qt6 mingw-w64-clang-aarch64-qt6-debug mingw-w64-clang-aarch64-objfw mingw-w64-clang-aarch64-vulkan-devel mingw-w64-clang-aarch64-texlive-full mingw-w64-clang-aarch64-texlive-scheme-basic mingw-w64-clang-aarch64-texlive-scheme-full mingw-w64-clang-aarch64-texlive-scheme-tetex"
    [clang64]="mingw-w64-clang-x86_64-toolchain mingw-w64-clang-x86_64-qt5 mingw-w64-clang-x86_64-qt5-debug mingw-w64-clang-x86_64-qt6 mingw-w64-clang-x86_64-qt6-debug mingw-w64-clang-x86_64-objfw mingw-w64-clang-x86_64-vulkan-devel mingw-w64-clang-x86_64-texlive-full mingw-w64-clang-x86_64-texlive-scheme-basic mingw-w64-clang-x86_64-texlive-scheme-full mingw-w64-clang-x86_64-texlive-scheme-tetex"
    [ucrt64]="mingw-w64-ucrt-x86_64-toolchain mingw-w64-ucrt-x86_64-qt5 mingw-w64-ucrt-x86_64-qt5-debug mingw-w64-ucrt-x86_64-qt6 mingw-w64-ucrt-x86_64-qt6-debug mingw-w64-ucrt-x86_64-objfw mingw-w64-ucrt-x86_64-vulkan-devel mingw-w64-ucrt-x86_64-texlive-full mingw-w64-ucrt-x86_64-texlive-scheme-basic mingw-w64-ucrt-x86_64-texlive-scheme-full mingw-w64-ucrt-x86_64-texlive-scheme-tetex"
)

# Function to install packages
install_packages() {
    local group=$1
    echo "============================================"
    echo "Installing packages for group: $group"
    echo "============================================"
    pacman -S --noconfirm --needed ${package_groups[$group]}
    echo "Installation for $group completed!"
}

# Function to install everything
install_all() {
    echo "============================================"
    echo "Installing ALL packages across all groups..."
    echo "============================================"
    for group in "${!package_groups[@]}"; do
        install_packages "$group"
    done
    echo "All packages installed successfully!"
}

# Function to display menu and handle user selection
choose_msys_installation() {
    echo "============================================"
    echo "        MSYS2 AIO PACKAGE INSTALLER"
    echo "============================================"
    echo "1. Install Base Packages"
    echo "2. Install Cross Toolchain Packages"
    echo "3. Install MINGW64 Packages"
    echo "4. Install ClangARM64 Packages"
    echo "5. Install Clang64 Packages"
    echo "6. Install UCRT64 Packages"
    echo "7. Install Everything"
    echo "0. Exit"
    echo "============================================"

    read -p "Enter your selection: " selection

    case $selection in
        1) install_packages "base" ;;
        2) install_packages "cross" ;;
        3) install_packages "mingw64" ;;
        4) install_packages "clangarm64" ;;
        5) install_packages "clang64" ;;
        6) install_packages "ucrt64" ;;
        7) install_all ;;
        0) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again."; choose_msys_installation ;;
    esac

    echo "Installation process completed!"
}

# Update package database before installation
echo "Updating package database..."
if ! pacman -Sy; then
    echo "Failed to update package database. Please check your connection."
    exit 1
fi

# Start the menu
choose_msys_installation