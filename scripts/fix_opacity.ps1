$content = Get-Content 'c:\Users\saulp\AppData\Workspace\MVP-Aevum\aevum_native\lib\screens\member_memories_screen.dart' -Raw
$content = $content -replace '\.withOpacity\(([0-9.]+)\)', '.withValues(alpha: ([math]::Round($1 * 255)))'
Set-Content 'c:\Users\saulp\AppData\Workspace\MVP-Aevum\aevum_native\lib\screens\member_memories_screen.dart' -Value $content -NoNewline
