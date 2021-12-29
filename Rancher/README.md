## Rancher Installation
```
From datacenter to cloud to edge, Rancher lets you deliver Kubernetes-as-a-Service.
```

```
Environment :
1. Kubernetes Cluster
2. Helm
```

Installation Rancher :
```
Helm Repo Add :
$ helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

Create a namespaces :
$ kubectl create namespace cattle-system

Install Cert Manager:
If you have installed the CRDs manually instead of with the `--set installCRDs=true` option added to your Helm install command, you should upgrade your CRD resources before upgrading the Helm chart:
$ kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.1/cert-manager.crds.yaml

Add the Jetstack Helm repository
$ helm repo add jetstack https://charts.jetstack.io

Update your local Helm chart repository cache
$ helm repo update

Install the cert-manager Helm chart
$ helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.5.1

Check Cert-Manager POD :
$ kubectl get pods --namespace cert-manager

Install Rancher with Rancher-Generated Certificates :
$ helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org \
  --set replicas=3

Check Rancer :
$ kubectl -n cattle-system rollout status deploy/rancher
$ kubectl -n cattle-system get deploy rancher
```

## Access :
```
You can access on default Ingress Rancher Endpoint on https://rancher.my.org
```

## Source
```
https://rancher.com/docs/rancher/v2.5/en/installation/install-rancher-on-k8s/
```