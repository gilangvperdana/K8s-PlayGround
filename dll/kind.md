## Kind - Kubernetes Lightweight
```
Kind is a tool for running local Kubernetes clusters using Docker container “nodes”.
Kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI.
```


## Environment :
```
1. Ubuntu 18.04
2. 50GB Storage
```

## Installation Kind Cluster:
```
$ curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
$ chmod +x ./kind
$ mv ./kind /usr/local/bin/kind

$ touch config
---
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
---
$ kind create cluster --name k8s --config config #adjust the name "k8s" to yours.
```

## Installation Kubectl :
```
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
$ chmod +x kubectl
$ mkdir -p ~/.local/bin/kubectl
$ sudo mv ./kubectl /usr/local/bin
```

## Check :
```
$ kubectl get nodes -o wide
```

## Delete Cluster :
```
$ kind get clusters
$ kind delete cluster --name k8s #k8s is your name of your cluster.
```

## Source :
```
https://kind.sigs.k8s.io/
```