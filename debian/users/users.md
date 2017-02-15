### how many days ago the user password has been changed
```bash
echo $(( ( $(date -u '+%s') -  $(date -ud "$(passwd -S <username> | cut -d' ' -f3)" +'%s') )/60/60/24 )) days
```

### Add user to group
```bash
usermod -aG <group_name> <username>
```

### Create new users group
```bash
groupadd <group_name>
```

### Create new user with home dir
```bash
useradd -m <username>
```

### Change user password
```bash
echo "$username:$newpassword" | chpasswd
```

### Check if group exists
```bash
    grep -q "group_name" /etc/group; echo $?
```

### Check if user exists
```bash
    id -u <username> 1>/dev/null 2>&-; echo $?
```

### Generate password
```bash
newpassword=$(tr -dc 'a-zA-Z0-9!@#$%^&*:./?=+_[]{}()<>' < /dev/urandom | head -c 20)
newpassword="$(sed s/[\'\"\`\\]/*/g <<<$newpassword)"
```

