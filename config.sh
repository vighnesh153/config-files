#!/bin/zsh

MY_HOME=$HOME

source ~/config-files/oh-my-zsh.sh
source ~/config-files/constants.sh

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

# Feeds git diff to gemini to generate and apply a git commit message.
function gemini_commit() {
  local diff="$(git diff --staged)"
  diff="${diff:0:$PIKA__GEMINI_TOKEN_LIMIT}"

  if [ -z $diff ]; then
    echo "No staged changes to commit."
    return 1
  fi

  echo "Generating commit message..."
  msg=$(echo $diff | gemini -p "Write a concise Conventional Commit message for this diff. Output ONLY the message.")
  echo "Generated commit message: $msg"
  git commit -m "$msg"
}

# Prints rainbow colors
function printRainbowColors {
  for (( i = 30; i < 38; i++ )); do 
    echo -e "\033[0;"$i"m Normal: (0;$i); \033[1;"$i"m Light: (1;$i)"; 
  done
}

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

# Link AI Sources
~/config-files/ai/link_ai_sources.sh

# Run periodic updater
source ~/config-files/periodic_update.sh
