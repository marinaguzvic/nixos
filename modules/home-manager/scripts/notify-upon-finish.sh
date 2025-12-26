#!/usr/bin/env bash

# Check if a command was provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <command>"
  exit 1
fi

# Run the command
"$@"
exit_code=$?

# Determine success or failure
if [ $exit_code -eq 0 ]; then
  notify-send "✅ Command Finished" "'$*' completed successfully."
else
  notify-send "❌ Command Failed" "'$*' exited with code $exit_code."
fi

exit $exit_code


