# Devtron
```
Kubernetes software delivery workflow, debugging, monitoring and holistic access management
```

## Requirements
```
Helm
```

## Installation
- Install with Helm GitHub
```
helm repo add devtron https://helm.devtron.ai
helm install devtron devtron/devtron-operator --create-namespace --namespace devtroncd
kubectl -n devtroncd get installers installer-devtron -o jsonpath='{.status.sync.status}'
```

- Install with Gitee
```
helm repo add devtron https://helm.devtron.ai
helm install devtron devtron/devtron-operator --create-namespace --namespace devtroncd --set installer.source=gitee
```

- Wait up to 20 minutes to confirm all components. You can check logs install on here
```
kubectl logs -f -l app=inception -n devtroncd
```

## Ingress Installation
- Install ingress for access
```
kubectl apply -f devtron-ing.yaml -n devtroncd
```

## Dashboard
```
kubectl get svc -n devtroncd devtron-service -o jsonpath='{.status.loadBalancer.ingress}'
```

## Credentials
```
username : admin
password : $ kubectl -n devtroncd get secret devtron-secret -o jsonpath='{.data.ACD_PASSWORD}' | base64 -d
```

## Delete
```
helm uninstall devtron --namespace devtroncd
kubectl delete -n devtroncd -f https://raw.githubusercontent.com/devtron-labs/charts/main/charts/devtron/crds/crd-devtron.yaml
kubectl delete -n argo -f https://raw.githubusercontent.com/devtron-labs/devtron/main/manifests/yamls/workflow.yaml
kubectl delete ns devtroncd devtron-cd devtron-ci devtron-demo
```

## Source
```
https://docs.devtron.ai/
```