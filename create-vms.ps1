<#
  Author: David Girard
  Date: 11/19/2024
  Description: This file creates and starts all of the virtual machines required for running. 
#>

# Move to the VMrun directory
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

Start-Sleep -Seconds 25
Invoke-WebRequest -O "C:\Users\GCCISAdmin\vmrest.cfg" https://raw.githubusercontent.com/leahkvares/sys-admin-final/refs/heads/main/vmrest.cfg
.\vmrest.exe
