#!/bin/bash

# Meminta input dari user
read -p "Masukkan URL (misal: app01.k8s01-istio.test.link): " URL
read -p "Masukkan Nama Service (misal: app01-service): " SERVICE_NAME

# Generate TLS Certificate
openssl req -new -newkey rsa:2048 -nodes -keyout tls.key -out tls.csr -subj "/CN=$URL"
openssl x509 -req -days 365 -in tls.csr -signkey tls.key -out tls.crt

# Membuat secret di Kubernetes
kubectl create secret tls ${SERVICE_NAME}-tls --cert=tls.crt --key=tls.key -n istio-system

# Deploy Gateway
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: mygateway
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    tls:
      mode: SIMPLE
      credentialName: ${SERVICE_NAME}-tls
    hosts:
    - $URL
EOF

# Deploy VirtualService
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: ${SERVICE_NAME}
spec:
  hosts:
  - "$URL"
  gateways:
  - mygateway
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        port:
          number: 80
        host: ${SERVICE_NAME}
EOF

echo "Konfigurasi berhasil diterapkan untuk $SERVICE_NAME dengan URL $URL"
