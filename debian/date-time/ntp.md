### Setting the timezone
```bash
sudo dpkg-reconfigure tzdata
```

### Synchronizing time with an NTP server
```bash
sudo apt-get install ntpdate
sudo ntpdate us.pool.ntp.org
```

### Set the hardware clock on your system
```bash
sudo hwclock --systohc
```

### Ensure that your server’s clock is always accurate
```bash
sudo apt-get install ntp
```


