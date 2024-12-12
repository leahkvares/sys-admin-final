# Command line parameters
param (
  [string]$Target,
  [string]$Exec
)

# Runs a command using the vmrun utility.
$OriginalDirectory = (Get-Item .).FullName
$VmRunDirectory = "C:\Program Files (x86)\VMware\VMware Workstation"
$ClientFile = "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\VLWindows_10_22h2.vmx"
$ServerFile = "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\WinServer2k22.vmx"
#$CommandLineArgument = $args[0]

# Remote files
$PowerShellExecutable = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$CmdExecutable = "C:\Windows\System32\cmd.exe"

# Move directories
Set-Location $VmRunDirectory

# Decide which host we are using
if ($Target -ieq "Server") {
    $HostFile = $ServerFile
    $User = "Administrator"
} elseif ($Target -ieq "Client") {
    $HostFile = $ClientFile
    $User = "Student"
} else {
    Write-Host "Unknown Target value"
    exit 1
}

# Decide which executable we're using
if ($Exec -ieq "Cmd") {
    $HostExec = $CmdExecutable
    $Prefix = "/C $PowerShellExecutable -ExecutionPolicy Bypass -File"
} elseif ($Exec -ieq "Powershell") {
    $HostExec = $PowerShellExecutable
    $Prefix = ""
} else {
    Write-Host "Unknown Exec value"
    exit 1
}

# Start the process with the arguments
.\vmrun -T ws -gu $User -gp 'student' runProgramInGuest $HostFile -noWait -activeWindow $HostExec "$Prefix $($args[0].toString())"

Set-Location $OriginalDirectory
