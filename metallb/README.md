## MetalLB

## Installation :
```
$ kubectl edit configmap -n kube-system kube-proxy

---
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
  strictARP: true #if false, set to true
---

$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml

$ nano confmap.yaml
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
      - 192.168.80.2-192.168.80.254 #Define to your network pool.
---

$ kubectl apply -f confmap.yaml -n metallb-system
```

## Source :
```
https://metallb.universe.tf/installation/
```