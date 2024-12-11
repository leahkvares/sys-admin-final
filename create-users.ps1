# Variables for user configuration
$Password = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$User1Name = "David"
$User2Name = "Leah"
$OU = "OU=Users,DC=davidleah,DC=com"

# Import Active Directory module
Import-Module ActiveDirectory

# Create User1 (Domain Users group member)
Write-Host "Creating user 1..."
New-ADUser -Name $User1Name -SamAccountName $User1Name -UserPrincipalName "$User1Name@example.com" `
    -Path $OU -AccountPassword $Password -Enabled $true -PasswordNeverExpires $true `
    -CannotChangePassword $true -ChangePasswordAtLogon $false
Add-ADGroupMember -Identity "Domain Users" -Members $User1Name
Write-Host "User1 created successfully."

# Create User2 (Domain Admins group member)
Write-Host "Creating user 2..."
New-ADUser -Name $User2Name -SamAccountName $User2Name -UserPrincipalName "$User2Name@example.com" `
    -Path $OU -AccountPassword $Password -Enabled $true -PasswordNeverExpires $true `
    -CannotChangePassword $true -ChangePasswordAtLogon $false
Add-ADGroupMember -Identity "Domain Admins" -Members $User2Name
Write-Host "User2 created successfully"

Write-Host "User creation and configuration completed"
