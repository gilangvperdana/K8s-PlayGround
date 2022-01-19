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

## Source
```
https://argo-cd.readthedocs.io/en/stable/
https://github.com/argoproj/argo-cd
https://tanzu.vmware.com/developer/guides/argocd-gs
```