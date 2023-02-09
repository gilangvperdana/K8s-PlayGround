## K3S Provisioning

```
Lightweight Kubernetes Version
```

## Installation
```
$ curl -sfL https://get.k3s.io | sh -

# Check for Ready node,
takes maybe 30 seconds
$ k3s kubectl get node

## To specify kubeApi port
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--https-listen-port 7443" sh -

## To specify domain
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--https-listen-port 7443 --cluster-domain lab.k3s.org" sh -
```

## Multi Node
```
Define at /etc/hosts on all nodes.
---
x.x.x.x master
x.x.x.x worker
---

On master : 
curl -sfL https://get.k3s.io | sh -
cat /etc/rancher/k3s/k3s.yaml
cat /var/lib/rancher/k3s/server/node-token

on worker :
---
k3s_url="https://master:6443"
k3s_token="K10e485404065a6fba0be6bd3f6fbd8b0f60111e146c31e3d3b83f42591469d5085::server:2a186f686c0705df046dc16ed501e1c0"
curl -sfL https://get.k3s.io | K3S_URL=${k3s_url} K3S_TOKEN=${k3s_token} sh - 
---

Verify on master :
k3s kubectl get node
```

## Data 
```
Kube config is on : /etc/rancher/k3s/k3s.yaml
Kube token is on : /var/lib/rancher/k3s/server/node-token
```

## Source
- https://k3s.io/
- https://github.com/k3s-io/k3s
- https://www.rancher.co.jp/docs/k3s/latest/en/installation/
