#!/bin/zsh

MY_HOME=$HOME
MY_CONFIG_FILES="$MY_HOME/config-files"

source $MY_CONFIG_FILES/oh-my-zsh.sh

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
eval "$($MY_HOME/.local/bin/mise activate zsh)"

############################
##   Google stuff start   ##
############################
export PATH="$MY_HOME/bin:$PATH"

# Force repo to run with Python3
function repo() {
  command python3 $MY_HOME/bin/repo $@
}

export LD_BIND_NOW=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$MY_HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$MY_HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$MY_HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$MY_HOME/google-cloud-sdk/completion.zsh.inc'; fi

export GOOGLE_APPLICATION_CREDENTIALS=$MY_HOME/.config/gcloud/application_default_credentials.json
export USE_ANDROIDX_REMOTE_BUILD_CACHE=gcp

# MDPROXY-ZSHRC
[[ -e "$MY_HOME/mdproxy/data/mdproxy_zshrc" ]] && source "$MY_HOME/mdproxy/data/mdproxy_zshrc"

alias ssh-3="ssh rvighnesh-003.c.googlers.com"
##########################
##   Google stuff end   ##
##########################

