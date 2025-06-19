#!/bin/bash

echo "🔧 Starting macOS development environment setup..."

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed"
fi

# Update and upgrade Homebrew
echo "🔄 Updating Homebrew..."
brew update

# Install VS Code
echo "🧰 Installing Visual Studio Code..."
brew install --cask visual-studio-code

# Install latest Python
echo "🐍 Installing Python..."
brew install python

# Install TextMate
echo "📝 Installing TextMate..."
brew install --cask textmate

# Install 7-Zip
echo "📦 Installing 7-Zip..."
brew install p7zip

# Upgrade pip
echo "📦 Upgrading pip..."
pip3 install --upgrade pip

# Alias python to python3 in shell config
SHELL_RC=""
if [[ "$SHELL" == *"zsh" ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash" ]]; then
  SHELL_RC="$HOME/.bash_profile"
else
  SHELL_RC="$HOME/.profile"
fi

if ! grep -q 'alias python="python3"' "$SHELL_RC"; then
  echo 'alias python="python3"' >> "$SHELL_RC"
  echo "🔗 Added alias 'python=python3' to $SHELL_RC"
else
  echo "✅ Alias already set in $SHELL_RC"
fi

# Source the shell config
source "$SHELL_RC"

echo "✅ Setup complete. You may need to restart your terminal to apply all changes."
