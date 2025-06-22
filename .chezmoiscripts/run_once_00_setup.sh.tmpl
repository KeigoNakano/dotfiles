#!/bin/bash
set -euo pipefail

{{ if eq .chezmoi.os "linux" -}}
  {{ if or (eq .chezmoi.osRelease.id "ubuntu") (eq .chezmoi.osRelease.id "debian") -}}
echo "📦 Installing packages for Ubuntu/Debian..."
sudo apt-get update || apt-get update
sudo apt-get install -y zsh git curl build-essential || \
     apt-get install -y zsh git curl build-essential
  {{ else if eq .chezmoi.osRelease.id "fedora" -}}
echo "📦 Installing packages for Fedora..."
sudo dnf install -y zsh git curl gcc-c++ make
  {{ end -}}
{{ else if eq .chezmoi.os "darwin" -}}
echo "📦 Installing packages for macOS..."
if command -v brew >/dev/null 2>&1; then
    brew install zsh git curl
fi
{{ end -}}

# Miseのパスを通す
export PATH="$HOME/.local/bin:$PATH"

# Oh My Zsh（すべてのOSで共通）
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
fi