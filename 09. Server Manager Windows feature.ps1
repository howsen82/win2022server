# Importing the ServerManager module
Import-Module -Name ServerManager

# Viewing module details
Get-Module -Name ServerManager | Format-List

# Displaying a Windows feature
Get-WindowsFeature -Name 'TFTP-Client'

# Running the same command in a remoting session
$Session = Get-PSSession -Name WinPSCompatSession
Invoke-Command -Session $Session -ScriptBlock {
    Get-WindowsFeature -Name 'TFTP-Client' | Format-Table
}

# Getting the path to Windows PowerShell modules
$Paths = $env:PSModulePath -split ';'
$S32Path = $Paths | Where-Object { $_.ToString() -match 'system32' }
"System32 path: [$S32Path]"

# Displaying path to the format XML for the Server Manager module
$FXML = "$S32path/ServerManager"
$FF = Get-ChildItem -Path $FXML\*.format.ps1xml 
"Format XML files:"
"     $($FF.Name)"

# Updating format XML in PowerShell 7
Foreach ($fF in $FFFf) {
    Update-FormatData -PrependPath $fF.FullName
}

# Using the command with improved output
Get-WindowsFeature -Name 'TFTP-Client'