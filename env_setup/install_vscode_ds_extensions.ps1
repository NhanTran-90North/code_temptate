# PowerShell script to install VS Code and extensions for data science and development

function CommandExists($cmd) {
    $null -ne (Get-Command $cmd -ErrorAction SilentlyContinue)
}

# Install VS Code if not installed
if (-not (CommandExists "code")) {
    Write-Host "VS Code not found. Installing via winget..."
    winget install --id Microsoft.VisualStudioCode -e --source winget
    Write-Host "`n🔁 Please restart PowerShell and make sure 'code' command is available in your PATH."
    exit
} else {
    Write-Host "✅ VS Code is already installed and 'code' command is available."
}

# Define all extensions to install
$extensions = @(
    # Data science
    "ms-toolsai.jupyter",
    "ms-toolsai.jupyter-keymap",
    "ms-toolsai.jupyter-renderers",
    "ms-toolsai.jupyter-cell-tags",
    "ms-toolsai.vscode-jupyter-slideshow",
    "GrapeCity.gc-excelviewer",

    # Code runners & formatters
    "ms-python.python",
    "ms-python.vscode-pylance",
    "ms-python.black-formatter",
    "ms-python.isort",
	"ms-python.flake8",
    "ms-python.pylint",
	"njpwerner.autodocstring",
	
	# Documentation & Markdown
	"yzhang.markdown-all-in-one",
	"shd101wyy.markdown-preview-enhanced",
	
	# Productivity & Collaboration
	"eamodio.gitlens",
	"ms-vsliveshare.vsliveshare",
	"github.vscode-pull-request-github",
	"streetsidesoftware.code-spell-checker",
	
    # AI & IntelliCode
    "visualstudioexptteam.vscodeintellicode",
    "github.copilot",
    "github.copilot-chat",
)

# Install extensions
foreach ($ext in $extensions) {
    Write-Host "📦 Installing extension: $ext"
    code --install-extension $ext
}

Write-Host "`n✅ All extensions installed successfully!"
