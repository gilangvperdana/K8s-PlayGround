## MetalLB
```
MetalLB is a load-balancer implementation for bare metal Kubernetes clusters, using standard routing protocols.
```


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

## Error
```
If you get a message error on Metallb_Speaker POD like "secret 'memberlist' not found" you can try :
$ kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
```

## Source :
```
https://metallb.universe.tf/installation/
```