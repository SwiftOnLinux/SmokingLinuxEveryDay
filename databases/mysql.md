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

### Reset mysql root password

```bash
sudo systemctl stop mysql
sudo mysqld_safe --skip-grant-tables --skip-networking &
mysql -u root
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
FLUSH PRIVILEGES;
sudo kill `cat /var/run/mysqld/mysqld.pid`
sudo systemctl start mysql
```

