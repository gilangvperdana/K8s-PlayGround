## Kong Mesh

```
Enterprise-grade service mesh for multi-cloud and multi-cluster on both Kubernetes and VMs. Konnect-native from mesh to API gateway
```

## Installation

```
curl -L https://docs.konghq.com/mesh/installer.sh | sh -
cd kong-mesh-1.6.0/bin
kumactl install control-plane --license-path=/path/to/license.json | kubectl apply -f -
ln -s ./kumactl /usr/local/bin/kumactl
kubectl get pod -n kong-mesh-system

Check :
kubectl get meshes
```

## Inject Sidecar
```
Inject to some namespaces
```
```
apiVersion: v1
kind: Namespace
metadata:
  name: kuma-demo
  namespace: kuma-demo
  labels:
    kuma.io/sidecar-injection: enabled
```

## mTLS
```
Kong Mesh automatically creates a Mesh entity with the name default.
```

```
$ echo "apiVersion: kuma.io/v1alpha1
  kind: Mesh
  metadata:
    name: default
  spec:
    mtls:
      enabledBackend: ca-1
      backends:
      - name: ca-1
        type: builtin" | kubectl apply -f -
```

## Source

```
https://konghq.com/kong-mesh/
https://docs.konghq.com/mesh/1.6.x/installation/kubernetes/?_ga=2.8299504.330456497.1646485419-931820898.1646485419
```