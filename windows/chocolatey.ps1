# Install chocolatey
Set-ExecutionPolicy AllSigned -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install packages
choco install `
googlechrome `
firefox `
tor-browser `
spotify `
1password `
obsidian `
figma `
libreoffice-fresh `
logioptionsplus `
obs-studio `
winrar `
greenshot `
rustdesk `
vlc `
vscode `
sublimetext2 `
jetbrainstoolbox `
dotnet `
git `
github-desktop `
wezterm `
wireguard `
cpu-z `
zebar `
python `
javaruntime `
-y

# Discord installation is specific because of bugs in the installer
choco install discord
$discordPath = Get-ChildItem "$env:LOCALAPPDATA\Discord\app-*\discord.exe" | Select-Object -First 1
& $discordPath.FullName --squirrel-firstrun
