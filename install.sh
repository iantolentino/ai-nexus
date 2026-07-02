#!/usr/bin/env bash
# AI Nexus — installer / updater (Mac, Linux, WSL, Git Bash).
#
# Run from your project's root directory:
#   curl -fsSL https://raw.githubusercontent.com/iantolentino/ai-nexus/main/install.sh | bash
# or download this file into your project root and run: bash install.sh
#
# - If _brain/ does not exist yet: installs it fresh.
# - If _brain/ already exists: updates framework files only, never touches project data.
#   See _brain/templates/update_rules.md for the exact split.
# - Also drops root-level pointer files (CLAUDE.md, AGENTS.md, .cursorrules, .windsurfrules,
#   .github/copilot-instructions.md) so any AI tool auto-loads instructions to read
#   _brain/claude.md first — only where none already exists.

set -euo pipefail

REPO="https://github.com/iantolentino/ai-nexus.git"
TARGET="_brain"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

if ! command -v git >/dev/null 2>&1; then
  echo "git is required and was not found on PATH." >&2
  exit 1
fi

echo "AI Nexus installer"
echo "Cloning framework..."
git clone --depth 1 "$REPO" "$TMP_DIR" >/dev/null 2>&1

if [ -d "$TARGET" ]; then
  echo "_brain/ already exists — updating framework files only (project data untouched)."
  FRAMEWORK_PATHS=(
    "claude.md" "aibrain.md" "INDEX.md" "prompts" "governance" "interaction"
    "tasks/task_rules.md" "tasks/task_templates.md" "templates"
    "fixes/README.md" "fixes/_template.md" "quick-ref/README.md"
  )
  for path in "${FRAMEWORK_PATHS[@]}"; do
    src="$TMP_DIR/_brain/$path"
    dest="$TARGET/$path"
    if [ -e "$src" ]; then
      mkdir -p "$(dirname "$dest")"
      cp -rf "$src" "$dest"
      echo "  updated: $path"
    fi
  done
else
  echo "Installing fresh _brain/ ..."
  cp -r "$TMP_DIR/_brain" "$TARGET"
fi

echo "Installing AI-tool entry points (only where none already exist)..."
ENTRY_SRC_NAMES=("CLAUDE.md" "AGENTS.md" ".cursorrules" ".windsurfrules" "copilot-instructions.md")
ENTRY_DEST_PATHS=("CLAUDE.md" "AGENTS.md" ".cursorrules" ".windsurfrules" ".github/copilot-instructions.md")
ENTRY_SRC_DIR="$TMP_DIR/_brain/templates/entrypoints"

for i in "${!ENTRY_SRC_NAMES[@]}"; do
  src_name="${ENTRY_SRC_NAMES[$i]}"
  dest_path="${ENTRY_DEST_PATHS[$i]}"
  if [ -f "$dest_path" ]; then
    echo "  skipped $dest_path (already exists) — add this line manually: \"Read _brain/claude.md in full before doing anything else.\""
  else
    mkdir -p "$(dirname "$dest_path")"
    cp "$ENTRY_SRC_DIR/$src_name" "$dest_path"
    echo "  created: $dest_path"
  fi
done

echo ""
echo "Done. _brain/ is ready."
echo "Next: paste _brain/prompts/bootstrap_prompt.md into a new AI chat session to start."
