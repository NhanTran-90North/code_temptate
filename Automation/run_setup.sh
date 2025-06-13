#!/bin/bash

# Get the directory of the current script (this works when called via symlink or app bundle)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Run the two setup scripts
bash "$SCRIPT_DIR/setup_mac_dev_env.sh"
bash "$SCRIPT_DIR/setup_vscode_project.sh"
