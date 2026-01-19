#!/bin/sh
set -e

# colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_URL="https://github.com/KiamMota/kimasnvim.git"
NVIM_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/old_nvim_config"

fail() {
  echo "${RED}!! error:${NC} $1" >&2
  exit 1
}

command -v git >/dev/null 2>&1 || fail "git not found"

if [ -e "$NVIM_DIR" ]; then
  echo "${YELLOW}>> existing nvim config detected${NC}"
  mkdir -p "$BACKUP_DIR"

  TS="$(date +%Y%m%d-%H%M%S)"
  mv "$NVIM_DIR" "$BACKUP_DIR/nvim-$TS" \
    || fail "failed to move existing nvim config"

  echo "${BLUE}>> moved old config to $BACKUP_DIR/nvim-$TS${NC}"
fi

echo "${BLUE}>> installing KIMASNVIM${NC}"
git clone "$REPO_URL" "$NVIM_DIR" || fail "git clone failed"

EXEC="$NVIM_DIR/exec.sh"
[ -f "$EXEC" ] || fail "exec.sh not found in repo root"
chmod +x "$EXEC" || fail "failed to chmod exec.sh"

cat <<'EOF'
[0;32m
wellcome to

 █        ▀                                         ▀          
 █   ▄  ▄▄▄    ▄▄▄▄▄   ▄▄▄    ▄▄▄   ▄ ▄▄   ▄   ▄  ▄▄▄    ▄▄▄▄▄ 
 █ ▄▀     █    █ █ █  ▀   █  █   ▀  █▀  █  ▀▄ ▄▀    █    █ █ █ 
 █▀█      █    █ █ █  ▄▀▀▀█   ▀▀▀▄  █   █   █▄█     █    █ █ █ 
 █  ▀▄  ▄▄█▄▄  █ █ █  ▀▄▄▀█  ▀▄▄▄▀  █   █    █    ▄▄█▄▄  █ █ █ 

[0m
EOF

echo "${GREEN}>> KIMASNVIM ready${NC}"
