# Capture analysis artifacts before sandbox closes
# Run this manually when done analyzing

param(
    [string]$OutputPath = "C:\Output"
)

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$artifactDir = "$OutputPath\analysis-$timestamp"
New-Item -ItemType Directory -Path $artifactDir -Force | Out-Null

Write-Host "Capturing analysis artifacts..." -ForegroundColor Cyan

# Running processes
Get-Process | Select-Object Name, Id, Path, Company, CPU, WorkingSet |
    Export-Csv "$artifactDir\processes.csv" -NoTypeInformation

# Services
Get-Service | Select-Object Name, DisplayName, Status, StartType |
    Export-Csv "$artifactDir\services.csv" -NoTypeInformation

# Scheduled tasks
Get-ScheduledTask | Select-Object TaskName, TaskPath, State |
    Export-Csv "$artifactDir\scheduled-tasks.csv" -NoTypeInformation

# Startup items (if Autoruns output exists)
if (Test-Path "C:\AnalysisTools\Sysinternals\autorunsc.exe") {
    & "C:\AnalysisTools\Sysinternals\autorunsc.exe" -a * -c -nobanner > "$artifactDir\autoruns.csv"
}

# Network connections
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess |
    Export-Csv "$artifactDir\network-connections.csv" -NoTypeInformation

# Installed programs
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
    Export-Csv "$artifactDir\installed-programs.csv" -NoTypeInformation

# Environment variables
Get-ChildItem Env: | Export-Csv "$artifactDir\environment.csv" -NoTypeInformation

# Summary
Write-Host ""
Write-Host "Artifacts saved to: $artifactDir" -ForegroundColor Green
Write-Host ""
Get-ChildItem $artifactDir | ForEach-Object { Write-Host "  - $($_.Name)" }

Write-Host ""
Write-Host "This folder persists after sandbox closes." -ForegroundColor Yellow

pause
