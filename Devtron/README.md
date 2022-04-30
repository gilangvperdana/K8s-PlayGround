# Devtron
```
Kubernetes software delivery workflow, debugging, monitoring and holistic access management
```

## Requirements
```
Helm
```

## Installation
```
helm repo add devtron https://helm.devtron.ai
helm install devtron devtron/devtron-operator --create-namespace --namespace devtroncd 
```

## Credentials
```
username : admin
password : $ kubectl -n devtroncd get secret devtron-secret -o jsonpath='{.data.ACD_PASSWORD}' | base64 -d
```

## Source
```
https://docs.devtron.ai/
```