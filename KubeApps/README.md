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

## Generate Access Token
```
kubectl create --namespace default serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
kubectl get --namespace default secret $(kubectl get --namespace default serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo
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