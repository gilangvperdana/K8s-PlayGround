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

## Dashboard

```
kubectl port-forward svc/kuma-control-plane -n kuma-system 5681:5681
Access on 127.0.0.1:5681/gui
```

## Source

```
https://kuma.io
https://kuma.io/docs/1.5.x/installation/kubernetes/
```