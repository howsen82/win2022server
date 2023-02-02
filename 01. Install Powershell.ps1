# Setting an execution policy for Windows PowerShell 5.1
Write-Host 'Setting Execution Policy'
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# Install the latest versions of Nuget and PowerShellGet
Write-Host 'Updating PowerShellGet and Nuget'
Install-PackageProvider Nuget -MinimumVersion 2.8.5.201 -Force | Out-Null
Install-Module -Name PowerShellGet -Force -AllowClobber

# Update help text for Windows Powershell
Update-Help -Force | Out-Null

# Ensuring the C:\Foo Folder exists
Write-Host 'Creating C:\Foo'
$LFHT = @{
    ItemType = 'Directory'
    ErrorAction = 'SilentlyContinue' # should it already exists
}
New-Item -Path C:\Foo @LFHT | Out-Null

# Downloading PowerShell 7 installation script from GitHub
Set-Location -Path C:\Foo
$URI = 'https://aka.ms/install-powershell.ps1'
Invoke-RestMethod -Uri @URI | Out-File -FilePath C:\Foo\Install-Powershell.ps1

# Installing Powershell 7.x
$EXTHT = @{
    UseMSI                 = $true
    Quiet                  = $true
    AddExplorerContextMenu = $true
    EnablePSRemoting       = $true
}
C:\Foo\Install-Powershell.ps1 @EXTHT | Out-Null

# For installing the preview and daily builds (for the adventurous)
# C:\Foo\Install-PowerShell.ps1 -Preview -Destination C:\PSPreview | Out-Null
# C:\Foo\Install-PowerShell.ps1 -Daily -Destination C:\PSDailyBuild | Out-Null

# Creating Windows PowerShell default profiles
# First the ISE
$URI = 'https://raw.githubusercontent.com/doctordns/PACKT-PS7/master/scripts/goodies/Microsoft.PowerShell_Profile.ps1'
$ProfileFile    = $Profile.CurrentUserCurrentHost
New-Item $ProfileFile -Force -WarningAction SilentlyContinue | Out-Null
(Invoke-WebRequest -Uri $URI -UseBasicParsing).Content | Out-File -FilePath  $ProfileFile

# Now profile for ConsoleHost
$ProfilePath    = Split-Path -Path $ProfileFile
$ChildPath      = 'Microsoft.PowerShell_profile.ps1'
$ConsoleProfile = Join-Path -Path $ProfilePath -ChildPath $ChildPath
(Invoke-WebRequest -Uri $URI -UseBasicParsing).Content | Out-File -FilePath  $ConsoleProfile

Write-Host 'Download VS Code Installation Script'
$VSCPATH = 'C:\Foo'
Save-Script -Name Install-VSCode -Path $VSCPATH
Set-Location -Path $VSCPATH

Write-Host "Installing VS Code"
$Extensions =  'Streetsidesoftware.code-spell-checker',
               'yzhang.markdown-all-in-one',
               'hediet.vscode-drawio'
$InstallHT = @{
    BuildEdition         = 'Stable-System'
    AdditionalExtensions = $Extensions
    LaunchWhenDone       = $true
}
.\Install-VSCode.ps1 @InstallHT -ea 0 | Out-Null

# Checking versions of PowerShell 7 loaded
# Get-ChildItem -Path C:\pwsh.exe -Recurse -ErrorAction SilentlyContinue