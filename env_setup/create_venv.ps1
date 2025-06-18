
# create_venv.ps1

param(
    [string]$VenvName = "venv"  # Default name is 'venv' if none is provided
)

# === LOCATE PYTHON ===
$python = Get-Command python3 -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $python) {
    Write-Error "❌ Python3 not found in PATH."
    exit 1
}
Write-Host "📦 Using Python:" $python.Source

# === CREATE VENV ===
& $python.Source -m venv $VenvName

# === ACTIVATE ===
$activateScript = ".\$VenvName\Scripts\Activate.ps1"
if (-not (Test-Path $activateScript)) {
    Write-Error "❌ Could not find activation script."
    exit 1
}
& $activateScript
Write-Host "✅ Virtual environment '$VenvName' activated."

# === INSTALL ===
pip install --upgrade pip ipykernel
python -m ipykernel install --user --name $VenvName --display-name "🐍 Python ($VenvName)"
Write-Host "✅ Kernel '🐍 Python ($VenvName)' registered for Jupyter/VS Code."
