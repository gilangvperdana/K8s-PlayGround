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

- To change from iptables to ebpf on existing calico nodes
  - Ref: https://docs.tigera.io/calico/latest/operations/ebpf/enabling-ebpf
  - Tested on existing calico node on Kubespray cluster
  - Create configmap
  ```
  kind: ConfigMap
  apiVersion: v1
  metadata:
    name: kubernetes-services-endpoint
    namespace: kube-system
  data:
    KUBERNETES_SERVICE_HOST: '<API server host>'
    KUBERNETES_SERVICE_PORT: '<API server port>'
  ```

  - Disable kube-proxy
  ```
  kubectl patch ds -n kube-system kube-proxy -p '{"spec":{"template":{"spec":{"nodeSelector":{"non-calico": "true"}}}}}'
  ```

  - Enable ebpf mode
  ```
  calicoctl patch felixconfiguration default --patch='{"spec": {"bpfEnabled": true}}'
  ```

  - Verify
  ```
  kubectl get felixconfiguration -o yaml
  kubectl exec -n kube-system calico-node-xxxx -- calico-node -bpf counters dump --iface=ens3
  ```

## Canal
```
$ kubectl apply -f https://projectcalico.docs.tigera.io/manifests/canal.yaml
```

## Other
```
https://kubernetes.io/id/docs/concepts/cluster-administration/addons/
```
