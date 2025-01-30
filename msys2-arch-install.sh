#!/usr/bin/env bash

# This script updates MSYS2, then prompts user for which environment(s)
# to install the listed packages for (ucrt64, clang64, clangarm64, mingw64),
# or installs them all.
# Finally, it updates MSYS2 again.

set -e

# Define package sets for each architecture.
PKGS_UCRT64=(\
    mingw-w64-ucrt-x86_64-toolchain \
    mingw-w64-ucrt-x86_64-vulkan-devel \
    mingw-w64-ucrt-x86_64-ccmake \
    mingw-w64-ucrt-x86_64-cmake \
    mingw-w64-ucrt-x86_64-cmake-cmcldeps \
    mingw-w64-ucrt-x86_64-cmake-docs \
    mingw-w64-ucrt-x86_64-cmake-gui
)

PKGS_CLANG64=(\
    mingw-w64-clang-x86_64-toolchain \
    mingw-w64-clang-x86_64-vulkan-devel \
    mingw-w64-clang-x86_64-ccmake \
    mingw-w64-clang-x86_64-cmake \
    mingw-w64-clang-x86_64-cmake-cmcldeps \
    mingw-w64-clang-x86_64-cmake-docs \
    mingw-w64-clang-x86_64-cmake-gui
)

PKGS_CLANGARM64=(\
    mingw-w64-clang-aarch64-toolchain \
    mingw-w64-clang-aarch64-vulkan-devel \
    mingw-w64-clang-aarch64-ccmake \
    mingw-w64-clang-aarch64-cmake \
    mingw-w64-clang-aarch64-cmake-cmcldeps \
    mingw-w64-clang-aarch64-cmake-docs \
    mingw-w64-clang-aarch64-cmake-gui
)

PKGS_MINGW64=(\
    mingw-w64-x86_64-toolchain \
    mingw-w64-x86_64-vulkan-devel \
    mingw-w64-x86_64-ccmake \
    mingw-w64-x86_64-cmake \
    mingw-w64-x86_64-cmake-cmcldeps \
    mingw-w64-x86_64-cmake-docs \
    mingw-w64-x86_64-cmake-gui
)

# First full system update.
echo "Updating MSYS2 packages..."
pacman -Syu --noconfirm

# Prompt user for arch.
echo "Select which environment(s) to install packages for:"
echo "  1) ucrt64"
echo "  2) clang64"
echo "  3) clangarm64"
echo "  4) mingw64"
echo "  5) all"
read -rp "Enter your choice [1-5]: " CHOICE

install_packages() {
    local pkgs=("$@")
    if ((${#pkgs[@]} > 0)); then
        pacman -S --needed --noconfirm "${pkgs[@]}"
    fi
}

case $CHOICE in
    1)
        echo "Installing for ucrt64..."
        install_packages "${PKGS_UCRT64[@]}"
        ;;
    2)
        echo "Installing for clang64..."
        install_packages "${PKGS_CLANG64[@]}"
        ;;
    3)
        echo "Installing for clangarm64..."
        install_packages "${PKGS_CLANGARM64[@]}"
        ;;
    4)
        echo "Installing for mingw64..."
        install_packages "${PKGS_MINGW64[@]}"
        ;;
    5)
        echo "Installing for all architectures..."
        install_packages "${PKGS_UCRT64[@]}"
        install_packages "${PKGS_CLANG64[@]}"
        install_packages "${PKGS_CLANGARM64[@]}"
        install_packages "${PKGS_MINGW64[@]}"
        ;;
    *)
        echo "Invalid selection; exiting." >&2
        exit 1
        ;;

esac

# Final full system update.
echo "Final update..."
pacman -Syu --noconfirm

echo "Done!"
