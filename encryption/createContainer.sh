## https://null-byte.wonderhowto.com/how-to/hide-sensitive-files-encrypted-containers-your-linux-system-0186691/

#!/bin/bash

    G="\033[1;32m";
    N="\033[0;39m";
    function notification ()
    {
        echo -e "$G" "\n[+] $1" "$N"
    };
    function nameVol ()
    {
        read -p "Name of encrypted container (e.g., "Vault", "grocerylist.txt"): " vol_name;
        if [[ ! -n "$vol_name" ]]; then
            vol_name='EncryptedContainer';
        fi
    };
    function nameKey ()
    {
        read -p "Name of Key file (e.g., "master.keyfile", "image.jpg"): " key_file;
        if [[ ! -n "$key_file" ]]; then
            key_file='master.keyfile';
        fi
    };
    function nameMount ()
    {
        read -p "Where to mount the container when it's unlocked (e.g., "luksPrivate"): " mount_dir;
        if [[ ! -n "$mount_dir" ]]; then
            mount_dir='luksPrivate';
        fi
    };
    function nameSize ()
    {
        read -p "Choose volume size (e.g., 10G, 200M): " vol_size;
        if [[ ! -n "$vol_size" ]]; then
            vol_size='1G';
        fi
    };
    function ddZero ()
    {
        dd if=/dev/zero of="$vol_name" bs=1 count=0 seek="$vol_size" && notification "Empty volume created."
    };
    function ddRandom ()
    {
        dd if=/dev/urandom of="$key_file" bs=4096 count=1 && notification "Key file successfully created."
    };
    function encryptCon ()
    {
        sudo cryptsetup -y -c aes-xts-plain64 -s 512 -h sha512 -i 5000 --use-random luksFormat "$vol_name" "$key_file" && notification "Encrypted container created."
    };
    function encryptOpen ()
    {
        sudo cryptsetup luksOpen "$vol_name" "$mount_dir" --key-file "$key_file" && notification "Volume unlocked."
    };
    function mkfsFormat ()
    {
        sudo mkfs.ext4 /dev/mapper/"$mount_dir" && notification "Volume formatted."
    };
    function mountDir ()
    {
        if [[ ! -d $HOME/"$mount_dir"/ ]]; then
            mkdir -p $HOME/"$mount_dir"/;
        fi;
        sudo mount /dev/mapper/"$mount_dir" "$HOME"/"$mount_dir"/ && notification "Volume mounted."
    };
    function volPerm ()
    {
        sudo chown -R "$USER":"$USER" "$HOME"/"$mount_dir" && notification "Volume permissions set. Don't lose the Key file!"
    };
    nameVol;
    nameKey;
    nameMount;
    nameSize;
    ddZero;
    ddRandom;
    encryptCon;
    encryptOpen;
    mkfsFormat;
    mountDir;
    volPerm
