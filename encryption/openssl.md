### Remove RSA private key PEM password
```bash
openssl rsa -in ~/.ssh/id_rsa -out ~/.ssh/id_rsa_2
mv ~/.ssh/id_rsa_2 ~/.ssh/id_rsa
chmod 0400 ~/.ssh/id_rsa
```

