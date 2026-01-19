#!/bin/sh

set -e

REPO_URL="https://github.com/KiamMota/kimasnvim.git"
NVIM_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_DIR/.git" ]; then
  echo ">> KIMASNVIM already exists"
  echo ">> pulling latest changes"
  cd "$NVIM_DIR"
  git pull --ff-only
else
  echo ">> installing KIMASNVIM"
  rm -rf "$NVIM_DIR"
  git clone "$REPO_URL" "$NVIM_DIR"
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
