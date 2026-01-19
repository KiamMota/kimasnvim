#!/bin/sh

set -e

REPO_URL="https://github.com/KiamMota/kimasnvim.git"
NVIM_DIR="$HOME/.config/nvim"

fail() {
  echo "!! error: $1"
  exit 1
}

command -v git >/dev/null 2>&1 || fail "git not found"

if [ -d "$NVIM_DIR/.git" ]; then
  cd "$NVIM_DIR" || fail "cannot access $NVIM_DIR"

  CURRENT_URL=$(git remote get-url origin 2>/dev/null || true)
  [ "$CURRENT_URL" = "$REPO_URL" ] || fail "existing repo is not KIMASNVIM"

  if ! git diff --quiet || ! git diff --cached --quiet; then
    fail "local changes detected, aborting pull"
  fi

  echo ">> KIMASNVIM already exists"
  echo ">> pulling latest changes"
  git pull --ff-only || fail "git pull failed"
else
  echo ">> installing KIMASNVIM"

  if [ -e "$NVIM_DIR" ]; then
    fail "$NVIM_DIR exists but is not a git repo"
  fi

  git clone "$REPO_URL" "$NVIM_DIR" || fail "git clone failed"
fi

clear

cat <<'EOF'
wellcome to

 █        ▀                                         ▀          
 █   ▄  ▄▄▄    ▄▄▄▄▄   ▄▄▄    ▄▄▄   ▄ ▄▄   ▄   ▄  ▄▄▄    ▄▄▄▄▄ 
 █ ▄▀     █    █ █ █  ▀   █  █   ▀  █▀  █  ▀▄ ▄▀    █    █ █ █ 
 █▀█      █    █ █ █  ▄▀▀▀█   ▀▀▀▄  █   █   █▄█     █    █ █ █ 
 █  ▀▄  ▄▄█▄▄  █ █ █  ▀▄▄▀█  ▀▄▄▄▀  █   █    █    ▄▄█▄▄  █ █ █ 

EOF

echo ">> KIMASNVIM ready"
