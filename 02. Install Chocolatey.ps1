# Downloading the installation script for Chocolatey
$ChocoIns = 'C:\Foo\Install-Chocolatey.ps1'
$DI       = New-Object System.Net.WebClient
$DI.DownloadString('https://community.chocolatey.org/install.ps1') | Out-File -FilePath $ChocoIns

# Viewing the installation help file
C:\Foo\Install-Chocolatey.ps1 -?

# Installing Chocolatey
C:\Foo\Install-Chocolatey.ps1

# Configuring Chocolatey for allowGlobalConfirmation
choco feature enable -n allowGlobalConfirmation

# Finding PowerShell (PWSH) on Chocolatey
choco find pwsh

# Installing PowerShell 7 using choco.exe
choco install powershell-core –-force
