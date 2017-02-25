### Secure ssh access
```bash
sed -i "s/Port 22/Port 65001/g" /etc/ssh/sshd_config
sed -i "s/PermitRootLogin without-password/PermitRootLogin no/g" /etc/ssh/sshd_config
echo "" >> /etc/ssh/sshd_config
echo "AllowGroups wheel" >> /etc/ssh/sshd_config
echo "" >> /etc/ssh/sshd_config
echo "DebianBanner no" >> /etc/ssh/sshd_config
```

