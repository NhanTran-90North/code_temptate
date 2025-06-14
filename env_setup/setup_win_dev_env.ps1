Write-Host "🔧 Starting Windows development environment setup..."

# --- Install Chocolatey if missing ---
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "🍫 Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "✅ Chocolatey already installed"
}

# --- Install Visual Studio Code ---
Write-Host "🧰 Installing Visual Studio Code..."
choco install vscode -y

# --- Install Python ---
Write-Host "🐍 Installing Python..."
choco install python -y

# --- Upgrade pip ---
Write-Host "📦 Upgrading pip..."
python -m pip install --upgrade pip

# --- Confirm Python & pip availability ---
Write-Host "✅ Python should now be available as 'python' and 'pip' in terminal"

Write-Host "`n✅ Windows dev environment setup complete."
