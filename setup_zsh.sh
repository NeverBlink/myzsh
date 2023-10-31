#!/bin/bash

install_zsh () {
    if command -v apt &>/dev/null; then
        echo "Zsh is not installed. Installing Zsh using apt..."
        sudo echo "Running zsh install with sudo privileges..."
        sudo apt update
        sudo apt install -y zsh
        # Set zsh as the default shell
        if [ -n "$SHELL" ] && [ "$SHELL" != "$(which zsh)" ]; then
            echo "Changing the default shell to Zsh..."
            chsh -s "$(which zsh)"
        fi
    else
        echo "Zsh is not installed, and no known package manager found to install it."
        echo "Please install Zsh manually."
        exit 1
    fi
}

install_curl () {
    if command -v apt &>/dev/null; then
        echo "curl is not installed. Installing curl using apt..."
        sudo echo "Running curl install with sudo privileges..."
        sudo apt update
        sudo apt install -y curl
    else
        echo "curl is not installed, and no known package manager found to install it."
        echo "Please install curl manually."
        exit 1
    fi
}

install_git () {
    if command -v apt &>/dev/null; then
        echo "git is not installed. Installing git using apt..."
        sudo echo "Running git install with sudo privileges..."
        sudo apt update
        sudo apt install -y git
    else
        echo "git is not installed, and no known package manager found to install it."
        echo "Please install git manually."
        exit 1
    fi
}

# Check if zsh is installed
if ! command -v zsh &>/dev/null; then
    install_zsh
    echo "Zsh is installed and set as the default shell."
fi

# Check if curl is installed
if ! command -v curl &>/dev/null; then
    install_curl
fi

# Check if git is installed
if ! command -v git &>/dev/null; then
    install_git
fi

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