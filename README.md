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
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```


Rocky Linux
```
ansible-galaxy collection install community.general
```

```
ansible-playbook -i inventory playbook.yml --ask-become-pass
```
