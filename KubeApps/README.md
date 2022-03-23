## KubeApps
```
Kubeapps is a web-based UI for deploying and managing applications in Kubernetes clusters.
```

## Env
```
1. Kubernetes Cluster
2. Helm
```

## Installation
```
helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace kubeapps
helm install kubeapps --namespace kubeapps bitnami/kubeapps
```

## Access on
```
echo "Kubeapps URL: http://127.0.0.1:8080"
kubectl port-forward --namespace kubeapps service/kubeapps 8080:80
```

## Source
```
https://kubeapps.com/
```