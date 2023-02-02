# Getting commands in the PSReadline module
Get-Command -Module PSReadLine

# Getting the first 10 PSReadLine key handlers
Get-PSReadLineKeyHandler | Select-Object -First 10 | Sort-Object -Property Key | Format-Table -Property Key, Function, Description

# Discovering a count of unbound key handlers
$Unbound = (Get-PSReadLineKeyHandler -Unbound).count
"$Unbound unbound key handlers"

# Getting the PSReadline options
Get-PSReadLineOption

# Determining the VS Code theme name
$Path       = $Env:APPDATA
$CP         = '\Code\User\Settings.json'
$JsonConfig = Join-Path  $Path -ChildPath $CP
$ConfigJSON = Get-Content $JsonConfig
$Theme = $ConfigJson |
           ConvertFrom-Json |
             Select-Object -ExpandProperty 'workbench.colorTheme'

# Changing the VS Code colors
If ($Theme -eq 'Visual Studio Light') {
    Set-PSReadLineOption -Colors @{
      Member    = "`e[33m"
      Number    = "`e[34m"
      Parameter = "`e[35m"
      Command   = "`e[34m"
    }
}