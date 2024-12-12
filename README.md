# sys-admin-final

```
Invoke-WebRequest -O example.ps1 "https://secretwebsite.com"
.\example.ps1
```

Run in this order:
- create-vms.ps1
- ADsetup.ps1
- ADsetup2.ps1
- create-users.ps1
- Win10setup.ps1


Rocky Linux setup
```
ansible-galaxy collection install community.general
```

```
ansible-playbook -i inventory playbook.yml --ask-become-pass
```
