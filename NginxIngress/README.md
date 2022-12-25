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

## Test :
```
To test Nginx Ingress, you can use annotations nginx (metadata) on Ingress yaml :
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
---

After that, use a external ip nginx-ingress to access your services.
```

## Activate Real IP behind Reverse Proxy
- Edit configmap
```
data:
  proxy-real-ip-cidr: 172.20.1.2/32
  use-forwarded-headers: "true"
  compute-full-forwarded-for: "true"
```

- Edit service (myingress-ingress-nginx-controller)
```
  externalTrafficPolicy: Local
```

## Source :
```
https://kubernetes.github.io/ingress-nginx/
```
