### website backup
```bash
wget -m ftp://username:password@example.com/path/to/website
mysqldump -u <username> -p --host example.com <database> > db_baclup.sql
```

