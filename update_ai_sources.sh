#!/bin/zsh

# Exit script on error
set -e

MY_CONFIG_PATH=''

while getopts 'p:' flag; do
  case "${flag}" in
    p) MY_CONFIG_PATH="${OPTARG}" ;;
    # *) echo "Unknown flag: ${OPTARG}"
    #    exit 1 ;;
  esac
done

if [[ -z "$MY_CONFIG_PATH" ]]; then
  echo "-p (config-path) not provided... Unable to link ai skills."
  exit 1
fi

mkdir -p ai

source $MY_CONFIG_PATH/env.sh
source $MY_CONFIG_PATH/constants.sh

# cloneOrPull <GIT_URL> <LOCAL_PATH>
function cloneOrPull {
  if [ -e "$2" ]; then
    bash -c "cd $2; git pull";
    cd
  else
    git clone $1 $2;
  fi
}

function fetchGeminiCliExtensionSecurity {
  local artifactName=""
  if [[ "$PIKA__CPU_ARCH" == "mac-arm64" ]]; then
    artifactName="darwin.arm64.security.tar.gz"
  elif [[ "$PIKA__CPU_ARCH" == "mac-x64" ]]; then
    artifactName="darwin.x64.security.tar.gz"
  elif [[ "$PIKA__CPU_ARCH" == "linux-x64" ]]; then
    artifactName="linux.x64.security.tar.gz"
  else
    echo -e "${PIKA__COLOR_RED}Unrecognized CPU architecture: ${PIKA__COLOR_YELLOW}'$PIKA__CPU_ARCH'${PIKA__COLOR_NO_COLOR}. 
      ${PIKA__COLOR_GREEN}Look at the README.md file to learn how to set it.${PIKA__COLOR_NO_COLOR}"
    exit 1
  fi
  
  local extensionPath="$MY_CONFIG_PATH/ai/gemini-cli-extn-security"

  cloneOrPull https://github.com/gemini-cli-extensions/security.git $extensionPath
  
  local latestTag="$(cd $MY_CONFIG_PATH/ai/gemini-cli-extn-security && git describe --tags)"
  local artifactUrl="https://github.com/gemini-cli-extensions/security/releases/download/$latestTag/$artifactName"

  # Store extracted artifact in this this directory
  rm -rf $extensionPath/dist
  local artifactsDir="$extensionPath/dist/artifacts"
  mkdir -p $artifactsDir/tmp
  local storedVersionFile="$extensionPath/dist/version.txt"
  touch $storedVersionFile

  local storedVersion=$(cat "$storedVersionFile")

  if [[ "$storedVersion" == "$latestTag" ]]; then
    echo -e "${PIKA__COLOR_GREEN}Already on latest version of gemini-cli-extensions/security. Skipping download...${PIKA__COLOR_NO_COLOR}"
  else
    # Download artifact zip into a ".../artifacts/tmp" dir
    curl -L --output-dir "$artifactsDir/tmp" -O "$artifactUrl"
    # Extract the above artifact into ".../artifacts" dir
    tar -xzvf "$artifactsDir/tmp/$artifactName" -C "$artifactsDir"
    # Delete the downloaded zipped artifact from ".../artifacts/tmp"
    rm -rf "$artifactsDir/tmp"
    # Save the latest version to avoid re-downloading
    echo -e "$latestTag" > "$storedVersionFile"
  fi
}

# Only skills
cloneOrPull https://github.com/Jeffallan/claude-skills.git $MY_CONFIG_PATH/ai/jeffallan-claude-skills
cloneOrPull https://github.com/google-labs-code/stitch-skills.git $MY_CONFIG_PATH/ai/google-labs-code-stitch-skills
cloneOrPull https://github.com/vercel-labs/agent-skills.git $MY_CONFIG_PATH/ai/vercel-labs-agent-skills
cloneOrPull https://github.com/wshobson/agents.git $MY_CONFIG_PATH/ai/wshobson-agents

# For extensions
cloneOrPull https://github.com/gemini-cli-extensions/code-review.git $MY_CONFIG_PATH/ai/gemini-cli-extn-code-review
cloneOrPull https://github.com/gemini-cli-extensions/conductor.git $MY_CONFIG_PATH/ai/gemini-cli-extn-conductor
fetchGeminiCliExtensionSecurity
cloneOrPull https://github.com/obra/superpowers.git $MY_CONFIG_PATH/ai/obra-superpowers
