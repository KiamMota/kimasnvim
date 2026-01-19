#!/bin/sh
set -e

REPO_URL="https://github.com/KiamMota/kimasnvim.git"
NVIM_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/old_nvim_config"

fail() {
  echo "!! error: $1" >&2
  exit 1
}

command -v git >/dev/null 2>&1 || fail "git not found"

# backup se já existir config
if [ -e "$NVIM_DIR" ]; then
  echo ">> existing nvim config detected"
  mkdir -p "$BACKUP_DIR"

  TS="$(date +%Y%m%d-%H%M%S)"
  mv "$NVIM_DIR" "$BACKUP_DIR/nvim-$TS" \
    || fail "failed to move existing nvim config"

  echo ">> moved old config to $BACKUP_DIR/nvim-$TS"
fi

echo ">> installing KIMASNVIM"
git clone "$REPO_URL" "$NVIM_DIR" || fail "git clone failed"

EXEC="$NVIM_DIR/exec.sh"
[ -f "$EXEC" ] || fail "exec.sh not found in repo root"
chmod +x "$EXEC" || fail "failed to chmod exec.sh"


cat <<'EOF'
wellcome to

 █        ▀                                         ▀          
 █   ▄  ▄▄▄    ▄▄▄▄▄   ▄▄▄    ▄▄▄   ▄ ▄▄   ▄   ▄  ▄▄▄    ▄▄▄▄▄ 
 █ ▄▀     █    █ █ █  ▀   █  █   ▀  █▀  █  ▀▄ ▄▀    █    █ █ █ 
 █▀█      █    █ █ █  ▄▀▀▀█   ▀▀▀▄  █   █   █▄█     █    █ █ █ 
 █  ▀▄  ▄▄█▄▄  █ █ █  ▀▄▄▀█  ▀▄▄▄▀  █   █    █    ▄▄█▄▄  █ █ █ 

EOF

echo ">> KIMASNVIM ready"
