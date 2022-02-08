## K3d 

```
k3d is a lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker.
```

## Installation

```
Install Docker :
apt update -y && apt install -y docker.io

Install Kubectl :
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin
kubectl version

Install k3d :
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
```

## Cluster

```
Create cluster:
k3d cluster create testcls1

Without traefik & serviceLB :
k3d cluster create testcls1 --k3s-arg "--disable=traefik@server:0"

Multi Node  :
k3d cluster create testcls1 --agents 1 --servers 2

Multi Node Without traefik & serviceLB :
k3d cluster create testcls1 --agents 1 --servers 3 --k3s-arg "--disable=traefik@server:0"

List cluster :
k3d cluster list

Start Cluster :
k3d cluster start testcls1

Stop Cluster :
k3d cluster stop testcls1

Delete Cluster :
k3d cluster delete testcls1
```

## Source

```
https://github.com/rancher/k3d
https://k3d.io/
```