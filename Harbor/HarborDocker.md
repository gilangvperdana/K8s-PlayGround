# Harbor SelfHosted on Docker Version

### Download Package
```
wget https://gist.githubusercontent.com/kacole2/95e83ac84fec950b1a70b0853d6594dc/raw/ad6d65d66134b3f40900fa30f5a884879c5ca5f9/harbor.sh
chmod +x harbor.sh
sudo ./harbor.sh
```

### Create Selfsigned Ceritificate [OPTIONAL]
- If you have Official TLS, skip this tutor
- Change `registry.yourdomain.com` to your env.

```
cd /path/to/registry.yourdomain.com/
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -sha512 -days 3650 \
 -subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=registry.yourdomain.com" \
 -key ca.key \
 -out ca.crt

openssl genrsa -out registry.yourdomain.com.key 4096
openssl req -sha512 -new \
    -subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=yourdomain.com" \
    -key registry.yourdomain.com.key \
    -out registry.yourdomain.com.csr
	
cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=registry.yourdomain.com
EOF

openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in registry.yourdomain.com.csr \
    -out registry.yourdomain.com.crt
```

### Configure harbor.yml
```
cp harbor.yml.tmpl harbor.yml
```
```
hostname: registry.yourdomain.com

certificate: /path/to/registry.yourdomain.com/registry.yourdomain.com.crt
private_key: /path/to/registry.yourdomain.com/registry.yourdomain.com.key
```

### Install
```
./install.sh
```

### Client Selfsigned Connection
- If you install selfsigned version (like tutor no2, please share TLS cert to client)

```
cd /path/to/registry.yourdomain.com/
openssl x509 -inform PEM -in registry.yourdomain.com.crt -out registry.yourdomain.com.cert
scp ca.crt registry.yourdomain.com.crt registry.yourdomain.com.key ubuntu@YOUR_CLIENT_VM:/etc/docker/certs.d/registry.yourdomain.com/
systemctl restart docker
docker login registry.yourdomain.com
```

## Reference
- https://goharbor.io/docs/1.10/install-config/quick-install-script/
- https://goharbor.io/docs/2.8.0/install-config/configure-https/