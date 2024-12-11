# Configure hostname
Rename-Computer -NewName "DavidLeahWindowsTen" # needs reboot to take effect

# Change the NIC settings to receive IPv4 network configuration via DHCP (from the Windows Server DHCP: 192.168.1.1)

# Add DNS server 192.168.1.1 and 8.8.8.8

$username = "DAVIDLEAH\Leah"
$password = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $password)

# Join to the domain we made in ADsetup
Add-Computer -DomainName "davidleah.com" -Credential $credential
# need to reboot after this. after reboot, sign in as Other User and enter those creds
