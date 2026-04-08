#!/bin/zsh

source ~/config-files/constants.sh

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

function pika__update_configs() {
  # Pulls in latest configs
  echo -e "${PIKA__COLOR_YELLOW}Updating ~/config-files...${PIKA__COLOR_NO_COLOR}"
  if ! git -C ~/config-files pull --rebase; then
    echo -e "${PIKA__COLOR_RED}Failed to update ~/config-files${PIKA__COLOR_NO_COLOR}"
    return
  fi
  echo -e "${PIKA__COLOR_GREEN}Successfully updated ~/config-files${PIKA__COLOR_NO_COLOR}"

  # Updates AI skills
  ~/config-files/ai/update_ai_sources.sh

  # Update the last updated time to reset the timer
  local date_file="/tmp/last_ran_time_pika__update_configs.date"
  local current_date=$(date +%s)
  echo -e "$current_date" > "$date_file"
}

# Reminders
remind_every_x_days \
  7 \
  "${PIKA__COLOR_CYAN}It is time to run update your configs by running: ${PIKA__COLOR_YELLOW}pika__update_configs${PIKA__COLOR_NO_COLOR}" \
  /tmp/last_ran_time_pika__update_configs.date
