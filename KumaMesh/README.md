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
sudo cp -r ./kumactl /usr/local/bin/
kubectl get pod -n kuma-system
kubectl get meshes
```

## Dashboard

```
kubectl port-forward svc/kuma-control-plane -n kuma-system 5681:5681
Access on 127.0.0.1:5681/gui
```

## Install Kuma Metrics

```
kumactl install metrics | kubectl apply -f -
```

```
echo "apiVersion: kuma.io/v1alpha1
kind: Mesh
metadata:
  name: default
spec:
  mtls:
    enabledBackend: ca-1
    backends:
    - name: ca-1
      type: builtin
  metrics:
    enabledBackend: prometheus-1
    backends:
    - name: prometheus-1
      type: prometheus" | kubectl apply -f -
```

```
Access Grafana :
kubectl port-forward svc/grafana -n kuma-metrics 3000:80
```

## Inject Kuma Mesh
```
kubectl apply -f mesh-inject.yaml -n your_namespace
```

## Source

```
https://kuma.io
https://kuma.io/docs/1.5.x/installation/kubernetes/
```