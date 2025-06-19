<#
.SYNOPSIS
    Combined Windows PowerShell script to:
    1. Install VS Code, Github Desktop, Python, etc.
    2. Create a virtual environment
    3. Register the venv with Jupyter/IPython
.DESCRIPTION
    Run in a PowerShell terminal with:
        .\setup_and_create_venv.ps1 [venv_name]
    If no name is provided, defaults to 'venv'
#>

param (
    [string]$VenvName = "venv"
)

Write-Host "🔧 Running Windows development environment setup..." -ForegroundColor Cyan

# 1. Check for winget
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "❌ winget (Windows Package Manager) is not available. Please install it first from the Microsoft Store." -ForegroundColor Red
    exit 1
}

# 2. Install applications
$packages = @(
    @{ Name = "Microsoft.VisualStudioCode"; Display = "🧰 VS Code" },
    @{ Name = "GitHub.GitHubDesktop"; Display = "🐙 GitHub Desktop" },
    @{ Name = "Python.Python.3"; Display = "🐍 Python" },
    @{ Name = "Notepad++.Notepad++"; Display = "📝 Notepad++" },
    @{ Name = "7zip.7zip"; Display = "📦 7-Zip" }
)

foreach ($pkg in $packages) {
    Write-Host "🔍 Checking/installing $($pkg.Display)..."
    winget install --id $($pkg.Name) --silent --accept-source-agreements --accept-package-agreements
}

# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
             [System.Environment]::GetEnvironmentVariable("Path", "User")

# 3. Confirm Python install
$pythonPath = Get-Command python3 -ErrorAction SilentlyContinue
if (-not $pythonPath) {
    $pythonPath = Get-Command python -ErrorAction SilentlyContinue
}
if (-not $pythonPath) {
    Write-Host "❌ Python is not properly installed or not on PATH." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Python found at $($pythonPath.Source)" -ForegroundColor Green

# 4. Create virtual environment
Write-Host "📦 Creating virtual environment: $VenvName"
python -m venv $VenvName

if (-not (Test-Path "$VenvName\Scripts\Activate.ps1")) {
    Write-Host "❌ Failed to create virtual environment." -ForegroundColor Red
    exit 1
}

# 5. Activate venv and install packages
Write-Host "✅ Activating venv and installing packages..."
& "$VenvName\Scripts\Activate.ps1"
pip install --upgrade pip ipykernel
python -m ipykernel install --user --name $VenvName --display-name "Python ($VenvName)"

# 6. Wrap up
Write-Host "`n🎉 All done!" -ForegroundColor Green
Write-Host "To activate this environment in the future:"
Write-Host "`t& `"$PWD\$VenvName\Scripts\Activate.ps1`""
