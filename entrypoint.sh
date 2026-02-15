#!/bin/sh
set -e

# Generate config.json from environment variables at container startup
cat > /root/.picoclaw/config.json <<EOCFG
{
  "agents": {
    "defaults": {
      "workspace": "~/.picoclaw/workspace",
      "model": "${LLM_MODEL:-glm-4.7}",
      "max_tokens": 8192,
      "temperature": 0.7,
      "max_tool_iterations": 20
    }
  },
  "channels": {
    "discord": {
      "enabled": true,
      "token": "${DISCORD_TOKEN}",
      "allow_from": []
    }
  },
  "providers": {
    "${LLM_PROVIDER:-openrouter}": {
      "api_key": "${LLM_API_KEY}"
    }
  },
  "tools": {
    "web": {
      "duckduckgo": {
        "enabled": true,
        "max_results": 5
      }
    }
  },
  "heartbeat": {
    "enabled": true,
    "interval": 30
  }
}
EOCFG

exec picoclaw gateway
