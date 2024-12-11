###### Set Static IP Address, Gateway, and DNS Servers ###### 
$interfacealias = "Ethernet0"
$IPAddress = "192.168.1.1"
$defaultgateway = "192.168.1.254"
$dnsservers = @("127.0.0.1", "129.21.3.17", "8.8.8.8")

Rename-Computer -NewName "DavidLeahWindowsServer" # this needs a restart to take effect

# Set static IP
Write-Host "Configuring static IP address on $interfacealias..."
New-NetIPAddress -InterfaceAlias $interfacealias -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $defaultgateway

# Set DNS servers
Write-Host "Setting DNS servers..."
foreach ($dns in $dnsservers) {
    Set-DnsClientServerAddress -InterfaceAlias $interfacealias -ServerAddresses $dns
}


###### Install and configure AD, DHCP, and DNS on Windows Server ######

# Variables
$DomainName = "davidleah.com"
$NetbiosName = "DAVIDLEAH"
$AdminPassword = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$SafeModePassword = ConvertTo-SecureString "Password123!" -AsPlainText -Force
# $IPAddress = "192.168.1.1"
$PrefixLength = "24"
$SubnetMask = "255.255.255.0"
$Gateway = "192.168.1.254"
$DNSServer = $IPAddress

# Install required Windows features
Write-Host "Installing AD-Domain-Services, DNS, and DHCP roles..."
Install-WindowsFeature -Name AD-Domain-Services, DNS, DHCP -IncludeManagementTools

# Install Active Directory and create a new forest
Write-Host "Installing Active Directory and creating a new forest..."
Install-ADDSForest -DomainName $DomainName -DomainNetbiosName $NetbiosName -SafeModeAdministratorPassword $SafeModePassword -InstallDNS -NoRebootOnCompletion -Force