# Run On DC1

# 1. Obtaining the IP addresses of DNS servers for Packt.Com
$NameServers = Resolve-DnsName -Name Packt.Com -Type NS | Where-Object Name -eq 'packt.com'
$NameServers

# 2. Obtaining the IPV4 addresses for these hosts
$NameServerIPs = foreach ($Server in $NS) {
    (Resolve-DnsName -Name $Server.NameHost -Type A).IPAddress
}
$NameServerIPs

# 3. Adding conditional forwarder on DC1
$CFHT = @{
    Name          = 'packt.com'
    MasterServers = $NSIPS
}
Add-DnsServerConditionalForwarderZone @CFHT

# 4. Checking zone on DC1 
Get-DnsServerZone -Name packt.com

# 5. Testing conditional forwarding
Resolve-DNSName -Name www.packt.com -Server SVR | Format-Table
