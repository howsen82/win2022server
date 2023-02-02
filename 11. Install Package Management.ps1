# Reviewing the cmdlets in the PackageManagement module
Get-Command -Module PackageManagement

# Reviewing installed providers with Get-PackageProvider
Get-PackageProvider | Format-Table -Property Name, Version, SupportedFileExtensions, FromTrustedSource

# Examining available package providers
$PROVIDERS = Find-PackageProvider
$PROVIDERS | Select-Object -Property Name, Summary | Format-Table -AutoSize -Wrap

# Discovering and counting available packages
$PACKAGES = Find-Package
"Discovered {0:N0} packages" -f $PACKAGES.Count

# Showing the first 5 packages discovered
$PACKAGES | Select-Object -First 5 | Format-Table -AutoSize -Wrap

# Installing the ChocolateyGet provider
Install-PackageProvider -Name ChocolateyGet -Force | Out-Null

# Verifying ChocolateyGet is in the list of installed providers
Import-PackageProvider -Name ChocolateyGet
Get-PackageProvider -ListAvailable | Select-Object -Property Name, Version

# Discovering packages using the ChocolateyGet provider
$CPackages = Find-Package -ProviderName ChocolateyGet -Name *
"$($CPackages.Count) packages available via ChocolateyGet"