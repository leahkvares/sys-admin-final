# sys-admin-final

```
Invoke-WebRequest -O example.ps1 "https://secretwebsite.com"
.\example.ps1
```

Windows Server
- create-vms.ps1
- ADsetup.ps1
- ADsetup2.ps1
- create-users.ps1

Windows 10
- Win10setup.ps1
```
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass
```
```
netsh advfirewall set currentprofile state off
```


Rocky Linux
```
nmcli connection up Wired\ connection\ 1
```
```
ansible-galaxy collection install community.general
```

```
ansible-playbook -i inventory playbook.yml --ask-become-pass
```

Windows Run Remote Host
Test file:
```
.\vmrun -T ws -gu "Student" -gp "student" runProgramInGuest "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\VLWindows_10_22h2.vmx" "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "curl -O 'C:\Users\Student\Desktop\script.ps1' https://raw.githubusercontent.com/leahkvares/sys-admin-final/refs/heads/main/testremote.ps1"
```

Run test file:
```
.\vmrun -T ws -gu "Student" -gp "student" runProgramInGuest "C:\Users\GCCISAdmin\Documents\Virtual Machines\SysAdminFinal\VLWindows_10_22h2.vmx" -noWait -activeWindow -interactive "C:\Windows\System32\cmd.exe" "/C powershell.exe -ExecutionPolicy Bypass -File C:\Users\Student\Desktop\script.ps1"
```
