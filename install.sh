#!/bin/bash

brew update

# Install mise (version manager for node, python, etc)
curl https://mise.run | sh

# Install tools using mise
~/.local/bin/mise use -g node@20
~/.local/bin/mise use -g deno@latest
~/.local/bin/mise use -g bun@latest

# install kotlin cli compiler (https://kotlinlang.org/docs/command-line.html)
brew install kotlin

# Install iterm2
brew install --cask iterm2

# Install oh-my-zsh
ZSH="$HOME/oh-my-zsh"
ZSH_CUSTOM="$ZSH/custom"
sh -c "$(curl -fsSL https://install.ohmyz.sh)" "" --unattended

# Plugins
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
