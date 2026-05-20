#!/bin/zsh

# Exit script on error
set -e

mkdir -p ~/config-files/ai/sources

source ~/config-files/env.sh
source ~/config-files/constants.sh

# cloneOrPull <GIT_URL> <LOCAL_PATH>
function cloneOrPull {
  if [ -d "$2/.git" ]; then
    bash -c "cd $2; git pull";
  else
    git clone $1 $2;
  fi
  echo -e "Successfully synced ${PIKA__COLOR_GREEN}$2${PIKA__COLOR_NO_COLOR}"
}

# Only skills
cloneOrPull https://github.com/Jeffallan/claude-skills.git ~/config-files/ai/sources/jeffallan-claude-skills
cloneOrPull https://github.com/denoland/skills.git ~/config-files/ai/sources/denoland-skills
cloneOrPull https://github.com/google-labs-code/stitch-skills.git ~/config-files/ai/sources/google-labs-code-stitch-skills
cloneOrPull https://github.com/vercel-labs/agent-skills.git ~/config-files/ai/sources/vercel-labs-agent-skills
cloneOrPull https://github.com/wshobson/agents.git ~/config-files/ai/sources/wshobson-agents
