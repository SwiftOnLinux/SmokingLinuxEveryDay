### Installation

```bash
sudo apt-get install mysql-server
sudo mysql_install_db
sudo mysql_secure_installation
```

### Init database and User

```bash
mysql -u root -p
create user 'username'@'%' identified by 'user-password';
create database mydatabase;
grant all privileges on mydatabase.* to 'username'@'%';
exit
```

