#!/bin/bash

# ================================
# 🔧 SETUP AND CREATE PYTHON VENV
# ================================

# This script is intended for macOS systems and will:
# 1. Setup your macOS development environment (Homebrew, VS Code, Github Desktop, Python, etc.)
# 2. Install pip and register a Jupyter kernel
# 3. Install Python data science libraries
# 4. Install VS Code extensions for Python and documentation

# USAGE:
# Run from terminal: bash setup_and_create_venv.sh [venv_name]
# If no [venv_name] is provided, it defaults to "venv"

# ====================
# STEP 1: Setup Mac OS
# ====================

echo "🔧 Running macOS development environment setup..."

# Install Homebrew if needed
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew is already installed."
fi

echo "🔄 Updating Homebrew..."
brew update

echo "🧰 Installing Visual Studio Code..."
brew install --cask visual-studio-code

echo "🐙 Installing GitHub Desktop..."
brew install --cask github

echo "🐍 Installing Python..."
brew install python

echo "📝 Installing TextMate..."
brew install --cask textmate

echo "📦 Installing 7-Zip..."
brew install p7zip

echo "📦 Upgrading pip..."
pip3 install --upgrade pip

# Add alias for python3 as 'python'
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
  echo "✅ Alias already exists in $SHELL_RC"
fi

source "$SHELL_RC"

echo "✅ macOS setup completed."

# =================================
# STEP 2: Create Python Virtual Env
# =================================

# Get VENV name from argument or default to 'venv'
VENV_NAME=${1:-venv}
echo "📦 Creating Python virtual environment: $VENV_NAME"

PYTHON=$(which -a python3 | head -n1)
echo "📍 Using Python at: $PYTHON"

$PYTHON -m venv "$VENV_NAME"
source "$VENV_NAME/bin/activate"

echo "✅ Virtual environment '$VENV_NAME' activated."

echo "📦 Installing kernel tools in venv..."
pip install --upgrade pip ipykernel
python -m ipykernel install --user --name "$VENV_NAME" --display-name "Python ($VENV_NAME)"

echo "✅ Kernel 'Python ($VENV_NAME)' is registered for Jupyter or VS Code use."

# ===================================
# STEP 3: Install Python DS Libraries
# ===================================
echo "📦 Installing Python data science libraries in virtual environment..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -f "$SCRIPT_DIR/vscode_python_setup.py" ]; then
  python "$SCRIPT_DIR/vscode_python_setup.py"
  echo "✅ vscode_python_setup.py executed successfully."
else
  echo "⚠️  vscode_python_setup.py not found in $SCRIPT_DIR. Skipping step 3."
fi

# ===================================
# STEP 4: Install VS Code Extensions
# ===================================
if [ -f "./install_vscode_ds_extensions.sh" ]; then
    echo "🔧 Installing VS Code extensions for Python and documentation..."
    chmod +x ./install_vscode_ds_extensions.sh
    ./install_vscode_ds_extensions.sh
else
    echo "⚠️ install_vscode_ds_extensions.sh not found. Skipping extension installation."
fi

# ============
# 🎉 All Done!
# ============
echo "🎉 Development setup and virtual environment creation complete."
echo "📂 To activate the environment again, run: source $VENV_NAME/bin/activate"
