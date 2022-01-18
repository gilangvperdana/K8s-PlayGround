## NGINX Ingress
```
Ingress may provide load balancing, SSL termination and name-based virtual hosting.
```

## Installation :
```
$ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
$ kubectl create ns ingress-nginx
$ helm install myingress ingress-nginx/ingress-nginx -n ingress-nginx
$ helm list -n ingress-nginx
$ kubectl get all -n igress-nginx
```

## Source :
```
https://kubernetes.github.io/ingress-nginx/
```