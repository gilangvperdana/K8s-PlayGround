### Generate SLL/TLS Kubernetes Istio Ingress :

```
SELF SIGNED VERSION
```
```
$ openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example.com.key -out example.com.crt

OR for subdomain :
$ openssl req -out sub.example.com.csr -newkey rsa:2048 -nodes -keyout sub.example.com.key -subj "/CN=sub.example.com/O=sub organization"
$ openssl x509 -req -days 365 -CA example.com.crt -CAkey example.com.key -set_serial 0 -in sub.example.com.csr -out sub.example.com.crt


THEN,
$ kubectl create -n istio-system secret tls post-credential --key=post.com.key --cert=post.com.crt

Add line on IstioGateway.yaml:
---
$ cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: mygateway
spec:
  selector:
    istio: ingressgateway # use istio default ingress gateway
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    tls:
      mode: SIMPLE
      credentialName: httpbin-credential # must be the same as secret
    hosts:
    - httpbin.example.com
EOF
---

Add line on IstioVirtualService.yaml
---
$ cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
  - "httpbin.example.com"
  gateways:
  - mygateway
  http:
  - match:
    - uri:
        prefix: /status
    - uri:
        prefix: /delay
    route:
    - destination:
        port:
          number: 8000
        host: httpbin
EOF
---
```

```
Testing :
$ curl -k https://example.com
```
