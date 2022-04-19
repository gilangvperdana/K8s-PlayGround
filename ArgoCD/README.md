## ArgoCD

```
Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.
```

## Installation
```
$ kubectl create namespace argocd
$ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Login
```
User : admin

Password :
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## ArgoCLI
```
$ curl -LO https://github.com/argoproj/argo-cd/releases/download/v2.1.7/argocd-linux-amd64
$ mv argocd-linux-amd64 argocd
$ chmod +x argocd
$ sudo mv argocd /usr/local/bin/
```

## Source
```
https://argo-cd.readthedocs.io/en/stable/
https://github.com/argoproj/argo-cd
https://tanzu.vmware.com/developer/guides/argocd-gs
```