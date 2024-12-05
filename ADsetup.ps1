# Script to install and configure AD, DHCP, and DNS on Windows Server

# Variables
$DomainName = "example.com"
$NetbiosName = "EXAMPLE"
$AdminPassword = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$SafeModePassword = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$IPAddress = "192.168.1.10"
$PrefixLength = "24"
$SubnetMask = "255.255.255.0"
$Gateway = "192.168.1.254"
$DNSServer = $IPAddress

# Install required Windows features
Write-Host "Installing AD-Domain-Services, DNS, and DHCP roles..."
Install-WindowsFeature -Name AD-Domain-Services, DNS, DHCP -IncludeManagementTools

# Install Active Directory and create a new forest
Write-Host "Installing Active Directory and creating a new forest..."
Install-ADDSForest -DomainName $DomainName -DomainNetbiosName $NetbiosName -SafeModeAdministratorPassword $SafeModePassword -InstallDNS -Force

# Configure static IP address
Write-Host "Configuring static IP address..."
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $IPAddress -PrefixLength $PrefixLength -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $DNSServer

# Authorize DHCP server
Write-Host "Authorizing DHCP server..."
Add-DhcpServerInDC -DnsName $DomainName -IPAddress $IPAddress

# Configure DHCP scope
$ScopeName = "Scope1"
$StartRange = "192.168.1.100"
$EndRange = "192.168.1.200"
$LeaseDuration = "8.00:00:00" # 8 days
$SubnetMaskBits = 24
Write-Host "Creating DHCP scope..."
Add-DhcpServerv4Scope -Name $ScopeName -StartRange $StartRange -EndRange $EndRange -SubnetMaskBits $SubnetMaskBits -LeaseDuration $LeaseDuration
Set-DhcpServerv4OptionValue -ScopeId $IPAddress -OptionID 3 -Value $Gateway
Set-DhcpServerv4OptionValue -ScopeId $IPAddress -OptionID 6 -Value $DNSServer

# Confirm DNS setup
Write-Host "Confirming DNS configuration..."
Add-DnsServerPrimaryZone -Name $DomainName -ZoneFile $DomainName + ".dns"
Add-DnsServerResourceRecordA -Name "Server" -ZoneName $DomainName -IPv4Address $IPAddress

Write-Host "Setup completed successfully!"
$response = Read-Host "Do you want to reboot the server now? (Y/N)"
if ($response -eq "Y" -or $response -eq "y") {
    Write-Host "Rebooting server..."
    Restart-Computer -Force
} else {
    Write-Host "Reboot canceled."
}
