# Menu-driven sandbox launcher

$configs = @{
    "1" = @{ Name = "Malware Analysis (Network OFF)"; File = "malware-analysis.wsb" }
    "2" = @{ Name = "Browser Testing (Network ON)"; File = "browser-testing.wsb" }
    "3" = @{ Name = "Installer Audit (Network OFF)"; File = "installer-audit.wsb" }
    "4" = @{ Name = "Dev Sandbox (Network ON)"; File = "dev-sandbox.wsb" }
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configDir = Join-Path (Split-Path -Parent $scriptDir) "configs"

Clear-Host
Write-Host "================================" -ForegroundColor Cyan
Write-Host "  Windows Sandbox Launcher" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

foreach ($key in ($configs.Keys | Sort-Object)) {
    $c = $configs[$key]
    Write-Host "  [$key] $($c.Name)"
}
Write-Host ""
Write-Host "  [Q] Quit"
Write-Host ""

$choice = Read-Host "Select configuration"

if ($choice -eq "Q" -or $choice -eq "q") {
    exit
}

if ($configs.ContainsKey($choice)) {
    $config = $configs[$choice]
    $wsbPath = Join-Path $configDir $config.File

    if (Test-Path $wsbPath) {
        Write-Host ""
        Write-Host "Launching: $($config.Name)" -ForegroundColor Green
        Start-Process $wsbPath
    } else {
        Write-Host "Config not found: $wsbPath" -ForegroundColor Red
    }
} else {
    Write-Host "Invalid selection" -ForegroundColor Red
}
