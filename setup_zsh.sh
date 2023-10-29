#!/bin/bash

if groups | grep -q '\bsudo\b'; then
    echo "User is a member of the sudo group."
else
    echo "User is not a member of the sudo group. Requesting sudo password..."
    # Request the sudo password
    sudo echo "Running script with sudo privileges..."

    # Check if zsh is installed
    if ! command -v zsh &>/dev/null; then
        # If not installed, try to install it based on the package manager available
        if command -v apt &>/dev/null; then
            echo "Zsh is not installed. Installing Zsh using apt..."
            sudo apt update
            sudo apt install -y zsh
        else
            echo "Zsh is not installed, and no known package manager found to install it."
            echo "Please install Zsh manually."
            exit 1
        fi
    fi
fi

# Set zsh as the default shell
if [ -n "$SHELL" ] && [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing the default shell to Zsh..."
    chsh -s "$(which zsh)"
fi

echo "Zsh is installed and set as the default shell."

echo "Installing oh-my-zsh..."
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing plugins..."
# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install powerlevel10k
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# copy settings from git-repo
cp .p10k.zsh ~/.p10k.zsh
cp .zshrc ~/.zshrc

echo "Finished custom zsh installation, please restart shell."