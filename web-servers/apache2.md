### Installation

```bash
sudo apt-get install apache2 -y
sudo rm -f /var/www/html/index.html && sudo touch /var/www/html/index.html
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo service apache2 restart
```

### Redirect to https

```bash
<VirtualHost *:80>
...
...
Redirect permanent / https://example.com/
..
</VirtualHost>
```

or

```bash
RewriteEngine on
RewriteCond %{HTTPS} !=on
RewriteRule ^.*$ https://%{SERVER_NAME}%{REQUEST_URI} [R,L]
```

### Redirect to folder

```bash
<IfModule mod_rewrite.c>
RewriteEngine on
Options +FollowSymLinks
RewriteRule ^$ /owncloud [L]
</IfModule>
```

