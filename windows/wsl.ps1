# Install WSL
wsl --install --no-distribution

# Define variables to create nixos WSL
$DistroName = "NixOS"
$DownloadUrl = "https://github.com/nix-community/NixOS-WSL/releases/download/2411.6.0/nixos.wsl"
$DocumentsPath = "C:\Users\$env:USERNAME\Documents\WSL"
$InstallPath = Join-Path $DocumentsPath $DistroName
$WSLFile = Join-Path $InstallPath "nixos.wsl"

# Create directory if it doesn't exist
if (-Not (Test-Path $InstallPath)) {
    New-Item -ItemType Directory -Path $InstallPath | Out-Null
}

Write-Host "Downloading NixOS WSL rootfs..."
Invoke-WebRequest -Uri $DownloadUrl -OutFile $WSLFile

# Execute the .wsl file
& $WSLFile

# Copy the file into WSL (replace existing configuration)
$CustomConfigPath = ".\windows\wsl\nixos\configuration.nix"
$DistroName = "NixOS"
$WSLDestination = "/etc/nixos/configuration.nix"
$customConfigContent = Get-Content $CustomConfigPath -Raw

wsl -d $DistroName -- bash -c "sudo tee $WSLDestination > /dev/null" <<< $customConfigContent

wsl -d $DistroName -- bash -c "
  sudo nixos-rebuild switch &&
  nix flake update
"
