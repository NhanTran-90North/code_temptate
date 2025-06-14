@echo off
echo 🔧 Starting Windows development environment setup...

:: Install Chocolatey (if not installed)
where choco >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo 🍫 Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
     "Set-ExecutionPolicy Bypass -Scope Process; ^
      [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ^
      iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
) else (
    echo ✅ Chocolatey already installed.
)

:: Refresh environment
refreshenv >nul 2>nul

:: Install Visual Studio Code
echo 🧰 Installing Visual Studio Code...
choco install -y vscode

:: Install Python
echo 🐍 Installing Python...
choco install -y python

:: Upgrade pip
echo 📦 Upgrading pip...
python -m pip install --upgrade pip

:: Add python alias (Python installer usually handles this)
echo ✅ Python should be available as 'python' and 'pip'

echo ✅ Windows development environment setup complete.
pause
