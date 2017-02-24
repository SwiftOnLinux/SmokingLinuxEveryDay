### Sync local and remote folder
```bash
rsync --rsh="/usr/bin/ssh" -rtvs --progress --delete /local/path/to/folder user@example.com:/path/to/folder
```

### Sync local and remote folder - specify authentication
```bash
rsync --rsh="/usr/bin/ssh -o PreferredAuthentications=password" -rtvs --progress --delete /local/path/to/folder user@example.com:/path/to/folder
```

### Usage Example
rsync --exclude='*.swp' --exclude='.gitignore' --exclude='.git/' --rsh="/usr/bin/ssh -o PreferredAuthentications=password" -rtvs --progress --delete ~/work/project1 user@example.com:/home/user/work/


