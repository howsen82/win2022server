# Get Download Locations
$CascadiaFont    = 'CascadiaCode'    # font file name (sans exetension)
$CascadiaRelURL  = 'https://github.com/microsoft/cascadia-code/releases'
$CascadiaRelease = Invoke-WebRequest -Uri $CascadiaRelURL
$ReleaseTAG = $CascadiaRelease.Links.href | Where-Object { $_ -match 'Releases/tag'} | Select-Object -First 1
$ReleaseTAG = $ReleaseTAG -replace 'tag', 'download'
$FinalPart = Split-Path -Path $ReleaseTAG -Leaf
$FinalPart = $FinalPart -replace 'v', ''
$ReleasePg =   'https://github.com' + $ReleaseTAG + '/' + $CascadiaFont + '-' + $FinalPart + '.zip'
# $LatestRelease = Invoke-WebRequest -Uri $ReleasePg
$CascadiaFile   = 'C:\Foo\CascadiaFontDL.zip' # where it goes

# Downloading the Cascadia Code font file archive
Invoke-WebRequest -Uri $ReleasePg -OutFile $CascadiaFile

# Expanding the font archive file, Install Cascadia Code font
$CascadiaFontFolder = 'C:\Foo\CascadiaCode'
Expand-Archive -Path $CascadiaFile -DestinationPath $CascadiaFontFolder -verbose

# Installing the Cascadia Code font
$FontFile = 'C:\Foo\CascadiaCode\ttf\CascadiaCode.ttf'
$FontShellApp = New-Object -Com Shell.Application
$FontShellNamespace = $FontShellApp.Namespace(0x14)
$FontShellNamespace.CopyHere($FontFile, 0x10)