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

## MetalLB Kind :
```
Check IP Pool :
$ docker network inspect bridge
Default is : 172.17.0.0/16

StrictARP True :
$ kubectl edit configmap -n kube-system kube-proxy
---
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
  strictARP: true
---

$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml

$ nano configmap.yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 172.17.255.1-172.17.255.250  
---
$ kubectl apply -f configmap.yaml
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