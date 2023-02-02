# Finding the PSShortCut module
Find-Module -Name '*Shortcut'

# Installing the PSShortCut module
Install-Module -Name PSShortcut -Force

# Reviewing the PSShortCut module
Get-Module -Name PSShortCut -ListAvailable | Format-List

# Discovering commands in the PSShortCut module
Get-Command -Module PSShortCut

# Discovering all shortcuts on SRV1
$SHORTCUTS = Get-Shortcut
"Shortcuts found on $(hostname): [{0}]" -f $SHORTCUTS.Count

# Discovering PWSH shortcuts
$SHORTCUTS | Where-Object Name -match '^PWSH'

# Discovering URL shortcut
$URLSC = Get-Shortcut -FilePath *.url
$URLSC

# Viewing the content of shortcut
$URLSC | Get-Content

# Creating a URL shortcut
$NEWURLSC = 'C:\Foo\Google.url'
$TARGETURL = 'https://google.com'
New-Item -Path $NEWURLSC | Out-Null
Set-Shortcut -FilePath $NEWURLSC -TargetPath $TARGETURL

# Using the URL shortcut
& $NEWURLSC

# Creating a file shortcut
$CMD  = Get-Command -Name notepad.exe
$NP   = $CMD.Source
$NPSC = 'C:\Foo\NotePad.lnk'
New-Item -Path $NPSC | Out-Null
Set-Shortcut -FilePath $NPSC -TargetPath $NP

# Using the shortcut
& $NPSC
