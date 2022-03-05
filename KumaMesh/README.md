## Kuma Mesh
```
The open-source control plane for service mesh,
delivering security, observability, routing and more
```

## Installation

```
curl -L https://kuma.io/installer.sh | sh -
cd kuma-*/bin
./kumactl install control-plane | kubectl apply -f -
ln -s ./kumactl /usr/local/bin/kumactl
kubectl get pod -n kuma-system
kubectl get meshes
```

## Source

```
https://kuma.io
https://kuma.io/docs/1.5.x/installation/kubernetes/
```