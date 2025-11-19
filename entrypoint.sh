#!/bin/bash
set -e

# Inputs
YAML_PATH="$1"
JSON_PATH="$2"
GIT_USERNAME="$3"
GIT_EMAIL="$4"
COMMIT_MESSAGE="$5"

# Default commit message
COMMIT_MESSAGE="${COMMIT_MESSAGE:-Update JSON from YAML}"

# Install Node & swagger-cli (Ubuntu runner assumed)
echo "Installing swagger-cli..."
npm install -g swagger-cli

# Convert YAML to JSON
echo "Converting YAML to JSON..."
swagger-cli bundle "$YAML_PATH" -o "$JSON_PATH" -t json

# Commit & push if there are changes
echo "Committing changes..."
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git add "$JSON_PATH"
if ! git diff-index --quiet HEAD; then
    git commit -m "$COMMIT_MESSAGE"
    git push
else
    echo "No changes detected. Skipping commit."
fi
