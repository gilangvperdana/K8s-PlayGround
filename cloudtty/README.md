## Cloud TTY
Want to provision an CLI based WEB for Kubernetes, CloudTTY is the answer!

## Installation
```
helm repo add cloudtty https://release.daocloud.io/chartrepo/cloudshell
helm repo update
helm install cloudtty-operator cloudtty/cloudtty
kubectl apply -f https://raw.githubusercontent.com/cloudtty/cloudtty/v0.5.0/config/samples/local_cluster_v1alpha1_cloudshell.yaml
kubectl get cloudshell -w
```

## Reference
- https://github.com/cloudtty/cloudtty