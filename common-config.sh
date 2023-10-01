#!/bin/bash

# gadog
git config --global alias.adog "log --all --decorate --oneline --graph"
alias gadog="git adog"

# Use node 20
nvm use 20

# Run kotlin file with main function: "kotlinRun hello.kt"
function kotlinRun {
  kotlinc $1 -include-runtime -d output.jar && java -jar output.jar && rm -rf output.jar
}
