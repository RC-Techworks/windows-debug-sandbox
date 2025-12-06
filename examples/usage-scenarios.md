# Usage Scenarios

## Scenario 1: Suspicious Email Attachment

Your aunt forwarded you "invoice.pdf.exe" and wants to know if it's safe.

1. Save file to `C:\Sandbox\Samples\`
2. Launch `malware-analysis.wsb`
3. File appears at `C:\Samples\invoice.pdf.exe`
4. Right-click > Properties - check if it's really a PDF
5. Run Process Monitor, then execute the file
6. Watch for:
   - File system changes
   - Registry modifications
   - Process spawning
   - Attempts to access network (will fail - network disabled)
7. Run Autoruns to check persistence mechanisms
8. Export findings: `C:\Output\` persists to host
9. Close sandbox - malware gone

## Scenario 2: Testing Sketchy Software

Found a "free" tool on some random site. Probably fine. Probably.

1. Download installer to `C:\Sandbox\Installers\`
2. Launch `installer-audit.wsb`
3. Run the installer inside sandbox
4. Check what it actually installed:
   - Autoruns: Did it add startup entries?
   - Process Explorer: What's running?
   - Check Program Files for bundled crapware
5. Decide if you trust it on your real system

## Scenario 3: Clean Browser Session

Need to log into something sensitive without browser tracking you.

1. Launch `browser-testing.wsb`
2. Use Edge (pre-installed) or download browser of choice
3. Browse with zero history, zero cookies, zero tracking
4. Close sandbox - session completely destroyed

## Scenario 4: Testing Code Changes

Want to test a script that modifies system settings without risking your machine.

1. Put script in `C:\Sandbox\Projects\`
2. Launch `dev-sandbox.wsb`
3. Run your script
4. Break things freely - it's disposable
5. If it works, run on real system
