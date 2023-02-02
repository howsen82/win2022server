# 1. Importing the DHCP server module
Import-Module DHCPServer -WarningAction SilentlyContinue

# 2. Creating an IPv4 scope, for assigning DHCP IP Address range
$SCOPEHT = @{
    Name         = 'ReskitOrg'
    StartRange   = '10.10.10.150'
    EndRange     = '10.10.10.199'
    SubnetMask   = '255.255.255.0'
    ComputerName = 'SVR.Reskit.Org'
}
Add-DhcpServerV4Scope @SCOPEHT

# 3. Getting IPV4 scopes from the server
Get-DhcpServerv4Scope -ComputerName SVR.Reskit.Org

# 4. Setting server-wide option values
$OPTION1HT = @{
    ComputerName = 'SVR.Reskit.Org' # DHCP Server to Configure
    DnsDomain    = 'Reskit.Org'     # Client DNS Domain
    DnsServer    = '10.10.10.10'    # Client DNS Server
}
Set-DhcpServerV4OptionValue @OPTION1HT

# 5. Setting a scope-specific option
$OPTION2HT = @{
    ComputerName = 'SVR.Reskit.Org' # DHCP Server to Configure
    Router       = '10.10.10.254'
    ScopeID      = '10.10.10.0'
}
Set-DhcpServerV4OptionValue @OPTION2HT 

# 6. Viewing server options
Get-DhcpServerv4OptionValue | Format-Table -AutoSize

# 7. Viewing scope specific options
Get-DhcpServerv4OptionValue -ScopeId '10.10.10.0' | Format-Table -AutoSize

# 8. Viewing DHCPv4 option definitions
Get-DhcpServerv4OptionDefinition | Format-Table -AutoSize