<#
  Author: David Girard
  Date: 11/19/2024
  Description: This file creates and starts all of the virtual machines required for running. 
#>
# Move to the VMrun directory
Set-Location "C:\Program Files (x86)\VMware\VMware Workstation"

# Clone and start the rocky VM
.\vmrun -T ws clone "C:\Virtual Machines\Rocky 9\Rocky 9.vmx" "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\Rocky 9.vmx" linked
.\vmrun -T ws start "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\Rocky 9.vmx"

# Clone and start the pfSense VM
.\vmrun -T ws clone "C:\Virtual Machines\pfSense-2.5.1\pfSense-2.5.1.vmx" "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\pfSense-2.5.1.vmx" linked
.\vmrun -T ws start "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\pfSense-2.5.1.vmx"
