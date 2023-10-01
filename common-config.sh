#!/bin/bash

# gadog
git config --global alias.adog "log --all --decorate --oneline --graph"
alias gadog="git adog"

# Use node 20
nvm use 20

# Run kotlin file with main function: "kotlinRun hello.kt"
function kotlinRun {
  TEMP_OUTPUT_FILE="$(xxd -l16 -ps /dev/urandom).jar"
  kotlinc $1 -include-runtime -d $TEMP_OUTPUT_FILE && \
    java -jar $TEMP_OUTPUT_FILE && \
        rm -rf $TEMP_OUTPUT_FILE
}
