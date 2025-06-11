#!/usr/bin/env bash

if ! env | grep -q OP_SESSION_; then
  echo "🔐 Not signed in to 1Password. Starting interactive login..."
  eval "$(op signin)" || {
    echo "❌ Failed to sign in to 1Password"
    exit 1
  }
fi

export GEMINI_API_KEY=$(op read "op://Private/CloudAfrica Gmail/gemini-api-key" 2>/dev/null)

if [ -z "$GEMINI_API_KEY" ]; then
  echo "❌ Failed to retrieve GEMINI_API_KEY from 1Password"
  exit 1
fi

exec nvim "$@"

