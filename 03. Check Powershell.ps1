# Viewing the PowerShell version
$PSVersionTable

# Viewing the $Host variable
$Host

# Looking at the PowerShell process (PWSH)
Get-Process -Id $PID | Format-Custom -Property MainModule -Depth 1

# Looking at resource usage statistics
Get-Process -Id $PID | Format-List CPU, *Memory*

# Updating the PowerShell 7 help files
$Before = Get-Help -Name about_*
Update-Help -Force | Out-Null
$After = Get-Help -Name about_*
$Delta = $After.Count - $Before.Count
"{0} Conceptual Help Files Added" -f $Delta

# Determining available commands
Get-Command | Group-Object -Property CommandType

# Examining the Path Variable
$env:path.split(';')