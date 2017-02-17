### days since last system update (sort of)
```bash
echo $(( ( $(date -u '+%s') -  $(stat -c %Y /var/cache/apt/) )/60/60/24 ))
```

### Update repos silently
```bash
apt update -qq
```

### Upgrade system silently
```bash
apt dist-upgrade -qq -y
```


