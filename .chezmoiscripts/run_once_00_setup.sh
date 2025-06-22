#!/bin/bash
set -euo pipefail

# 最小限の依存関係のみインストール
if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y curl git build-essential || true
fi

# Miseのパスを通す
export PATH="$HOME/.local/bin:$PATH"

# Oh My Zsh（オプション）
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
fi