# Creating a FileInfo object
$File = Get-ChildItem -Path $PSHOME\pwsh.exe
$File

# Discovering the underlying class
$Type = $File.GetType().FullName
".NET Class name: $Type"

# Getting member types of FileInfo object
$File | Get-Member | Group-Object -Property MemberType | Sort-Object -Property Count -Descending

# Discovering properties of a Windows service
Get-Service | Get-Member -MemberType Property     

# Discovering the underlying type of an integer
$I = 42
$IntType  = $I.GetType()
$TypeName = $IntType.FullName
$BaseType = $IntType.BaseType.Name
".NET Class name      : $TypeName"
".NET Class base type : $BaseType"

# Looking at Process objects
$Pwsh = Get-Process -Name pwsh | Select-Object -First 1
$Pwsh | Get-Member | Group-Object -Property MemberType | Sort-Object -Property Count -Descending

# 7. Looking at static properties within a class
$Max = [Int32]::MaxValue
$Min = [Int32]::MinValue
"Minimum value [$Min]"
"Maximum value [$Max]"