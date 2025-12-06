# Auto-download analysis tools on sandbox launch
# Runs via LogonCommand in .wsb configs

$ErrorActionPreference = "SilentlyContinue"
$toolsDir = "C:\AnalysisTools"
New-Item -ItemType Directory -Path $toolsDir -Force | Out-Null

# Create desktop shortcuts folder
$desktop = [Environment]::GetFolderPath("Desktop")

Write-Host "Setting up analysis environment..." -ForegroundColor Cyan

# Sysinternals Suite (includes ProcMon, ProcExp, Autoruns, etc.)
Write-Host "Downloading Sysinternals Suite..."
$sysinternalsUrl = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
$sysinternalsZip = "$toolsDir\SysinternalsSuite.zip"
Invoke-WebRequest -Uri $sysinternalsUrl -OutFile $sysinternalsZip -UseBasicParsing
Expand-Archive -Path $sysinternalsZip -DestinationPath "$toolsDir\Sysinternals" -Force
Remove-Item $sysinternalsZip

# Create shortcuts for common tools
$shortcuts = @(
    @{ Name = "Process Monitor"; Target = "$toolsDir\Sysinternals\Procmon.exe" },
    @{ Name = "Process Explorer"; Target = "$toolsDir\Sysinternals\procexp.exe" },
    @{ Name = "Autoruns"; Target = "$toolsDir\Sysinternals\Autoruns.exe" },
    @{ Name = "TCPView"; Target = "$toolsDir\Sysinternals\Tcpview.exe" }
)

$shell = New-Object -ComObject WScript.Shell
foreach ($s in $shortcuts) {
    $shortcut = $shell.CreateShortcut("$desktop\$($s.Name).lnk")
    $shortcut.TargetPath = $s.Target
    $shortcut.Save()
}

# HashMyFiles
Write-Host "Downloading HashMyFiles..."
$hashUrl = "https://www.nirsoft.net/utils/hashmyfiles-x64.zip"
$hashZip = "$toolsDir\hashmyfiles.zip"
Invoke-WebRequest -Uri $hashUrl -OutFile $hashZip -UseBasicParsing
Expand-Archive -Path $hashZip -DestinationPath "$toolsDir\HashMyFiles" -Force
Remove-Item $hashZip

# Add to PATH
$env:PATH += ";$toolsDir\Sysinternals;$toolsDir\HashMyFiles"

# Open Samples folder if it exists
if (Test-Path "C:\Samples") {
    explorer.exe "C:\Samples"
}

Write-Host ""
Write-Host "Analysis environment ready!" -ForegroundColor Green
Write-Host "Tools installed to: $toolsDir" -ForegroundColor Yellow
Write-Host ""
Write-Host "Quick tips:" -ForegroundColor Cyan
Write-Host "  - Samples folder opened (if mapped)"
Write-Host "  - Export findings to C:\Output before closing"
Write-Host "  - Network is DISABLED - no call-home possible"
Write-Host ""

# Keep window open
pause
