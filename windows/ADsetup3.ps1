$DomainName = "davidleah.com"
$IPAddress = "192.168.1.1"
$SubnetMask = "255.255.255.0"
$Gateway = "192.168.1.254"
$DNSServer = $IPAddress

# Create OU
Write-Host "Creating Organizational Unit (OU)..."
$OUName = "Goats"
$OUPath = "OU=$OUName,DC=DAVIDLEAH,DC=COM"
New-ADOrganizationalUnit -Name $OUName -Path "DC=davidleah,DC=com"
Write-Host "OU '$OUName' created successfully at path '$OUPath'." 

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

###### CREATE USERS ######

# Variables for user configuration
$Password = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$User1Name = "David"
$User2Name = "Leah"
$OU = "OU=Goats,DC=DAVIDLEAH,DC=COM"

# Import Active Directory module
Import-Module ActiveDirectory

# Create User1 (Domain Users group member)
Write-Host "Creating user 1..."
New-ADUser -Name $User1Name -SamAccountName $User1Name -UserPrincipalName "$User1Name@davidleah.com" `
    -Path $OU -AccountPassword $Password -Enabled $true -PasswordNeverExpires $true `
    -CannotChangePassword $true -ChangePasswordAtLogon $false
Add-ADGroupMember -Identity "Domain Users" -Members $User1Name
Write-Host "User1 created successfully."

# Create User2 (Domain Admins group member)
Write-Host "Creating user 2..."
New-ADUser -Name $User2Name -SamAccountName $User2Name -UserPrincipalName "$User2Name@davidleah.com" `
    -Path $OU -AccountPassword $Password -Enabled $true -PasswordNeverExpires $true `
    -CannotChangePassword $true -ChangePasswordAtLogon $false
Add-ADGroupMember -Identity "Domain Admins" -Members $User2Name
Write-Host "User2 created successfully"

Write-Host "User creation and configuration completed"