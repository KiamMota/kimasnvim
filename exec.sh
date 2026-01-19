#!/bin/sh
set -e

REPO_URL="https://github.com/KiamMota/kimasnvim.git"
APP_NAME="kimasnvim"
BASE_DIR="$HOME/.config"
TARGET_DIR="$BASE_DIR/$APP_NAME"
LEGACY_NVIM="$BASE_DIR/nvim"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

fail() {
  echo "!! error: $1" >&2
  exit 1
}

info() {
  echo ">> $1"
}

command -v git >/dev/null 2>&1 || fail "git not found"

info "using NVIM_APPNAME=$APP_NAME"
info "target dir: $TARGET_DIR"

# instalação paralela (default)
if [ -d "$TARGET_DIR/.git" ]; then
  cd "$TARGET_DIR" || fail "cannot access $TARGET_DIR"

  if ! git diff --quiet || ! git diff --cached --quiet; then
    fail "local changes detected in $TARGET_DIR"
  fi

  info "existing install found, pulling updates"
  git pull --ff-only || fail "git pull failed"
else
  if [ -e "$TARGET_DIR" ]; then
    fail "$TARGET_DIR exists but is not a git repo"
  fi

  info "cloning KIMASNVIM"
  git clone "$REPO_URL" "$TARGET_DIR" || fail "git clone failed"
fi

# aviso sobre nvim legado
if [ -d "$LEGACY_NVIM" ]; then
  info "legacy ~/.config/nvim detected"
  info "it will NOT be touched"
  info "run with: NVIM_APPNAME=$APP_NAME nvim"
fi

cat <<'EOF'

 █        ▀                                         ▀          
 █   ▄  ▄▄▄    ▄▄▄▄▄   ▄▄▄    ▄▄▄   ▄ ▄▄   ▄   ▄  ▄▄▄    ▄▄▄▄▄ 
 █ ▄▀     █    █ █ █  ▀   █  █   ▀  █▀  █  ▀▄ ▄▀    █    █ █ █ 
 █▀█      █    █ █ █  ▄▀▀▀█   ▀▀▀▄  █   █   █▄█     █    █ █ █ 
 █  ▀▄  ▄▄█▄▄  █ █ █  ▀▄▄▀█  ▀▄▄▄▀  █   █    █    ▄▄█▄▄  █ █ █ 

EOF

info "KIMASNVIM ready"
info "launch with: NVIM_APPNAME=$APP_NAME nvim"
