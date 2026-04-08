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
  diff=$(git diff --staged)

  if [ -z "$diff" ]; then
    echo "No staged changes to commit."
    return 1
  fi

  echo "Generating commit message..."
  msg=$(echo "$diff" | gemini -p "Write a concise Conventional Commit message for this diff. Output ONLY the message.")
  echo "Generated commit message: $msg"
  git commit -m "$msg"
}

# Updates AI skills
function update_ai_sources {
  ~/config-files/ai/update_ai_sources.sh

  # Update the last updated time to reset the timer
  local date_file="/tmp/last_ran_time_update_ai_sources.date"
  local current_date=$(date +%s)
  echo -e "$current_date" > "$date_file"
}

# Prints rainbow colors
function printRainbowColors {
  for (( i = 30; i < 38; i++ )); do 
    echo -e "\033[0;"$i"m Normal: (0;$i); \033[1;"$i"m Light: (1;$i)"; 
  done
}

# Reminds after every x days
#
# Usage: remind_every_x_days <X> <MESSAGE> <TMP_FILE_NAME_TO_STORE_LAST_RAN_TIME>
#
# Example: remind_every_x_days 7 "It is time to run updater" /tmp/last_ran_time_update_ai_sources.date
remind_every_x_days() {
    # Define the local file to store the timestamp
    local date_file="$3"

    # 7 days in seconds
    local seven_days_sec=$(($1 * 24 * 60 * 60))
    
    # Get the current time in epoch seconds
    local current_date=$(date +%s)
    local stored_date
    
    # Check if the file exists
    if [[ -f "$date_file" ]]; then
        # Read the stored epoch time from the file
        stored_date=$(cat "$date_file")
    else
        # Default to epoch time (0) if the file doesn't exist
        stored_date=0
    fi
    
    # Calculate the difference in seconds
    local diff=$((current_date - stored_date))
    
    # If the difference is greater than 7 days
    if [[ "$diff" -gt "$seven_days_sec" ]]; then
        echo -e "$2"
    fi
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


# Reminders
remind_every_x_days \
  7 \
  "${PIKA__COLOR_CYAN}It is time to run update AI skills by running: ${PIKA__COLOR_YELLOW}update_ai_sources${PIKA__COLOR_NO_COLOR}" \
  /tmp/last_ran_time_update_ai_sources.date

# Link AI Sources
~/config-files/ai/link_ai_sources.sh
