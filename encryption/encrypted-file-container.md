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

### Format the unlocked Volume with ext4 filesystem

```bash
sudo mkfs.ext4 /dev/mapper/myVolume
```

### Mount the unlocked volume just like a regular disk to a local directory

```bash
mkdir ~/myPrivateData
sudo mount /dev/mapper/myVolume ~/myPrivateData
sudo chown -R "$USER":"$USER" ~/myPrivateData
```

### Lock the container

```bash
umount ~/myPrivData && cryptsetup luksClose myVolume
```

### Quickly access your container

```bash
sudo cryptsetup luksOpen mycontainer.img myVolume --key-file master.key
sudo mount /dev/mapper/myVolume ~/myPrivateData
```

