#!/bin/zsh

# Exit script on error
set -e

mkdir -p ai

# cloneOrPull <GIT_URL> <LOCAL_PATH>
function cloneOrPull {
  if [ -e "$2" ]; then
    bash -c "cd $2; git pull";
    cd
  else
    git clone $1 $2;
  fi
}

cloneOrPull https://github.com/Jeffallan/claude-skills.git ai/jeffallan-claude-skills
cloneOrPull https://github.com/google-labs-code/stitch-skills.git ai/google-labs-code-stitch-skills
cloneOrPull https://github.com/vercel-labs/agent-skills.git ai/vercel-labs-agent-skills
cloneOrPull https://github.com/wshobson/agents.git ai/wshobson-agents
