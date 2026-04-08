#!/bin/zsh

# Exit script on error
set -e

mkdir -p ai/sources

source ~/config-files/env.sh
source ~/config-files/constants.sh

# cloneOrPull <GIT_URL> <LOCAL_PATH>
function cloneOrPull {
  if [ -e "$2" ]; then
    echo "Found $2"
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
  
  local extensionPath="~/config-files/ai/sources/gemini-cli-extn-security"

  cloneOrPull https://github.com/gemini-cli-extensions/security.git $extensionPath
  
  local latestTag="$(cd ~/config-files/ai/sources/gemini-cli-extn-security && git describe --tags)"
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
cloneOrPull https://github.com/Jeffallan/claude-skills.git ~/config-files/ai/sources/jeffallan-claude-skills
cloneOrPull https://github.com/google-labs-code/stitch-skills.git ~/config-files/ai/sources/google-labs-code-stitch-skills
cloneOrPull https://github.com/vercel-labs/agent-skills.git ~/config-files/ai/sources/vercel-labs-agent-skills
cloneOrPull https://github.com/wshobson/agents.git ~/config-files/ai/sources/wshobson-agents

# For extensions
cloneOrPull https://github.com/gemini-cli-extensions/code-review.git ~/config-files/ai/sources/gemini-cli-extn-code-review
cloneOrPull https://github.com/gemini-cli-extensions/conductor.git ~/config-files/ai/sources/gemini-cli-extn-conductor
fetchGeminiCliExtensionSecurity
cloneOrPull https://github.com/obra/superpowers.git ~/config-files/ai/sources/obra-superpowers
