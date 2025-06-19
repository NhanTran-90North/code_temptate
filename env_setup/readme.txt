=========================================
💻 Development Environment Setup Scripts
=========================================

This project includes scripts to set up your development environment and create a Python virtual environment, with compatibility for both macOS and Windows.

📂 File Overview

- setup_env.sh – Shell script for macOS
- setup_env.ps1 – PowerShell script for Windows
- README.txt – This instruction guide
-------------------------------------------
🧰 What These Scripts Do

Both scripts will:

1. Install essential developer tools (like Python, VS Code, GitHub Desktop)
2. Set up and activate a Python virtual environment
3. Install pip and register the virtual environment for use with Jupyter and VS Code
-------------------------------------------
📦 Output

After completion, you will have:

- A working virtual environment
- Popular development tools installed
- Jupyter-compatible Python kernel registered
- Shortcut instructions on how to activate the venv
-------------------------------------------
🧪 Verify Installation

To activate your environment later:

- macOS: source venv/bin/activate
- Windows: .\venv\Scripts\Activate.ps1

To launch VS Code: code .
To check Python version: python --version

===============================
**** 🖥️ macOS Instructions ****
===============================

✅ Prerequisites:
- macOS Terminal
- Admin privileges (for installing Homebrew and apps)

▶️ How to Run:

bash setup_env.sh [venv_name]

- Replace [venv_name] with the name of your desired virtual environment.
- If not provided, defaults to venv.

💡 Notes:
- Installs: Homebrew, Python 3, VS Code, GitHub Desktop, TextMate, 7-Zip
- Adds alias python="python3" to your shell profile (.zshrc or .bash_profile)
- Activates the environment and registers it as a Jupyter kernel

=================================
**** 🪟 Windows Instructions ****
=================================

✅ Prerequisites:
- PowerShell (run as Administrator is recommended)
- Internet access

▶️ How to Run:

.\setup_env.ps1 -VenvName "myvenv"

- Replace "myvenv" with your preferred virtual environment name.
- If not provided, it will default to venv.

💡 Notes:
- Uses Windows Package Manager winget to install VS Code, GitHub Desktop, Python, Notepad++, and 7-Zip
- Creates a Python virtual environment using python -m venv
- Installs pip, upgrades it, and sets up a Jupyter-compatible kernel
