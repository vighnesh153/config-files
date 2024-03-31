#!/bin/bash

alias g="git"
alias gss="git status -s"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gp="git push"
alias gr="git remote"
alias gra="git remote add"
alias gadog="git log --all --decorate --oneline --graph"

# Run kotlin file with main function: "kotlinRun hello.kt"
function kotlinRun {
    TMP_DIR=".kotlinRunTmp"
    TEMP_OUTPUT_FILE="$TMP_DIR/$(xxd -l16 -ps /dev/urandom).jar"
    mkdir -p $TMP_DIR
    kotlinc $1 -include-runtime -d $TEMP_OUTPUT_FILE
    java -jar $TEMP_OUTPUT_FILE
    rm -rf $TEMP_OUTPUT_FILE
}

# mise config
eval "$(~/.local/bin/mise activate zsh)"

############################
##   Google stuff start   ##
############################
export PATH="~/bin:$PATH"

# Force repo to run with Python3
function repo() {
  command python3 ~/bin/repo $@
}

export LD_BIND_NOW=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rvighnesh/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rvighnesh/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rvighnesh/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rvighnesh/google-cloud-sdk/completion.zsh.inc'; fi

export GOOGLE_APPLICATION_CREDENTIALS=/Users/rvighnesh/.config/gcloud/application_default_credentials.json
export USE_ANDROIDX_REMOTE_BUILD_CACHE=gcp

# MDPROXY-ZSHRC
[[ -e "/Users/rvighnesh/mdproxy/data/mdproxy_zshrc" ]] && source "/Users/rvighnesh/mdproxy/data/mdproxy_zshrc"

alias ssh-3="ssh rvighnesh-003.c.googlers.com"
##########################
##   Google stuff end   ##
##########################

