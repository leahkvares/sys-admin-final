# Configure hostname
Rename-Computer -NewName "DaveLeahWin10" # needs reboot to take effect

# Enable DHCP
Set-NetIPInterface -InterfaceAlias "Ethernet0" -Dhcp Enabled

# Set DNS
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses "192.168.1.1", "8.8.8.8"

# Verify the configuration
# Get-NetIPInterface -InterfaceAlias "Ethernet0"
# Get-DnsClientServerAddress -InterfaceAlias "Ethernet0"

$username = "DAVIDLEAH\Leah"
$password = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $password)

# Join to the domain we made in ADsetup
Add-Computer -DomainName "davidleah.com" -Credential $credential

Write-Host "Restarting..."
Restart-Computer -Force

# After reboot, sign in as Other User and enter those creds