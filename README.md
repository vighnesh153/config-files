# config-files

Configured only for MacOS and Zsh

## Pre-requisites

- zsh should be the default shell: `chsh -s $(which zsh)`
- git should be installed
- Generate an SSH key (`ssh-keygen`) and add it to GitHub account
- Add the following to `.ssh/config`

```
Host vighnesh153.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/<PRIVATE_KEY_FILE>
    IdentitiesOnly yes
```

## Setup

Clone this repository in the home (~) directory

## Install

Run the following script

```sh
~/config-files/install.sh
```

## Post install

- Configure iterm2
  - Natural Text Editing: https://stackoverflow.com/a/22312856/8822610
  - Font size: https://superuser.com/a/879409/1071147
  - Install Gemini CLI: https://geminicli.com/docs/get-started/installation/

## Configuration

### Customizations (ENV)

Run the following command with your custom values:

```sh
touch ~/config-files/env.sh
chmod +x ~/config-files/env.sh

echo "#\!/bin/zsh

# available options: mac-arm64, mac-x64, linux-x64
PIKA__CPU_ARCH=\"mac-arm64\"

" > ~/config-files/env.sh
```

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

### AI configuration

Run the following commands in a new tab (so that `~/config-files/config.sh` is
active).

> !Important: Update the correct

```sh
update_ai_sources

mkdir -p ~/.gemini

ln -s ~/config-files/ai/skills ~/.gemini/skills
ln -s ~/config-files/ai/extensions ~/.gemini/extensions
```
