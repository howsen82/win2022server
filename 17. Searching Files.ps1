# Getting download Locations
$ELoc  = 'https://www.voidtools.com/downloads'
$Release = Invoke-WebRequest -Uri $ELoc # Get all
$FLoc  = 'https://www.voidtools.com'
$EPath = $FLOC + ($Release.Links.href | Where-Object { $_ -match 'x64' } | Select-Object -First 1)
$EFile = 'C:\Foo\EverythingSetup.exe'

# Downloading the Everything installer
Invoke-WebRequest -Uri $EPath -OutFile $EFile -verbose

# Install Everything
$Iopt = "-install-desktop-shortcut -install-service"
$Iloc = 'C:\Program Files\Everything'
.\EverythingSetup.exe /S -install-options $Iipt /D=$Iopt

# Open the GUI for the first time
& "C:\Program Files\Everything\Everything.exe"

# Finding the PSEverything module
Find-Module -Name PSEverything

# Installing the PSEverything module
Install-Module -Name PSEverything -Force

# Discovering commands in the module
Get-Command -Module PSEverything

# Getting a count of files in folders below C:\Foo
Set-Location -Path C:\Foo   # just in case
Search-Everything | Get-Item | Group-Object DirectoryName | Where-Object name -ne '' | Format-Table -Property Name, Count

# Finding PowerShell scripts using wild cards
Search-Everything *.ps1 | Measure-Object

# Finding all PowerShell scripts using regular expression
Search-Everything -RegularExpression '\.ps1$' -Global | Measure-Object