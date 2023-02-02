# Starting Notepad
notepad.exe

# Obtaining methods on the Notepad process
$Notepad = Get-Process -Name Notepad
$Notepad | Get-Member -MemberType Method

# Using the Kill() method
$Notepad | ForEach-Object { $_.Kill() }

# Confirming Notepad process is destroyed
Get-Process -Name Notepad

# Creating a new folder and some files
$Path = 'C:\Foo\Secure'
New-Item -Path $Path -ItemType directory -ErrorAction SilentlyContinue | Out-Null
1..3 | ForEach-Object {
    "Secure File" | Out-File "$Path\SecureFile$_.txt"
}

# Viewing files in $Path folder
$Files = Get-ChildItem -Path $Path
$Files | Format-Table -Property Name, Attributes

# Encrypting the files
$Files | ForEach-Object Encrypt

# Viewing file attributes
Get-ChildItem -Path $Path | Format-Table -Property Name, Attributes

# Decrypting the files
$Files| ForEach-Object {
    $_.Decrypt()
}

# Viewing the file attributes
Get-ChildItem -Path $Path | Format-Table -Property Name, Attributes