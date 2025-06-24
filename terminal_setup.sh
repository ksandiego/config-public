#!/bin/bash

set -euo pipefail

echo "🔧 Installing Ghostty (Terminal replacement)..."
brew install --cask ghostty

echo "🐟 Installing fish shell..."
brew install fish

FISH_PATH="$(which fish)"

if ! grep -Fxq "$FISH_PATH" /etc/shells; then
  echo "📄 Adding fish to allowed shells..."
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

fish_add_path /opt/homebrew/bin

echo "🔁 Changing default shell to fish for user: $USER"
chsh -s "$FISH_PATH"

echo "🌟 Installing Starship prompt..."
brew install starship

echo "⚙️  Configuring Starship for fish..."
mkdir -p ~/.config/fish
if ! grep -q 'starship init fish' ~/.config/fish/config.fish 2>/dev/null; then
  echo 'starship init fish | source' >> ~/.config/fish/config.fish
fi

echo "✅ Setup complete!"
echo "➡️  Launch Ghostty from Spotlight or by typing 'ghostty'"
echo "➡️  Fish is now your default shell with Starship as your prompt."