# sys-admin-final

On the lab machine, open PowerShell and run:
```
Invoke-WebRequest -O example.ps1 "https://secretwebsite.com"
.\example.ps1
```
This will run the follow scripts:
- create-vms.ps1
- ADsetup.ps1
- ADsetup2.ps1
- ADsetup3.ps1
- create-users.ps1
- Win10setup.ps1

Rocky Linux
- Turn on Wired Connection
- Install git
```
ansible-galaxy collection install community.general
```

```
ansible-playbook -i inventory playbook.yml --ask-become-pass
```

pfSense
```
pfctl -d
```
- Navigate to WAN IP address in lab machine web browser. Upload XML config (iagnostics > Backup & Restore).
