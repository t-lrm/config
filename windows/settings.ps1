# Enable Windows Sandbox
Enable-WindowsOptionalFeature -FeatureName Containers-DisposableClientVM -Online -NoRestart

# Add French keyboard
$currentLangList = Get-WinUserLanguageList
$french = New-WinUserLanguageList fr-FR
$currentLangList.Add($french[0])
Set-WinUserLanguageList $currentLangList -Force