<#
  Author: David Girard
  Date: 11/19/2024
  Description: This file creates and starts all of the virtual machines required for running. 
#>
$lines = "port=8697", "username=john", 'password=$2a$14$MIYvwBXHrkOEA3iAHjcS8.DJtTgpmzQDIaW.QGRW5VIwBhjpoAUQW', 'salt=*OFVN+_4:.$}v~9a'
$filePath = "C:\Users\GCCISAdmin\vmrest.cfg"  # Replace with your desired file path

# Ensure you're in the correct directory for VMware Workstation (if needed)
Set-Location "C:\Program Files (x86)\VMware\VMware Workstation"

# List of VM directories and their associated .vmx file names
$vmList = @(
    @{ Name = "Rocky 9"; VmxFile = "Rocky 9.vmx" },
    @{ Name = "pfSense-2.5.1"; VmxFile = "pfSense-2.5.1.vmx" },
    @{ Name = "VLWindows_10_22h2"; VmxFile = "VLWindows_10_22h2.vmx" },
    @{ Name = "WinServer2k22"; VmxFile = "Windows Server 2019.vmx" }  # Special case
)

# Loop through each VM in the list
foreach ($vm in $vmList) {
    Write-Host "Creating $($vm.Name) Virtual Machine"
    .\vmrun -T ws clone "C:\Virtual Machines\$($vm.Name)\$($vm.VmxFile)" "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$($vm.Name).vmx" linked
    Write-Host "Starting $($vm.Name) Virtual Machine"
    .\vmrun -T ws start "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$($vm.Name).vmx"
}

# Wait for vms to be in ready state, and then create our file.
Start-Sleep -Seconds 5

# Remove the file if it already exists (optional, depending on your use case)
if (Test-Path $filePath) {
    Remove-Item $filePath
}

# Create the file and ensure it's in the correct format
$lines | Out-File -FilePath $filePath -Encoding ascii

# Wait for hosts to be alive
Write-Host "Waiting for hosts to come to life." 
Start-Sleep -Seconds 45

# Create our runcmd file.
Write-Host "Gathering runcmd.ps1"
Set-Location "C:\Users\GCCISAdmin\Desktop"
Invoke-WebRequest -O "C:\Users\GCCISAdmin\Desktop\runcmd.ps1" https://raw.githubusercontent.com/leahkvares/sys-admin-final/refs/heads/main/runcmd.ps1

# Use our runcmd to create test files on the windows host, just in case
#.\runcmd.ps1 -Target Client -Exec Powershell "curl -O 'C:\Users\Student\Desktop\script.ps1' https://raw.githubusercontent.com/leahkvares/sys-admin-final/refs/heads/main/testremote.ps1" # Test remote execution
#.\runcmd.ps1 -Target Client -Exec Cmd "C:\Users\Student\Desktop\script.ps1" # Test remote execution of local file
.\runcmd.ps1 -Target Server -Exec Powershell "curl -O 'C:\Users\Administrator\Desktop\ADSetup.ps1' https://raw.githubusercontent.com/leahkvares/sys-admin-final/refs/heads/main/ADsetup.ps1" # Add first script
.\runcmd.ps1 -Target Server -Exec Powershell "curl -O 'C:\Users\Administrator\Desktop\ADSetup2.ps1' https://raw.githubusercontent.com/leahkvares/sys-admin-final/refs/heads/main/ADsetup2.ps1" # Add second script
.\runcmd.ps1 -Target Server -Exec Powershell "curl -O 'C:\Users\Administrator\Desktop\ADSetup3.ps1' https://raw.githubusercontent.com/leahkvares/sys-admin-final/refs/heads/main/ADsetup3.ps1" # Add second script

# Run the first script
Write-Host "Running AD Setup 1"
.\runcmd.ps1 -Target Server -Exec Cmd "C:\Users\Administrator\Desktop\ADSetup.ps1" # Test remote execution of local file
Start-Sleep 180
Write-Host "Completed AD Setup 1"
Write-Host "Running AD Setup 2"
.\runcmd.ps1 -Target Server -Exec Cmd "C:\Users\Administrator\Desktop\ADSetup2.ps1" # Test remote execution of local file
Start-Sleep 360
Write-Host "Completed AD Setup 2"
Write-Host "Running AD Setup 3"
.\runcmd.ps1 -Target Server -Exec Cmd "C:\Users\Administrator\Desktop\ADSetup3.ps1"
Start-Sleep 20
Write-Host "Completed AD Setup 3"
