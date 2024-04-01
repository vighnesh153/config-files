# config-files

Configured only for MacOS and Zsh

## Pre-requisites
* git should be installed
* zsh should be the default shell: `chsh -s $(which zsh)`

## Setup

Clone this repository in the home (~) directory

## Install

Run the following script

```sh
~/config-files/install.sh
```

## Configuration

### Shell configuration

Add the following line in your `.zshrc`

```sh
source ~/config-files/config.sh
```

### Vim configuration

Add the following line to `~/.vimrc` file

```vimrc
source ~/config-files/.vimrc
```
