### Remove RSA private key PEM password
```bash
openssl rsa -in ~/.ssh/id_rsa -out ~/.ssh/id_rsa_2
mv ~/.ssh/id_rsa_2 ~/.ssh/id_rsa
chmod 0400 ~/.ssh/id_rsa
```

### Create CSR with SAN
```bash
openssl req -new -key subdomain.example.com.key -out subdomain.example.com.req -config myssl.cnf
```

#### myssl.cnf Contents
```
[req]
default_bits       = 2048
distinguished_name = req_distinguished_name
req_extensions     = req_ext
[ req_distinguished_name ]
countryName                = Country Name (2 letter code)
stateOrProvinceName        = State or Province Name (full name)
localityName               = Locality Name (eg, city)
organizationName           = Organization Name (eg, company)
commonName                 = Common Name (e.g. server FQDN or YOUR name)
[ req_ext ]
subjectAltName = @alt_names
[alt_names]
DNS.1   = ns1.example.com
DNS.2   = ns2.example.com
DNS.3   = ns3.example.com
```

