### nginx (LEMP)

```bash
apt install nginx
```

### MySQL

```bash
apt-get install mysql-server
```

### Init MySQL db

```bash
mysql_install_db
```

### Secure MySQL configuration

```bash
mysql_secure_installation
```

### PHP

```bash
apt install php-fpm php-mysql
```

### index.php

```bash
nano /etc/nginx/sites-available/default
index index.html index.php index.htm index.nginx-debian.html;
```

### run php

```bash
location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php7.0-fpm.sock;
}

location ~ /\.ht {
    deny all;
}
```

### PHPMyAdmin

```bash
apt install phpmyadmin
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
sudo php5enmod mcrypt
sudo nano /var/lib/phpmyadmin/blowfish_secret.inc.php
```

### Restart Apache2

```bash
systemctl restart php7.0-fpm.service
systemctl restart nginx.service
```

