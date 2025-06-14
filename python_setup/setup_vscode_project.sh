#!/bin/bash

echo "📁 Setting up Python project with VS Code support..."

# Step 1: Create .venv in current directory
if [ ! -d ".venv" ]; then
  echo "🐍 Creating Python virtual environment (.venv)..."
  python3 -m venv .venv
else
  echo "✅ .venv already exists"
fi

# Step 2: Activate and upgrade pip inside .venv
echo "📦 Upgrading pip inside .venv..."
source .venv/bin/activate
pip install --upgrade pip
deactivate

# Step 3: Create .vscode/settings.json for VS Code Python interpreter
mkdir -p .vscode
cat > .vscode/settings.json <<EOF
{
  "python.pythonPath": "\${workspaceFolder}/.venv/bin/python",
  "jupyter.jupyterServerType": "local"
}
EOF
echo "⚙️ VS Code settings created for Python interpreter"

# Step 4: Install VS Code extensions
echo "🧩 Installing VS Code extensions..."

code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension Ikuyadeu.r

echo "✅ VS Code extensions installed: Python, Jupyter, R"

echo "🎉 Project setup complete. Open this folder in VS Code and select the Python interpreter: .venv/bin/python"
