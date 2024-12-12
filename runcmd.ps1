# Runs a command using the vmrun utility.
$VmRun = "C:\Program Files (x86)\VMware Workstation\vmrun.exe"
$VmxFiles = "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal"
$ClientFile = "$VmxFiles\VLWindows_10_22h2.vmx"
$ServerFile = "$VmxFiles\WinServer2k22.vmx"

# Remote files
$PowerShellExecutable = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$CmdExecutable = "C:\Windows\System32\cmd.exe"

# Command line parameters
param (
  [string]Host
  [string]Exec
)

# Decide which host we are using
if ($Host -ieq "Server") {
    $HostFile = $ServerFile
    $User = "Administrator"
} elseif ($Host -ieq "Client") {
    $HostFile = $ClientFile
    $User = "Student"
} else {
    Write-Host "Unknown Host value"
    exit 1
}

# Decide which executable we're using
if ($Exec -ieq "Cmd") {
  $HostExec = $CmdExecutable
  $Arguments = "-T ws -gu '$User' -gp 'student' runProgramInGuest '$HostFile' -noWait -activeWindow -interactive '$HostExec' '/C powershell.exe -ExecutionPolicy Bypass -File $args[0]'"
} elseif ($Exec -ieq "Powershell") {
  $HostExec = $PowerShellExecutable
  $Arguments = "-T ws -gu '$User' -gp 'student' runProgramInGuest '$HostFile' -noWait -activeWindow -interactive '$HostExec' '$args[0]'"
} else {
  Write-Host "Unknown Exec value"
  exit 1
}

Start-Process -FilePath $VmRun -ArgumentList $Arguments
