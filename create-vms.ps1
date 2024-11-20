<#
  Author: David Girard
  Date: 11/19/2024
  Description: This file creates and starts all of the virtual machines required for running. 
#>
# Move to the VMrun directory
Set-Location "C:\Program Files (x86)\VMware\VMware Workstation"
$rocky="Rocky 9"
$pfSense="pfSense-2.5.1"
$windows="VLWindows_10_22h2"

# Clone and start the rocky VM
Write-Host "Creating $($rocky) Virtual Machine"
.\vmrun -T ws clone "C:\Virtual Machines\$($rocky)\$($rocky).vmx" "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$($rocky).vmx" linked
Write-Host "Starting $($rocky) Virtual Machine"
.\vmrun -T ws start "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$($rocky).vmx"

# Clone and start the pfsense VM
Write-Host "Creating $($pfSense) Virtual Machine"
.\vmrun -T ws clone "C:\Virtual Machines\$($pfSense)\$($pfSense).vmx" "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$($pfSense).vmx" linked
Write-Host "Starting $($pfSense) Virtual Machine"
.\vmrun -T ws start "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$($pfSense).vmx"

# Clone and start the windows VM
Write-Host "Creating $($windows) Virtual Machine"
.\vmrun -T ws clone "C:\Virtual Machines\$($windows)\$($windows).vmx" "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$($windows).vmx" linked
Write-Host "Starting $($windows) Virtual Machine"
.\vmrun -T ws start "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\$($windows).vmx"
