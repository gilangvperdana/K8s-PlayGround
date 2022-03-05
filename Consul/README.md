## Consul

```
Service mesh observability & monitoring tools.
```

## Environment

```
1. Kubernetes Cluster
2. Helm
```

## Installation Version 1

```
$ helm repo add hashicorp https://helm.releases.hashicorp.com
$ helm search repo hashicorp/consul
$ helm install consul hashicorp/consul --set global.name=consul --create-namespace --namespace consul

OR if you want to use another config on yaml, you can use this :
$ helm install consul hashicorp/consul --create-namespace --namespace consul --values config.yaml
```

## Installation Version 2

```
$ helm install --values helm-consul-values.yaml consul hashicorp/consul --version "0.40.0"
```

## Inject Consul

```
$ kubectl label namespace your_namespace connect-inject=enabled

Check :
$ kubectl get ns --show-labels

OR with annotations on deployment :
---
      annotations:
        'consul.hashicorp.com/connect-inject': 'true'
---
```

## Dashboard

```
noTLS :
$ kubectl port-forward service/consul-server --namespace consul 8500:8500
Access on : http://localhost:8500

withTLS:
$ kubectl port-forward service/consul-server --namespace consul 8501:8501
Access on : https://localhost:8501

with ACLs Enabled (get Token):
$ kubectl get secrets/consul-bootstrap-acl-token --template='{{.data.token | base64decode }}'
```

## Source

```
https://www.consul.io/
https://learn.hashicorp.com/tutorials/consul/kubernetes-minikube
```