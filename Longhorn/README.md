# Longhorn
Cloud-Native distributed storage built on and for Kubernetes

## Installation
```
helm repo add longhorn https://charts.longhorn.io
helm repo update
kubectl create namespace longhorn-system
helm install longhorn longhorn/longhorn --namespace longhorn-system
kubectl -n longhorn-system get pod
```

## Reference
- https://longhorn.io/
- https://github.com/longhorn/longhorn