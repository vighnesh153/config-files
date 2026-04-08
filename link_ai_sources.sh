#!/bin/zsh

set -e

# Delete existing symlinks
find ~/config-files/skills -type l -delete
find ~/config-files/extensions -type d -delete

# Link skills to correct paths
ln -s ~/config-files/ai/google-labs-code-stitch-skills/skills/react-components ~/config-files/skills/google-labs-code-stitch-react-components
ln -s ~/config-files/ai/google-labs-code-stitch-skills/skills/enhance-prompt ~/config-files/skills/google-labs-code-stitch-enhance-prompt

ln -s ~/config-files/ai/jeffallan-claude-skills/skills/cloud-architect ~/config-files/skills/jeffallan-cloud-architect
ln -s ~/config-files/ai/jeffallan-claude-skills/skills/code-documenter ~/config-files/skills/jeffallan-code-documenter
ln -s ~/config-files/ai/jeffallan-claude-skills/skills/debugging-wizard ~/config-files/skills/jeffallan-debugging-wizard
ln -s ~/config-files/ai/jeffallan-claude-skills/skills/fullstack-guardian ~/config-files/skills/jeffallan-fullstack-guardian
ln -s ~/config-files/ai/jeffallan-claude-skills/skills/javascript-pro ~/config-files/skills/jeffallan-javascript-pro
ln -s ~/config-files/ai/jeffallan-claude-skills/skills/kotlin-specialist ~/config-files/skills/jeffallan-kotlin-specialist
ln -s ~/config-files/ai/jeffallan-claude-skills/skills/react-expert ~/config-files/skills/jeffallan-react-expert
ln -s ~/config-files/ai/jeffallan-claude-skills/skills/the-fool ~/config-files/skills/jeffallan-the-fool
ln -s ~/config-files/ai/jeffallan-claude-skills/skills/typescript-pro ~/config-files/skills/jeffallan-typescript-pro

ln -s ~/config-files/ai/vercel-labs-agent-skills/skills/composition-patterns ~/config-files/skills/vercel-composition-patterns
ln -s ~/config-files/ai/vercel-labs-agent-skills/skills/react-best-practices ~/config-files/skills/vercel-react-best-practices

ln -s ~/config-files/ai/wshobson-agents/plugins/framework-migration/skills/react-modernization ~/config-files/skills/wshobson-react-modernization
ln -s ~/config-files/ai/wshobson-agents/plugins/frontend-mobile-development/skills/tailwind-design-system ~/config-files/skills/wshobson-tailwind-design-system
ln -s ~/config-files/ai/wshobson-agents/plugins/javascript-typescript/skills/javascript-testing-patterns ~/config-files/skills/wshobson-javascript-testing-patterns
ln -s ~/config-files/ai/wshobson-agents/plugins/javascript-typescript/skills/modern-javascript-patterns ~/config-files/skills/wshobson-modern-javascript-patterns
ln -s ~/config-files/ai/wshobson-agents/plugins/javascript-typescript/skills/typescript-advanced-types ~/config-files/skills/wshobson-typescript-advanced-types
ln -s ~/config-files/ai/wshobson-agents/plugins/ui-design/skills/mobile-android-design ~/config-files/skills/wshobson-mobile-android-design


function linkExtension {
  mkdir -p $2

  local jsonContent="{\"type\": \"link\", \"source\": \"$1/\"}"
  echo $jsonContent > $2/.gemini-extension-install.json
}

# Link extensions to correct path
linkExtension ~/config-files/ai/gemini-cli-extn-code-review ~/config-files/extensions/gemini-cli-extn-code-review
linkExtension ~/config-files/ai/gemini-cli-extn-conductor ~/config-files/extensions/gemini-cli-extn-conductor
linkExtension ~/config-files/ai/gemini-cli-extn-security/dist/artifacts ~/config-files/extensions/gemini-cli-extn-security
linkExtension ~/config-files/ai/obra-superpowers ~/config-files/extensions/obra-superpowers
