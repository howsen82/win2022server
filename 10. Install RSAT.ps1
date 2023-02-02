# Installation of Remote Server Administration Tools (RSAT)
# Displaying counts of available PowerShell commands
$CommandsBeforeRSAT = Get-Command
$CmdletsBeforeRSAT = $CommandsBeforeRSAT | Where-Object CommandType -eq 'Cmdlet'
$CommandCountBeforeRSAT = $CommandsBeforeRSAT.Count
$CmdletCountBeforeRSAT = $CmdletsBeforeRSAT.Count
"On Host: [$(hostname)]"
"Commands available before RSAT installed [$CommandCountBeforeRSAT]"
"Cmdlets available before RSAT installed [$CmdletCountBeforeRSAT]"

# Getting command types returned by Get-Command
$CommandsBeforeRSAT | Group-Object -Property CommandType

# Checking the object type details
$CommandsBeforeRSAT | Get-Member | Select-Object -ExpandProperty TypeName -Unique

# Getting the collection of PowerShell modules and a count of modules before adding the RSAT tools
$ModulesBefore = Get-Module -ListAvailable

# Displaying a count of modules available before adding the RSAT tools
$CountOfModulesBeforeRSAT = $ModulesBefore.Count
"$CountOfModulesBeforeRSAT modules available"

# Getting a count of features actually available on SRV
Import-Module -Name ServerManager -WarningAction SilentlyContinue
$Features = Get-WindowsFeature
$FeaturesInstalled = $Features | Where-Object Installed
$RsatFeatures = $Features | Where-Object Name -Match 'RSAT'
$RsatFeaturesInstalled = $Rsatfeatures | Where-Object Installed

# Displaying counts of features installed
"On Host [$(hostname)]"
"Total features available [{0}]" -f $Features.Count
"Total features installed [{0}]" -f $FeaturesInstalled.Count
"Total RSAT features available [{0}]" -f $RsatFeatures.Count
"Total RSAT features installed [{0}]" -f $RsatFeaturesInstalled.Count

# Adding all RSAT tools to SRV
Get-WindowsFeature -Name *RSAT* | Install-WindowsFeature

# Getting details of RSAT tools now installed on SRV
$FeaturesSRV1 = Get-WindowsFeature
$InstalledOnSRV1 = $FeaturesSRV1 | Where-Object Installed
$RsatInstalledOnSRV1 = $InstalledOnSRV1 | Where-Object Installed | Where-Object Name -Match 'RSAT'

# Displaying counts of commands after installing the RSAT tools
"After Installation of RSAT tools on SRV"
$INS = 'Features installed on SRV'
"$($InstalledOnSRV1.Count) $INS"
"$($RsatInstalledOnSRV1.Count) $INS"

# Displaying RSAT tools on SRV
$Modules = "$env:windir\system32\windowspowerShell\v1.0\modules"
$ServerManagerModules = "$Modules\ServerManager"
Update-FormatData -PrependPath "$ServerManagerModules\*.format.ps1xml"
Get-WindowsFeature | Where-Object Name -Match 'RSAT'

# Rebooting SRV and then logging on as the local administrator
# Rebooting SRV
Restart-Computer -Force