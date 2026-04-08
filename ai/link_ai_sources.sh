#!/bin/zsh

set -e

# Hacks so that the next 2 commands don't fail
touch /tmp/link1 && ln -s /tmp/link1 ~/config-files/ai/skills/link1
mkdir -p ~/config-files/ai/extensions/link2

# Delete existing symlinks
find ~/config-files/ai/skills/* -type l -exec rm -rf "{}" +
find ~/config-files/ai/extensions/* -type d -exec rm -rf "{}" + 2>/dev/null

# Link skills to correct paths
ln -s ~/config-files/ai/sources/google-labs-code-stitch-skills/skills/react-components ~/config-files/ai/skills/google-labs-code-stitch-react-components
ln -s ~/config-files/ai/sources/google-labs-code-stitch-skills/skills/enhance-prompt ~/config-files/ai/skills/google-labs-code-stitch-enhance-prompt

ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/cloud-architect ~/config-files/ai/skills/jeffallan-cloud-architect
ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/code-documenter ~/config-files/ai/skills/jeffallan-code-documenter
ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/debugging-wizard ~/config-files/ai/skills/jeffallan-debugging-wizard
ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/fullstack-guardian ~/config-files/ai/skills/jeffallan-fullstack-guardian
ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/javascript-pro ~/config-files/ai/skills/jeffallan-javascript-pro
ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/kotlin-specialist ~/config-files/ai/skills/jeffallan-kotlin-specialist
ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/react-expert ~/config-files/ai/skills/jeffallan-react-expert
ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/the-fool ~/config-files/ai/skills/jeffallan-the-fool
ln -s ~/config-files/ai/sources/jeffallan-claude-skills/skills/typescript-pro ~/config-files/ai/skills/jeffallan-typescript-pro

ln -s ~/config-files/ai/sources/vercel-labs-agent-skills/skills/composition-patterns ~/config-files/ai/skills/vercel-composition-patterns
ln -s ~/config-files/ai/sources/vercel-labs-agent-skills/skills/react-best-practices ~/config-files/ai/skills/vercel-react-best-practices

ln -s ~/config-files/ai/sources/wshobson-agents/plugins/framework-migration/skills/react-modernization ~/config-files/ai/skills/wshobson-react-modernization
ln -s ~/config-files/ai/sources/wshobson-agents/plugins/frontend-mobile-development/skills/tailwind-design-system ~/config-files/ai/skills/wshobson-tailwind-design-system
ln -s ~/config-files/ai/sources/wshobson-agents/plugins/javascript-typescript/skills/javascript-testing-patterns ~/config-files/ai/skills/wshobson-javascript-testing-patterns
ln -s ~/config-files/ai/sources/wshobson-agents/plugins/javascript-typescript/skills/modern-javascript-patterns ~/config-files/ai/skills/wshobson-modern-javascript-patterns
ln -s ~/config-files/ai/sources/wshobson-agents/plugins/javascript-typescript/skills/typescript-advanced-types ~/config-files/ai/skills/wshobson-typescript-advanced-types
ln -s ~/config-files/ai/sources/wshobson-agents/plugins/ui-design/skills/mobile-android-design ~/config-files/ai/skills/wshobson-mobile-android-design


function linkExtension {
  mkdir -p $2

  local jsonContent="{\"type\": \"link\", \"source\": \"$1/\"}"
  echo $jsonContent > $2/.gemini-extension-install.json
}

# Link extensions to correct path
linkExtension ~/config-files/ai/sources/gemini-cli-extn-code-review ~/config-files/ai/extensions/gemini-cli-extn-code-review
linkExtension ~/config-files/ai/sources/gemini-cli-extn-conductor ~/config-files/ai/extensions/gemini-cli-extn-conductor
linkExtension ~/config-files/ai/sources/gemini-cli-extn-security/dist/artifacts ~/config-files/ai/extensions/gemini-cli-extn-security
linkExtension ~/config-files/ai/sources/obra-superpowers ~/config-files/ai/extensions/obra-superpowers
