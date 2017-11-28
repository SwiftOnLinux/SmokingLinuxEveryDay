## postfix setup

### Installation

```bash
apt-get install postfix
apt-get install dovecot-common dovecot-imapd dovecot-pop3d
apt-get install libsasl2-modules postfix sasl2-bin
```

### Configuration

```bash
postconf -e 'myorigin = example.com'
postconf -e 'myhostname = example.com'
postconf -e 'relay_domains = example.com'
postconf -e 'home_mailbox = Maildir/'
postconf -e 'smtpd_sasl_local_domain = $myhostname'
postconf -e 'smtpd_sasl_auth_enable = yes'
postconf -e 'broken_sasl_auth_clients = yes'
postconf -e 'smtpd_sasl_security_options = noanonymous'
postconf -e 'smtpd_recipient_restrictions = permit_sasl_authenticated, permit_mynetworks, reject_unauth_destination'
postconf -e "smtp_sasl_auth_enable = yes"
```

### Generating SSL certificates

```bash
openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -out /etc/ssl/certs/mailcert.pem -keyout /etc/ssl/private/mail.key
```

### Antispam - smtp restrictions

* Edit /etc/postfix/main.cf

```bash
myhostname=example.com
mydomain=example.com
myorigin=example.com

smtpd_tls_security_level = may
smtpd_tls_cert_file=/etc/ssl/certs/mailcert.pem
smtpd_tls_key_file=/etc/ssl/private/mail.key
smtpd_use_tls=yes
smtpd_tls_auth_only=no
smtpd_tls_loglevel = 1 
smtp_tls_note_starttls_offer = yes 
smtpd_tls_session_cache_timeout = 3600s

smtpd_recipient_restrictions = permit_sasl_authenticated,
        reject_invalid_hostname,
        reject_unknown_recipient_domain,
        reject_unauth_destination,
        reject_rbl_client sbl.spamhaus.org,
        permit
        
smtpd_helo_restrictions = reject_invalid_helo_hostname,
        reject_non_fqdn_helo_hostname,
        reject_unknown_helo_hostname
        
smtpd_client_restrictions = reject_rbl_client dnsbl.sorbs.net

home_mailbox = Maildir/
mailbox_command =

smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
```

### Edit /etc/postfix/master.cf

* Uncomment 

```
submission inet n       -       -       -       -       smtpd
  -o syslog_name=postfix/submission
  -o smtpd_tls_security_level=encrypt
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject
  -o milter_macro_daemon_name=ORIGINATING
smtps     inet  n       -       -       -       -       smtpd
  -o syslog_name=postfix/smtps
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject
  -o milter_macro_daemon_name=ORIGINATING
smtp      inet  n       -       -       -       -       smtpd -v
```

* Append line

```
dovecot   unix  -       n       n       -       -       pipe
  flags=DRhu user=email:email argv=/usr/lib/dovecot/deliver -f ${sender} -d ${recipient}
```

### /etc/dovecot/conf.d/

* Edit 10-ssl.conf

```
ssl = yes
ssl_cert = </etc/ssl/certs/mailcert.pem
ssl_key = </etc/ssl/private/mail.key
```

* 10-master.conf

* Uncomment

```
service auth {
  # Postfix smtp-auth (was commented)
  unix_listener /var/spool/postfix/private/auth {
    mode = 0660
    user = postfix
    group = postfix
  }
}
```

### /etc/dovecot/conf.d/10-auth.conf

```
auth_mechanisms = plain login
```

### /etc/postfix/sasl/smtpd.conf

```
pwcheck_method: saslauthd
mech_list: PLAIN LOGIN
```

### saslauthd's config file

* Create a copy

```
cp /etc/default/saslauthd /etc/default/saslauthd-postfix
```

* Edit

```
START=yes
DESC="SASL Auth. Daemon for Postfix"
NAME="saslauthd-postf"      # max. 15 char.
# Option -m sets working dir for saslauthd (contains socket)
OPTIONS="-c -m /var/spool/postfix/var/run/saslauthd"        # postfix/smtp in chroot()
```

### Create required subdirectories in postfix chroot directory

```
dpkg-statoverride --add root sasl 710 /var/spool/postfix/var/run/saslauthd
```

### Add the user "postfix" to the group "sasl"

```
adduser postfix sasl
```

### Reload/Restart

```bash
service saslauthd  restart
service dovecot restart
service postfix restart
```

### Test SMTP AUTH using Telnet

```bash
perl -MMIME::Base64 -e 'print encode_base64("username");'
perl -MMIME::Base64 -e 'print encode_base64("password");'
```

```bash
telnet localhost 25
EHLO mailserver.com
AUTH LOGIN
quit
```

