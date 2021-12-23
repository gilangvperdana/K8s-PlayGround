## Installation K8s with Minikube

```
Minikube just for Learning Purpose.
```

## Environment :
```
1. 1x Ubuntu 21.04
2. NAT Network & Host Only Adapter
```

## Installation Minikube :
```
$ apt install -y docker.io
$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
$ sudo install minikube-linux-amd64 /usr/local/bin/minikube
$ sudo usermod -aG docker $USER && newgrp docker

Installation Kubectl :
$curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
$ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

$ cd /home/<user>
$ minikube start --driver=docker
$ sudo cp -r .kube/ .minikube. /root/
$ sudo kubectl get nodes -o wide 

$ sudo kubectl get nodes
Happy Orchestrating.
```