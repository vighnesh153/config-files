#!/bin/bash

brew update

# Install mise
curl https://mise.run | sh

# Install node
~/.local/bin/mise use --global node@20

# install kotlin cli compiler (https://kotlinlang.org/docs/command-line.html)
brew install kotlin
