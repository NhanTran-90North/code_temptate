<#
.SYNOPSIS
    Combined Windows PowerShell script to:
    1. Install VS Code, Github Desktop, Python, etc.
    2. Create a virtual environment
    3. Register the venv with Jupyter/IPython
    4. Install Python data science libraries
    5. Install VS Code extensions for Python and documentation
    
.DESCRIPTION
    Run in a PowerShell terminal with:
        .\setup_and_create_venv.ps1 [venv_name]
    If no name is provided, defaults to 'venv'
#>

param (
    [string]$VenvName = "venv"
)

Write-Host "🔧 Running Windows development environment setup..." -ForegroundColor Cyan

# Check for winget
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "❌ winget (Windows Package Manager) is not available. Please install it first from the Microsoft Store." -ForegroundColor Red
    exit 1
}

# 1. Install applications
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

# Confirm Python install
$pythonPath = Get-Command python3 -ErrorAction SilentlyContinue
if (-not $pythonPath) {
    $pythonPath = Get-Command python -ErrorAction SilentlyContinue
}
if (-not $pythonPath) {
    Write-Host "❌ Python is not properly installed or not on PATH." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Python found at $($pythonPath.Source)" -ForegroundColor Green

# 2. Create virtual environment
Write-Host "📦 Creating virtual environment: $VenvName"
python -m venv $VenvName

if (-not (Test-Path "$VenvName\Scripts\Activate.ps1")) {
    Write-Host "❌ Failed to create virtual environment." -ForegroundColor Red
    exit 1
}

# 3. Activate venv and install packages
Write-Host "✅ Activating venv and installing packages..."
& "$VenvName\Scripts\Activate.ps1"
pip install --upgrade pip ipykernel
python -m ipykernel install --user --name $VenvName --display-name "Python ($VenvName)"

# 4. Install Python DS libraries with vscode_python_setup.py
Write-Host "`nSTEP 3: Running vscode_python_setup.py..."
$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$PythonScript = Join-Path $ScriptDir "vscode_python_setup.py"

if (Test-Path $PythonScript) {
    python $PythonScript
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Successfully executed vscode_python_setup.py"
    } else {
        Write-Host "⚠️ Error occurred while running vscode_python_setup.py"
    }
} else {
    Write-Host "⚠️ vscode_python_setup.py not found in $ScriptDir. Skipping."
}

# 5. Install VS Code Extensions
$extensionScript = ".\install_vscode_ds_extensions.ps1"
if (Test-Path $extensionScript) {
    Write-Host "🔧 Installing VS Code extensions for Python and documentation..."
    & $extensionScript
} else {
    Write-Warning "install_vscode_ds_extensions.ps1 not found. Skipping extension installation."
}

# Wrap up
Write-Host "`n🎉 All done!" -ForegroundColor Green
Write-Host "To activate this environment in the future:"
Write-Host "`t& `"$PWD\$VenvName\Scripts\Activate.ps1`""
