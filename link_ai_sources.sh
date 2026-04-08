#!/bin/zsh

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

# Delete existing symlinks
find $MY_CONFIG_PATH/skills -type l -delete
find $MY_CONFIG_PATH/extensions -type d -delete

# Link skills to correct paths
ln -s $MY_CONFIG_PATH/ai/google-labs-code-stitch-skills/skills/react-components $MY_CONFIG_PATH/skills/google-labs-code-stitch-react-components
ln -s $MY_CONFIG_PATH/ai/google-labs-code-stitch-skills/skills/enhance-prompt $MY_CONFIG_PATH/skills/google-labs-code-stitch-enhance-prompt

ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/cloud-architect $MY_CONFIG_PATH/skills/jeffallan-cloud-architect
ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/code-documenter $MY_CONFIG_PATH/skills/jeffallan-code-documenter
ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/debugging-wizard $MY_CONFIG_PATH/skills/jeffallan-debugging-wizard
ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/fullstack-guardian $MY_CONFIG_PATH/skills/jeffallan-fullstack-guardian
ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/javascript-pro $MY_CONFIG_PATH/skills/jeffallan-javascript-pro
ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/kotlin-specialist $MY_CONFIG_PATH/skills/jeffallan-kotlin-specialist
ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/react-expert $MY_CONFIG_PATH/skills/jeffallan-react-expert
ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/the-fool $MY_CONFIG_PATH/skills/jeffallan-the-fool
ln -s $MY_CONFIG_PATH/ai/jeffallan-claude-skills/skills/typescript-pro $MY_CONFIG_PATH/skills/jeffallan-typescript-pro

ln -s $MY_CONFIG_PATH/ai/vercel-labs-agent-skills/skills/composition-patterns $MY_CONFIG_PATH/skills/vercel-composition-patterns
ln -s $MY_CONFIG_PATH/ai/vercel-labs-agent-skills/skills/react-best-practices $MY_CONFIG_PATH/skills/vercel-react-best-practices

ln -s $MY_CONFIG_PATH/ai/wshobson-agents/plugins/framework-migration/skills/react-modernization $MY_CONFIG_PATH/skills/wshobson-react-modernization
ln -s $MY_CONFIG_PATH/ai/wshobson-agents/plugins/frontend-mobile-development/skills/tailwind-design-system $MY_CONFIG_PATH/skills/wshobson-tailwind-design-system
ln -s $MY_CONFIG_PATH/ai/wshobson-agents/plugins/javascript-typescript/skills/javascript-testing-patterns $MY_CONFIG_PATH/skills/wshobson-javascript-testing-patterns
ln -s $MY_CONFIG_PATH/ai/wshobson-agents/plugins/javascript-typescript/skills/modern-javascript-patterns $MY_CONFIG_PATH/skills/wshobson-modern-javascript-patterns
ln -s $MY_CONFIG_PATH/ai/wshobson-agents/plugins/javascript-typescript/skills/typescript-advanced-types $MY_CONFIG_PATH/skills/wshobson-typescript-advanced-types
ln -s $MY_CONFIG_PATH/ai/wshobson-agents/plugins/ui-design/skills/mobile-android-design $MY_CONFIG_PATH/skills/wshobson-mobile-android-design


function linkExtension {
  mkdir -p $2

  local jsonContent="{\"type\": \"link\", \"source\": \"$1/\"}"
  echo $jsonContent > $2/.gemini-extension-install.json
}

# Link extensions to correct path
linkExtension $MY_CONFIG_PATH/ai/gemini-cli-extn-code-review $MY_CONFIG_PATH/extensions/gemini-cli-extn-code-review
linkExtension $MY_CONFIG_PATH/ai/gemini-cli-extn-conductor $MY_CONFIG_PATH/extensions/gemini-cli-extn-conductor
linkExtension $MY_CONFIG_PATH/ai/gemini-cli-extn-security/dist/artifacts $MY_CONFIG_PATH/extensions/gemini-cli-extn-security
linkExtension $MY_CONFIG_PATH/ai/obra-superpowers $MY_CONFIG_PATH/extensions/obra-superpowers
