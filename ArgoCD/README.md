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

## Change to Loadbalancer Service
```
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

## Apply Notification to Slack or Teams
```
## Change this line to our environment
nano cm-argonotif.yaml

---
## FOR SLACK
  subscriptions: |
    - recipients:
      - slack:NAME_OF_CHANNEL_ON_SLACK
      triggers:
      - on-sync-status-succeeded
  service.slack: |
    token: xoxb-1420182XXXXX-43847063XXXXX-J4mUxJXhvSkd1rhbjnXXXXX

## FOR TEAMS
##  service.teams: |
##    recipientUrls:
##      TeamsAN: https://ADAPTIVE.webhook.office.com/webhookb2/XXXX

kubectl apply -f cm-argonotif.yaml -n argocd
```

## ArgoCD CLI with JWT Token
```
https://yetiops.net/posts/argocd-jenkins-pipeline/
argocd login argocd.server.com:443 --skip-test-tls --grpc-web
argocd proj role create-token default jenkins-deploy-role
```

## Source
```
https://argo-cd.readthedocs.io/en/stable/
https://github.com/argoproj/argo-cd
https://tanzu.vmware.com/developer/guides/argocd-gs
https://yetiops.net/posts/argocd-jenkins-pipeline/
https://argo-cd.readthedocs.io/en/stable/getting_started/
```
