## Container Network Interface

```
Kubernetes uses the Container Network Interface (CNI) to interact with networking providers like Calico, Flannel, Canal.
```

## Flannel
```
$ kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

## Calico
```
$ kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

```
To change MTU :
$ kubectl patch configmap/calico-config -n kube-system --type merge \
  -p '{"data":{"veth_mtu": "1440"}}'
$ kubectl rollout restart daemonset calico-node -n kube-system
```

## Canal
```
$ kubectl apply -f https://projectcalico.docs.tigera.io/manifests/canal.yaml
```

## Other
```
https://kubernetes.io/id/docs/concepts/cluster-administration/addons/
```