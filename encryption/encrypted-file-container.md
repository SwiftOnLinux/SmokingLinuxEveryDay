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

### Using a keyfile

```bash
dd if=/dev/urandom of=mykey.key bs=1024 count=1
```

### Encrypting disk image file

```bash
cryptsetup -y luksFormat mycontainer.img
```

or

```bash
cryptsetup luksFormat -d mykey.key mycontainer.img
```

### Unlock/Open LUKS encrypted container

* creates a device file with the name /dev/mapper/myVolume

```bash
cryptsetup luksOpen mycontainer.img myVolume
```

or

```bash
cryptsetup luksOpen mycontainer.img -d mykey.key myVolume
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

