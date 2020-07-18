## Encrypted file container using LUKS

### Installations

```bash
sudo apt install cryptsetup
```

### Create an empty container e.g. 1GB

```bash
fallocate -l 1GB mycontainer.img
```

or

```bash
dd if=/dev/zero of=mycontainer.img bs=1M count=0 seek=1G 
```

### Generate a random 4096 master key to unlock the container

```bash
dd if=/dev/urandom of=master.key bs=4096 count=1
```

### Encrypt the container

```bash
sudo cryptsetup -y -c aes-xts-plain64 -s 512 -h sha512 -i 5000 --use-random luksFormat mycontainer.img master.key
```

### Unlock the container

* creates a device file at /dev/mapper/myVolume

```bash
sudo cryptsetup luksOpen mycontainer.img myVolume --key-file master.key
```

### Create an ext4 filesystem on the decrypted LUKS container

```bash
mkfs.ext4 /dev/mapper/myVolume
```

### Mount the device

```bash
mkdir ~/myPrivData
mount /dev/mapper/myVolume ~/myPrivData
chown -R $USER ~/myPrivData
```

### Unmount/close decrypted LUKS container

```bash
umount ~/myPrivData && cryptsetup luksClose myVolume && rm -rf ~/myPrivData
```

### Quickly Access Container

```bash
cryptsetup luksOpen mycontainer.img myVolume && mkdir ~/myPrivData && mount /dev/mapper/myVolume ~/myPrivData
```

or

```bash
cryptsetup luksOpen mycontainer2.img -d mykey.key myVolume && mkdir ~/myPrivData && mount /dev/mapper/myVolume ~/myPrivData
```

