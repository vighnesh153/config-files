#!/bin/bash

echo "📦 Install HomeBrew 🍺"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Add homebrew to path for the installation script to work
export PATH="/opt/homebrew/bin:$PATH"

echo "📦 Updating brew..."
brew update

echo "Git config"
git config --global user.name vighnesh153
git config --global user.email vighnesh.raut13@gmail.com

# Install mise (version manager for node, python, etc)
echo "📦 Installing Mise..."
curl https://mise.run | sh

# Install tools using mise
echo "📦 Installing Nodejs..."
~/.local/bin/mise use -g node@20
echo "📦 Installing Denoland..."
~/.local/bin/mise use -g deno@latest
echo "📦 Installing Java..."
~/.local/bin/mise use -g java@openjdk-22

# install kotlin cli compiler (https://kotlinlang.org/docs/command-line.html)
echo "📦 Installing kotlin..."
brew install kotlin

echo "📦 Installing iterm2..."
brew install --cask iterm2

echo "📦 Installing rectangle..."
brew install --cask rectangle

# Install oh-my-zsh
export ZSH="$HOME/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
echo "📦 Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://install.ohmyz.sh)" "" --unattended

# Plugins
echo "📦 Installing oh-my-zsh plugin: zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
echo "📦 Installing oh-my-zsh plugin: zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
