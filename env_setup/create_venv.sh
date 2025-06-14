#!/bin/bash

# === CONFIG ===
VENV_NAME=${1:-venv}  # Default name is 'venv' if none provided

# === CREATE VENV ===
PYTHON=$(which -a python3 | head -n1)
echo "📦 Using Python: $PYTHON"
$PYTHON -m venv "$VENV_NAME"

# === ACTIVATE ===
source "$VENV_NAME/bin/activate"
echo "✅ Virtual environment '$VENV_NAME' activated."

# === INSTALL ===
pip install --upgrade pip ipykernel
python -m ipykernel install --user --name "$VENV_NAME" --display-name "Python ($VENV_NAME)"

echo "✅ Kernel 'Python ($VENV_NAME)' registered for Jupyter/VS Code."
