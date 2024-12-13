$DomainName = "davidleah.com"
$NetbiosName = "DAVIDLEAH"
$SafeModePassword = ConvertTo-SecureString "Password123!" -AsPlainText -Force

# Install Active Directory and create a new forest
Write-Host "Installing Active Directory and creating a new forest..."
Install-ADDSForest -DomainName $DomainName -DomainNetbiosName $NetbiosName -SafeModeAdministratorPassword $SafeModePassword -InstallDNS -Force