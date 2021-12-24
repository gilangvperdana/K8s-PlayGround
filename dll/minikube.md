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

## Important Addons :
```
Ingress on Minikube :
$ minikube addons enable ingress
$ minikube tunnel
```

```
Pull from Private Registry :
$ minikube addons configure registry-creds
$ minikube addons enable registry-creds
```

## PV :
```
On MiniKube PV will be on inside MiniKube Container.

You can 
$ ssh minikube ,to go inside minikube container or you can
$ docker exec -it minikube bash

The default PV Path on inside container minikube is on :
/data*
/var/lib/minikube
/var/lib/docker
/var/lib/containerd
/var/lib/buildkit
/var/lib/containers
/tmp/hostpath_pv*
/tmp/hostpath-provisioner*
```

## Monitoring with Lens :
```
You can use Monitoring Tools like Lens [https://k8slens.dev/] with Connect under Tunnel (if you deploy on Linux VirtualBox).
If you use SOCKSPort v5, you can define proxy on lens with :

$ ssh root@ip_vm_minikube -D 500 [do on hosts OS]
Define on lens with proxy :
socks5://127.0.0.1:500

And then copy paste the .kube/config file to Lens YAML. And then you can connect to your cluster and Happy Monitoring !
```