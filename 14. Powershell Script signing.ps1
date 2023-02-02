# Creating a script-signing self-signed certificate
$CHT = @{
    Subject = 'Reskit Code Signing'
    Type = 'CodeSigning'
    CertStoreLocation = 'Cert:\CurrentUser\My'
}
New-SelfSignedCertificate @CHT | Out-Null

# Displaying the newly created certificate
$Cert = Get-ChildItem -Path Cert:\CurrentUser\my -CodeSigningCert
$Cert | Where-Object { $_.SubjectName.Name -match $CHT.Subject }

# Creating and viewing a simple script
$Script = @"
  # Sample Script
  'Hello World from PowerShell 7!'
  "Running on [$(Hostname)]"
"@
$Script | Out-File -FilePath C:\Foo\Signed.ps1
Get-ChildItem -Path C:\Foo\Signed.ps1

# Signing your new script
$SHT = @{
    Certificate = $Cert
    FilePath = 'C:\Foo\Signed.ps1'
}
Set-AuthenticodeSignature @SHT

# Checking script after signing
Get-ChildItem -Path C:\Foo\Signed.ps1

# Viewing the signed script
Get-Content -Path C:\Foo\Signed.ps1

# Testing the signature
Get-AuthenticodeSignature -FilePath C:\Foo\Signed.ps1 | Format-List

# Running the signed script
C:\Foo\Signed.ps1

# Setting the execution policy to all signed for this process
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope Process

# Running the signed script
C:\Foo\Signed.ps1 

# Copying certificate to the Current User Trusted Root store
$DestStoreName  = 'Root'
$DestStoreScope = 'CurrentUser'
$Type   = 'System.Security.Cryptography.X509Certificates.X509Store'
$MHT = @{
    TypeName = $Type
    ArgumentList  = ($DestStoreName, $DestStoreScope)
}
$DestStore = New-Object @MHT
$DestStore.Open(
  [System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
$DestStore.Add($Cert)
$DestStore.Close()

# Checking the signature
Get-AuthenticodeSignature -FilePath C:\Foo\Signed.ps1 | Format-List

# Running the signed script
C:\Foo\Signed.ps1

# Copying certificate to the Trusted Publisher store
$DestStoreName = 'TrustedPublisher'
$DestStoreScope = 'CurrentUser'
$Type = 'System.Security.Cryptography.X509Certificates.X509Store'
$MHT = @{
    TypeName = $Type
    ArgumentList = ($DestStoreName, $DestStoreScope)
}
$DestStore = New-Object @MHT
$DestStore.Open(
    [System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
$DestStore.Add($Cert)
$DestStore.Close()

# Running the signed script
C:\Foo\Signed.ps1

# Resetting the Execution policy for this process
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process