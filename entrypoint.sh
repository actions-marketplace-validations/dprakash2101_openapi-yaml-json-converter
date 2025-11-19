#!/bin/bash
set -e

# ---------------------------
# Inputs
# ---------------------------
YAML_PATH="$1"
JSON_PATH="$2"
GIT_USERNAME="$3"
GIT_EMAIL="$4"
COMMIT_MESSAGE="$5"

# Default commit message
COMMIT_MESSAGE="${COMMIT_MESSAGE:-Update JSON from YAML}"

# ---------------------------
# Install OpenAPI Generator
# ---------------------------
echo "Installing OpenAPI Generator CLI..."
npm install -g @openapitools/openapi-generator-cli@latest

# ---------------------------
# Convert YAML to JSON
# ---------------------------
echo "Converting YAML ($YAML_PATH) to JSON ($JSON_PATH)..."
openapi-generator-cli generate \
  -i "$YAML_PATH" \
  -o temp_json_dir \
  -g json

# Move generated JSON to target path
mkdir -p "$(dirname "$JSON_PATH")"
mv temp_json_dir/* "$JSON_PATH"
rm -rf temp_json_dir

# ---------------------------
# Commit & Push Changes
# ---------------------------
echo "Configuring Git..."
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"

echo "Checking for changes..."
git add "$JSON_PATH"

if ! git diff-index --quiet HEAD; then
    echo "Changes detected. Committing..."
    git commit -m "$COMMIT_MESSAGE"
    git push
else
    echo "No changes detected. Skipping commit."
fi
