## Install Kubevirt
```
# Point at latest release
$ export RELEASE=$(curl https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt)
# Deploy the KubeVirt operator
$ kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/${RELEASE}/kubevirt-operator.yaml
# Create the KubeVirt CR (instance deployment request) which triggers the actual installation
$ kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/${RELEASE}/kubevirt-cr.yaml
# wait until all KubeVirt components are up
$ kubectl -n kubevirt wait kv kubevirt --for condition=Available

## if Virtualization error
kubectl -n kubevirt patch kubevirt kubevirt --type=merge --patch '{"spec":{"configuration":{"developerConfiguration":{"useEmulation":true}}}}'

## for Minikube
minikube addons enable kubevirt
```

## Install Virtctl
```
VERSION=$(kubectl get kubevirt.kubevirt.io/kubevirt -n kubevirt -o=jsonpath="{.status.observedKubeVirtVersion}")
ARCH=$(uname -s | tr A-Z a-z)-$(uname -m | sed 's/x86_64/amd64/') || windows-amd64.exe
echo ${ARCH}
curl -L -o virtctl https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/virtctl-${VERSION}-${ARCH}
chmod +x virtctl
sudo install virtctl /usr/local/bin
virtctl version
```

## Deploy VM
```
kubectl create ns vm
kubectl apply -f vm.yaml -n vm
```

## Check & Start VM
```
kubectl get vms -n vm
virtctl start testvm -n vm
kubectl get vmis -n vm
kubectl describe vms testvm -n vm
kubectl describe vmi testvm -n vm
```

## Remove Kubevirt
```
export RELEASE=$(curl https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt)
kubectl delete -n kubevirt kubevirt kubevirt --wait=true
kubectl delete apiservices v1.subresources.kubevirt.io
kubectl delete mutatingwebhookconfigurations virt-api-mutator
kubectl delete validatingwebhookconfigurations virt-operator-validator
kubectl delete validatingwebhookconfigurations virt-api-validator
kubectl delete -f https://github.com/kubevirt/kubevirt/releases/download/${RELEASE}/kubevirt-operator.yaml --wait=false
kubectl -n kubevirt patch kv kubevirt --type=json -p '[{ "op": "remove", "path": "/metadata/finalizers" }]'
```

## Reference
- https://kubevirt.io/
- https://github.com/kubevirt/kubevirt
