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

## Check IPAdressPool
```
kubectl get ipaddresspools.metallb.io -n metallb-system
```

## New Version
- https://metallb.universe.tf/installation/
- https://docs.okd.io/4.10/networking/metallb/metallb-configure-address-pools.html

## Error
- 1
```
If you get a message error on Metallb_Speaker POD like "secret 'memberlist' not found" you can try :
$ kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
```

- 2
```
If you deploy on top of Openstack, you can disable your `Instance Port Security` if you want to access metall-lb pool outside the cluster
```

- 3
```
If after external_ip appears but still DHU from Outside, makesure external IP from metallb is appear on `ip a` if not appear please attach manually with

---
ip addr add IP_EXTERNAL/32 dev ens3
---
```

## Source :
```
https://metallb.universe.tf/installation/
```
