
Comprehensive Python Development Environment Setup Guide (Windows & macOS)
============================================================================

1. Install Package Management Tools, VS Code, Python, and Upgrade pip
---------------------------------------------------------------------

🪟 For Windows:
---------------
Run: setup_win_dev_env.cmd OR setup_win_dev_env.ps1

Steps Performed:
- Installs Chocolatey (Windows package manager)
- Installs Visual Studio Code
- Installs Python 3
- Upgrades pip

How to Run:
-----------
Option A: Using Command Prompt (CMD)
- Right-click on 'setup_win_dev_env.cmd' and choose 'Run as Administrator'

Option B: Using PowerShell
- Open PowerShell as Administrator
- Run:
    Set-ExecutionPolicy Bypass -Scope Process -Force
    .\setup_win_dev_env.ps1


🍎 For macOS:
-------------
Run: setup_mac_dev_env.sh

Steps Performed:
- Installs Homebrew (macOS package manager)
- Installs Visual Studio Code via Homebrew
- Installs latest Python 3 via Homebrew
- Upgrades pip
- Adds python3 alias if needed

How to Run:
-----------
chmod +x setup_mac_dev_env.sh
./setup_mac_dev_env.sh


2. Set Up a Python Virtual Environment
--------------------------------------
Create and configure your Python venv using one of the following scripts.
Note: myenv is a suggested name for the new code environment. Can be changed to a desired name or remove it and venv will be used as the default name instead.

Ensure the .cmd or .sh file is in the open folder within VS Code by navigating to the folder that contains the script file.

🪟 For Windows:
---------------
Open the CMD terminal in VSCode:
    - Press Ctrl + (backtick) or go to View → Terminal
    - Make sure the terminal is using Command Prompt
      If it's not, click the dropdown (v) in the terminal tab and choose "Select Default Profile" → Command Prompt
Run Command:
    {your\path}\create_venv.cmd myenv

** Change the {your\path} to the actual path where cmd file is stored.

🍎 For macOS/Linux:
-------------------
Open the terminal in VSCode:
    - From the dropdown menu, select 'Terminal' > 'New Terminal'
Run Command:
    chmod +x {your/path}/create_venv.sh
    {your/path}/create_venv.sh myenv

** Change the {your/path} to the actual path where cmd file is stored.

What it does:
- Creates a virtual environment
- Use the latest available Python to create a virtual environment
- Activates the environment
- Installs ipykernel for Jupyter use
- Registers the kernel as "Python (myenv)" for use in notebooks
- Optionally accepts packages to install: e.g. ./create_venv.sh myenv numpy pandas


3. Install Python Libraries via Jupyter Notebook
----------------------------------------------------------
Use the newly created virtual environment from step 2 and the provided `vscode_python_setup.ipynb` notebook to install required packages.

A. Open the notebook file: vscode_python_setup.ipynb

B. At the top-right of the notebook interface:
    - Click the kernel picker
    - Select: Python (myenv)

C. Run all the cells in the notebook.



✅ You're Ready!
--------------
- Fully functional Python environment
- Jupyter notebook compatibility in VS Code
- Isolated project dependencies
- Easy reproducibility and package management

