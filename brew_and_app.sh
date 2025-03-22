#!/bin/bash

# Function to check if Homebrew is installed
check_brew() {
    if command -v brew &>/dev/null; then
        return 0  # Brew is installed
    else
        return 1  # Brew is not installed
    fi
}

# Function to install cask packages based on user input with Y as default
install_app() {
    read -p "Do you want to install $1? (Y/n): " choice
    choice=${choice:-Y}  # Default to Y if no input
    case "$choice" in
        n|N )
            echo "Skipping $1."
            ;;
        * )
            echo "Installing $1..."
            brew install --cask $1
            ;;
    esac
}

# Function to install non-cask packages with Y as default
install_brew_package() {
    read -p "Do you want to install $1? (Y/n): " choice
    choice=${choice:-Y}  # Default to Y if no input
    case "$choice" in
        n|N )
            echo "Skipping $1."
            ;;
        * )
            echo "Installing $1..."
            brew install $1
            ;;
    esac
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    read -p "Do you want to install Oh My Zsh? (Y/n): " choice
    choice=${choice:-Y}  # Default to Y if no input
    case "$choice" in
        n|N )
            echo "Skipping Oh My Zsh."
            ;;
        * )
            echo "Installing Oh My Zsh..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            ;;
    esac
}

# Welcome message
echo "Welcome to the Homebrew Package Installer Script"
echo "================================================"

# Check if Homebrew is installed, install if not
if check_brew; then
    echo "Homebrew is already installed. Skipping installation."
else
    echo "Homebrew is not installed. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ask for each package
echo "Let's install some packages. You'll be asked about each one individually."
echo "Press Enter for Yes (default) or 'n' for No."

# Cask packages

## Browsers
install_app "firefox"
install_app "brave-browser"

## Utils
install_app "unnaturalscrollwheels"
install_app "alt-tab"
install_app "raycast"
install_app "cleanshot"

## Dev
install_brew_package "php"
install_app "sublime-text"
install_app "postman"
install_app "dbeaver-community"
install_app "jetbrains-toolbox"
install_app "lm-studio"
install_app "orbstack"

# Non-cask packages
install_brew_package "ollama"

## Others
install_app "signal"
install_app "spotify"
install_oh_my_zsh

echo "Installation process completed."
