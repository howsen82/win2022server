# Reviewing the commands available in the PowerShellGet module
Get-Command -Module PowerShellGet

# Discovering Find-* cmdlets in PowerShellGet module
Get-Command -Module PowerShellGet -Verb Find

# Getting all commands, modules, DSC resources, and scripts
$Commands     = Find-Command
$Modules      = Find-Module
$DSCResources = Find-DscResource
$Scripts      = Find-Script

# Reporting on results
"On Host [$(hostname)]"
"Commands found:          [{0:N0}]"  -f $Commands.Count
"Modules found:           [{0:N0}]"  -f $Modules.Count
"DSC Resources found:     [{0:N0}]"  -f $DSCResources.Count
"Scripts found:           [{0:N0}]"  -f $Scripts.Count

# Discovering NTFS-related modules
$Modules | Where-Object Name -match NTFS | Format-Table

# Installing the NTFSSecurity module
Install-Module -Name NTFSSecurity -Force

# Reviewing module contents
Get-Command -Module NTFSSecurity

# Testing the Get-NTFSAccess cmdlet
Get-NTFSAccess -Path C:\Foo

# Creating a download folder
$DownloadFolder = 'C:\Foo\DownloadedModules'
$NIHT = @{
    ItemType = 'Directory'
    Path = $DownloadFolder
    ErrorAction = 'SilentlyContinue'
}
New-Item @NIHT | Out-Null

# Downloading the PSLogging module
Save-Module -Name PSLogging -Path $DownloadFolder

# Viewing the contents of the download folder
Get-ChildItem -Path $DownloadFolder -Recurse -Depth 2 | Format-Table -Property FullName

# Importing the PSLogging module
Import-Module -name $DownloadFolder\PSLogging

# Checking commands in the module
Get-Command -Module PSLogging