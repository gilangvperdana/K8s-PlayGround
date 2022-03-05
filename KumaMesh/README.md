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

Access : 127.0.0.1:3000
Username : admin
Password : admin
```

```
Allow metrics :

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

## Inject Kuma Mesh
```
kubectl apply -f mesh-inject.yaml -n your_namespace
```

## Kong Ingress
```
HOST=$(kubectl get svc --namespace postsapp kong-1646489558-kong-proxy -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
PORT=$(kubectl get svc --namespace postsapp kong-1646489558-kong-proxy -o jsonpath='{.spec.ports[0].port}')
export PROXY_IP=${HOST}:${PORT}
curl $PROXY_IP
```

## Source

```
https://kuma.io
https://kuma.io/docs/1.5.x/installation/kubernetes/
```