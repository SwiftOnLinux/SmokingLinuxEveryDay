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

