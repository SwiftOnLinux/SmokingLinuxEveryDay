## Encrypted file container using LUKS

### Installations

```bash
sudo apt-get install cryptsetup
```

### Create an empty file with the size of your container

```bash
fallocate -l 100M mycontainer.img
```

or

```bash
dd if=/dev/urandom of=mycontainer.img bs=1M count=100
```

### Using a keyfile

```bash
dd if=/dev/urandom of=mykey.key bs=1024 count=1
```

### Encrypting disk image file

```bash
sudo cryptsetup -y luksFormat mycontainer.img
```

or

```bash
sudo cryptsetup luksFormat -d mykey.key mycontainer.img
```

### Unlock/Open LUKS encrypted container

* creates a device file with the name /dev/mapper/myVolume

```bash
sudo cryptsetup luksOpen mycontainer.img myVolume
```

or

```bash
sudo cryptsetup luksOpen mycontainer.img -d mykey.key myVolume
```

### Create an ext4 filesystem on the decrypted LUKS container

```bash
sudo mkfs.ext4 /dev/mapper/myVolume
```

### Mount the device

```bash
mkdir ~/myPrivData
sudo mount /dev/mapper/myVolume ~/myPrivData
sudo chown -R $USER ~/myPrivData
```

### Unmount/close decrypted LUKS container

```bash
sudo umount ~/myPrivData && sudo cryptsetup luksClose myVolume && rm -r ~/myPrivData
```

### Quickly Access Container

```bash
sudo cryptsetup luksOpen mycontainer.img myVolume && mkdir ~/myPrivData && sudo mount /dev/mapper/myVolume ~/myPrivData
```

or

```bash
sudo cryptsetup luksOpen mycontainer2.img -d mykey.key myVolume && mkdir ~/myPrivData && sudo mount /dev/mapper/myVolume ~/myPrivData
```

