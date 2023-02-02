# Creating a new repository folder
$PATH = 'C:\RKRepo'
New-Item -Path $PATH -ItemType Directory | Out-Null

# Sharing the folder
$SMBHT = @{
    Name        = 'RKRepo'
    Path        = $PATH
    Description = 'Reskit Repository'
    FullAccess  = 'Everyone'
}
New-SmbShare @SMBHT

# Registering the repository as trusted (on SVR)
$Path = '\\' + $(hostname) + '\RKRepo'
$REPOHT = @{
  Name               = 'RKRepo'
  SourceLocation     = $Path
  PublishLocation    = $Path
  InstallationPolicy = 'Trusted'
}
Register-PSRepository @REPOHT

# Viewing configured repositories
Get-PSRepository

# Creating a Hello World module folder
$HWDIR = 'C:\HW'
New-Item -Path $HWDIR -ItemType Directory | Out-Null

# Creating a very simple module
$HS = @"
Function Get-HelloWorld {'Hello World'}
Set-Alias -Name GHW -Value Get-HelloWorld
"@
$HS | Out-File $HWDIR\HW.psm1

# Testing the module locally
Import-Module -Name $HWDIR\HW.PSM1 -Verbose
GHW

# Creating a PowerShell module manifest for the new module
$NMHT = @{
    Path = "$HWDIR\HW.psd1"
    RootModule = 'HW.psm1'
    Description = 'Hello World module'
    Author = 'DoctorDNS@Gmail.com'
    FunctionsToExport = 'Get-HelloWorld'
    ModuleVersion = '1.0.1'
}
New-ModuleManifest @NMHT

# Publishing the module
Publish-Module -Path $HWDIR -Repository RKRepo -Force

# Viewing the results of publishing
Find-Module -Repository RKRepo

# Checking the repository’s home folder
Get-ChildItem -Path $LPATH