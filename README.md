# Windows Debug Sandbox

Pre-configured Windows Sandbox environments for debugging, malware analysis, and safe testing of suspicious software.

## Why Windows Sandbox?

Windows Sandbox is a lightweight, disposable VM built into Windows 10/11 Pro and Enterprise. Every launch creates a pristine environment that's completely destroyed on close. Perfect for:

- Analyzing suspicious files without risking your system
- Testing unknown installers before committing
- Running sketchy downloads in isolation
- Clean browser sessions (no tracking, no history)
- Disposable dev environments

## Requirements

- Windows 10/11 Pro or Enterprise
- Windows Sandbox feature enabled
- Virtualization enabled in BIOS

### Enable Windows Sandbox
```powershell
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -Online -NoRestart
```

## Quick Start

1. Clone this repo
2. Double-click any `.wsb` file to launch that sandbox config
3. Or use `scripts/quick-launch.ps1` for a menu

## Configurations

| Config | Purpose | Networking | Mapped Folders |
|--------|---------|------------|----------------|
| `malware-analysis.wsb` | Analyze suspicious files | Disabled | Samples (read-only), Output |
| `browser-testing.wsb` | Clean browser sessions | Enabled | None |
| `installer-audit.wsb` | Test unknown installers | Disabled | Installers (read-only) |
| `dev-sandbox.wsb` | Disposable dev work | Enabled | Projects |

## Analysis Workflow

1. Drop suspicious file in `samples/` folder
2. Launch `malware-analysis.wsb`
3. File appears in sandbox at `C:\Samples`
4. Run analysis tools (auto-installed via logon script)
5. Export findings to `C:\Output` (persists to host)
6. Close sandbox - malware destroyed, findings saved

## Included Tools (Auto-Downloaded)

The setup script downloads these free tools:
- Process Monitor (Sysinternals)
- Process Explorer (Sysinternals)
- Autoruns (Sysinternals)
- PE-bear
- HashMyFiles
- VirusTotal Uploader

## License

MIT - Do whatever you want with it.
