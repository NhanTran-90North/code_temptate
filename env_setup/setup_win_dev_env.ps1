
# ╔══════════════════════════════════════════════════════════════════╗
# ║                  Dev Tool Installer via Winget                   ║
# ║      Installs VSCode, Python, GitHub Desktop, Notepad++, 7-Zip   ║
# ╚══════════════════════════════════════════════════════════════════╝

# Check for winget availability
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "❌ winget is not available. Install 'App Installer' from Microsoft Store."
    exit 1
}

# ╔═══════════════════════════════╗
# ║ Function: Install If Missing  ║
# ╚═══════════════════════════════╝
function Install-PackageIfMissing {
    param (
        [string]$PackageId,
        [string]$PackageName
    )

    if (-not (winget list --id $PackageId | Select-String $PackageId)) {
        Write-Output "Installing $PackageName..."
        winget install --id $PackageId --silent --accept-source-agreements --accept-package-agreements
    } else {
        Write-Output "✅ $PackageName is already installed."
    }
}

# ╔══════════════════════╗
# ║ Installing Packages  ║
# ╚══════════════════════╝
Install-PackageIfMissing "Microsoft.VisualStudioCode" "🧰 Visual Studio Code"
Install-PackageIfMissing "Python.Python.3" "🐍 Python 3"
Install-PackageIfMissing "GitHub.GitHubDesktop" "🐙 GitHub Desktop"
Install-PackageIfMissing "Notepad++.Notepad++" "📝 Notepad++"
Install-PackageIfMissing "7zip.7zip" "📦 7-Zip"

Write-Output "🎉 All installations are complete!"
