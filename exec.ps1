#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

# colors
$RED    = "`e[31m"
$GREEN  = "`e[32m"
$YELLOW = "`e[33m"
$BLUE   = "`e[34m"
$NC     = "`e[0m"

$REPO_URL   = "https://github.com/KiamMota/kimasnvim.git"
$NVIM_DIR   = "$HOME\.config\nvim"
$BACKUP_DIR = "$HOME\.config\old_nvim_config"

function Fail($msg) {
    Write-Error "$RED!! error:$NC $msg"
    exit 1
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Fail "git not found"
}

if (Test-Path $NVIM_DIR) {
    Write-Host "$YELLOW>> existing nvim config detected$NC"
    New-Item -ItemType Directory -Force -Path $BACKUP_DIR | Out-Null

    $TS = Get-Date -Format "yyyyMMdd-HHmmss"
    $DEST = Join-Path $BACKUP_DIR "nvim-$TS"

    Move-Item $NVIM_DIR $DEST -ErrorAction Stop
    Write-Host "$BLUE>> moved old config to $DEST$NC"
}

Write-Host "$BLUE>> installing KIMASNVIM$NC"
git clone $REPO_URL $NVIM_DIR | Out-Null

$EXEC = Join-Path $NVIM_DIR "exec.sh"
if (-not (Test-Path $EXEC)) {
    Fail "exec.sh not found in repo root"
}

Write-Host @"
$GREEN
wellcome to

 █        ▀                                         ▀          
 █   ▄  ▄▄▄    ▄▄▄▄▄   ▄▄▄    ▄▄▄   ▄ ▄▄   ▄   ▄  ▄▄▄    ▄▄▄▄▄ 
 █ ▄▀     █    █ █ █  ▀   █  █   ▀  █▀  █  ▀▄ ▄▀    █    █ █ █ 
 █▀█      █    █ █ █  ▄▀▀▀█   ▀▀▀▄  █   █   █▄█     █    █ █ █ 
 █  ▀▄  ▄▄█▄▄  █ █ █  ▀▄▄▀█  ▀▄▄▄▀  █   █    █    ▄▄█▄▄  █ █ █ 

$NC
"@

Write-Host "$GREEN>> KIMASNVIM ready$NC"
