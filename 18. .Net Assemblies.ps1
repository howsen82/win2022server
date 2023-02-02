# Counting loaded assemblies
$Assemblies = [System.AppDomain]::CurrentDomain.GetAssemblies()
"Assemblies loaded: {0:n0}" -f $Assemblies.Count

# Viewing first 10
$Assemblies | Select-Object -First 10

# Checking assemblies in Windows PowerShell
$ScriptBlock = {
    [System.AppDomain]::CurrentDomain.GetAssemblies()
}
$PS51 = New-PSSession -UseWindowsPowerShell
$Assin51 = Invoke-Command -Session $PS51 -ScriptBlock $ScriptBlock
"Assemblies loaded in Windows PowerShell: {0:n0}" -f $Assin51.Count

# Viewing Microsoft.PowerShell assemblies
$Assin51 | Where-Object FullName -Match "Microsoft\.Powershell" | Sort-Object -Property Location

# Exploring the Microsoft.PowerShell.Management module
$AllTheModulesOnThisSystem = Get-Module -Name Microsoft.PowerShell.Management -ListAvailable
$AllTheModulesOnThisSystem | Format-List

# Viewing module manifest
$Manifest = Get-Content -Path $AllTheModulesOnThisSystem.Path
$Manifest | Select-Object -First 20

# Discovering the module’s assembly
Import-Module -Name Microsoft.PowerShell.Management
$Match = $Manifest | Select-String Modules
$LINE = $Match.Line
$DLL = ($Line -Split '"')[1]
Get-Item -Path $PSHOME\$DLL

# Viewing associated loaded assembly
$Assemblies2 = [System.AppDomain]::CurrentDomain.GetAssemblies() 
$Assemblies2 | Where-Object Location -match $DLL

# Getting details of a PowerShell command inside a module DLL
$Commands = $Assemblies | Where-Object Location -match Commands.Management\.dll
$Commands.GetTypes() | Where-Object Name -match "Addcontentcommand$"