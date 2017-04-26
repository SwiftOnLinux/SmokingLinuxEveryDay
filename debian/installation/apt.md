### Apt - Install latest packages

* For jessie add this line to your sources.list:
```
deb http://ftp.debian.org/debian jessie-backports main
```

* Update
```bash
sudo apt-get update
```

* Add key
```bash
gpg --keyserver pgpkeys.mit.edu --recv-key  xxxxxxxxxxxxxxxxx
gpg -a --export xxxxxxxxxxxxxxxxx | sudo apt-key add -
sudo apt-get update
```

* Installation
```bash
sudo apt-get -t jessie-backports install <pacjagename>
```
