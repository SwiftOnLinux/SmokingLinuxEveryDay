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
[req_distinguished_name]
countryName			= Country Name (2 letter code)
countryName_default		= GR
countryName_min			= 2
countryName_max			= 2
stateOrProvinceName		= State or Province Name (full name)
stateOrProvinceName_default	= MyProvinceName
localityName			= Locality Name (eg, city)
localityName_default	= MyCityName
0.organizationName		= Organization Name (eg, company)
0.organizationName_default	= MyCompany
organizationalUnitName		= Organizational Unit Name (eg, section)
organizationalUnitName_default	= MySection
commonName			= Common Name (eg, YOUR name)
commonName_default  = subdomain.example.com
commonName_max		= 64
emailAddress			= Email Address
emailAddress_default	= info@example.com
emailAddress_max		= 40
[ req_ext ]
subjectAltName = @alt_names
[alt_names]
DNS.1   = ns1.example.com
DNS.2   = ns2.example.com
```

