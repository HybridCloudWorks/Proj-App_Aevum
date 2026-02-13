Write-Host "Ensuring FVM is installed, adding Pub cache bin to user PATH, and selecting Flutter 3.41.0."

# Pub cache bin path
$pubBin = "$env:USERPROFILE\AppData\Local\Pub\Cache\bin"

if (-not ($env:Path -split ';' | Where-Object { $_ -eq $pubBin })) {
	Write-Host "Adding $pubBin to User PATH..."
	[Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + $pubBin, "User")
	Write-Host "Added to PATH. Restart terminals to pick up change."
} else {
	Write-Host "$pubBin already in PATH."
}

# Activate fvm if not present
if (-not (Get-Command fvm -ErrorAction SilentlyContinue)) {
	Write-Host "Activating fvm (dart pub global activate fvm)..."
	dart pub global activate fvm
}

$fvmExe = Join-Path $pubBin "fvm.bat"
if (-not (Test-Path $fvmExe)) {
	Write-Host "fvm executable not found at $fvmExe. Ensure Dart/Flutter is installed and activation succeeded." 
	exit 1
}

Write-Host "Installing and using Flutter 3.41.0 via fvm..."
& $fvmExe install 3.41.0
& $fvmExe use 3.41.0 --force

Write-Host "Running 'fvm flutter pub get --no-example' in apps/mobile..."
Push-Location "apps/mobile"
& $fvmExe flutter pub get --no-example
Pop-Location

Write-Host "Done. If terminals still don't see 'fvm', restart VSCode or your shell."
