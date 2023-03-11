#!/bin/bash

# Ask user for domain
echo "Please enter the domain name (e.g. example.com):"
read DOMAIN

# Ask user for Kubernetes namespace
echo "Please enter the Kubernetes namespace to deploy the secret to:"
read NAMESPACE

# Ask user for secret name
echo "Please enter the name of the secret:"
read SECRET_NAME

# Generate CA private key
openssl genrsa -out ca.key 2048

# Generate CA certificate
openssl req -x509 -new -nodes -key ca.key -subj "/CN=my-ca" -days 3650 -out ca.crt

# Generate server private key
openssl genrsa -out server.key 2048

# Generate Certificate Signing Request
openssl req -new -key server.key -subj "/CN=$DOMAIN" -out server.csr

# Generate server certificate using CA
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 3650

# Create a Kubernetes secret with the server certificate, key, and CA certificate
echo '---
apiVersion: v1
kind: Secret
metadata:
  name: '$SECRET_NAME'
  namespace: '$NAMESPACE'
type: kubernetes.io/tls
data:
  tls.crt: '$(cat server.crt | base64 -w0)'
  tls.key: '$(cat server.key | base64 -w0)'
  ca.crt: '$(cat ca.crt | base64 -w0)'
' | kubectl apply -f -
