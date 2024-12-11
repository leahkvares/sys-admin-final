$DomainName = "davidleah.com"
$IPAddress = "192.168.1.1"
$SubnetMask = "255.255.255.0"
$Gateway = "192.168.1.254"
$DNSServer = $IPAddress

# Authorize DHCP server
Write-Host "Authorizing DHCP server..."
Add-DhcpServerInDC -DnsName $DomainName -IPAddress $IPAddress

# Configure DHCP scope
$ScopeName = "Scope1"
$StartRange = "192.168.1.100"
$EndRange = "192.168.1.200"
$LeaseDuration = "8.00:00:00" # 8 days
Write-Host "Creating DHCP scope..."
Add-DhcpServerv4Scope -Name $ScopeName -StartRange $StartRange -EndRange $EndRange -SubnetMask $SubnetMask -LeaseDuration $LeaseDuration
Set-DhcpServerv4OptionValue -ScopeId $IPAddress -OptionID 3 -Value $Gateway
Set-DhcpServerv4OptionValue -ScopeId $IPAddress -OptionID 6 -Value $DNSServer

# Confirm DNS setup
Write-Host "Confirming DNS configuration..."
# Add-DnsServerPrimaryZone -Name $DomainName -ZoneFile "$DomainName.dns"
Add-DnsServerResourceRecordA -Name "Server" -ZoneName $DomainName -IPv4Address $IPAddress

Write-Host "Setup completed successfully!"
$response = Read-Host "Do you want to reboot the server now? (Y/N)"
if ($response -eq "Y" -or $response -eq "y") {
    Write-Host "Rebooting server..."
    Restart-Computer -Force
} else {
    Write-Host "Reboot canceled."
}

# does it need to reboot after this? 
# combine create-users into this script?