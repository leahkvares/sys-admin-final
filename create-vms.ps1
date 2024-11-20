<#
  Author: David Girard
  Date: 11/19/2024
  Description: This file creates and starts all of the virtual machines required for running. 
#>

# Move to the VMrun directory
Set-Location "C:\Program Files (x86)\VMware\VMware Workstation"

# List of VMs to create and start
$vmList = @("Rocky 9", "pfSense-2.5.1", "VLWindows_10_22h2")

# Loop through each VM in the list
foreach ($vm in $vmList) {
    Write-Host "Creating $vm Virtual Machine"
    .\vmrun -T ws clone "C:\Virtual Machines\$vm\$vm.vmx" "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$vm.vmx" linked
    Write-Host "Starting $vm Virtual Machine"
    .\vmrun -T ws start "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$vm.vmx"
}
