### Generate SLL/TLS Kubernetes Nginx Ingress :

```
SELF SIGNED VERSION
```
```
$ openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout tls.key -out tls.crt -subj "/CN=example.com" -days 365
$ kubectl create secret tls example-com-tls --cert=tls.crt --key=tls.key

Add line on ingress.yaml:
spec:
--------------------------------------
  tls:
    - secretName: posts-com-tls
      hosts:
        - example.com
--------------------------------------
  rules:
```

```
Testing :
$ curl -k https://example.com
```
