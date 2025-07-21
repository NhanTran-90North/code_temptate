#!/bin/bash

# Ensure the 'code' command is available
if ! command -v code &> /dev/null
then
    echo "VS Code 'code' command not found. Launch VS Code and press Cmd+Shift+P -> type 'Shell Command: Install 'code' command in PATH'"
    exit 1
fi

# List of VS Code extensions to install for Python development and documentation
extensions=(
  # Data science
  ms-toolsai.jupyter                 # Core Jupyter notebook support
  ms-toolsai.jupyter-keymap
  ms-toolsai.jupyter-renderers
  ms-toolsai.vscode-jupyter-cell-tags
  ms-toolsai.vscode-jupyter-slideshow
  GrapeCity.gc-excelviewer

  # Code runners & formatters
  ms-python.python                   # Core Python support
  ms-python.vscode-pylance           # Fast, feature-rich language server
  ms-python.black-formatter          # PEP8 autoformatter
  ms-python.isort                    # Import sorting
  ms-python.flake8                   # Lightweight linter
  ms-python.pylint                   # Deep static analysis
  njpwerner.autodocstring            # Auto-generate docstrings

  # Documentation & Markdown
  yzhang.markdown-all-in-one         # Markdown utilities
  shd101wyy.markdown-preview-enhanced # Live enhanced markdown preview

  # Productivity & Collaboration
  eamodio.gitlens                    # Git history and insights
  ms-vsliveshare.vsliveshare         # Real-time collaboration
  github.vscode-pull-request-github  # GitHub PR integration
  streetsidesoftware.code-spell-checker  # Spell checker

  # AI & IntelliCode
  visualstudioexptteam.vscodeintellicode
  github.copilot
  github.copilot-chat
)

echo "Installing VS Code extensions for Python and documentation..."

for extension in "${extensions[@]}"; do
  echo "Installing: $extension"
  code --install-extension "$extension" --force
done

echo "✅ All extensions installed successfully."
