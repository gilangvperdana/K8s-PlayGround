## Skooner

```
A Kubernetes Dashboard that helps you understand & manage your cluster.
```

## Installation
```
$ kubectl apply -f https://raw.githubusercontent.com/skooner-k8s/skooner/master/kubernetes-skooner.yaml
```

## Access
```
$ touch ingress-skooner.yaml

---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: skooner
  namespace: kube-system
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/use-regex: "true"
spec:
  rules:
    - host: skooner.monitoring.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: skooner
                port: 
                  number: 80
---

$ kubectl apply -f ingress-skooner.yaml

# Create the service account in the current namespace (we assume default)
$ kubectl create serviceaccount skooner-sa

# Give that service account root on the cluster
$ kubectl create clusterrolebinding skooner-sa --clusterrole=cluster-admin --serviceaccount=default:skooner-sa

# Find the secret that was created to hold the token for the SA
$ kubectl get secrets

# Show the contents of the secret to extract the token
$ kubectl describe secret skooner-sa-token-xxxxx
```

## Source
```
https://github.com/skooner-k8s/skooner
https://skooner.io/
```