$file = "c:\Users\saulp\AppData\Workspace\MVP-Aevum\aevum_native\lib\screens\onboarding_screen.dart"
(Get-Content $file -Raw) -replace '\.withOpacity\(([0-9.]+)\)', '.withValues(alpha: ([math]::Round($1 * 255)))' | Set-Content $file -NoNewline
