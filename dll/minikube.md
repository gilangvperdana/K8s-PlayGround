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
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
$ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

$ cd /home/<user>
$ minikube start --kubernetes-version=v1.23.0
$ sudo cp -r .kube/ .minikube/ /root/
$ sudo kubectl get nodes -o wide 

with Specify Memory, CPU, Disk, K8s Version :
$ minikube stop
$ minikube config set memory 8192
$ minikube config set cpus 4
$ minikube start --disk-size 300000 --kubernetes-version=v1.21.9

with Specify Directory on VM :
$ minikube start --mount=true --mount-string=$(HOME)/somedir/on/host/:/somedir/on/vm/ --kubernetes-version=v1.21.9

$ sudo kubectl get nodes
Happy Orchestrating.

To check your cluster Minikube list :
$ minikube profile list
```

## Minikube Container :
```
To see Minikube Container
```
```
$ eval $(minikube docker-env)
$ docker ps
```

## Delte Profile
```
$ minikube delete -p your_profile
```

## Dashboard :
```
$ minikube dashboard
Access the URL below
```

## Important Addons :
```
Ingress on Minikube :
$ minikube addons enable ingress
$ minikube tunnel
```

```
Enable Metrics:
$ minikube addons enable metrics-server 
```

```
Pull from Private Registry :
$ minikube addons configure registry-creds
$ minikube addons enable registry-creds

OR 
$ minikube ssh
$ docker login
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

## Wrong KubeDNS Resolver
```
Sometimes in one of the Linux distros or even the hypervisor can't read KubeDNS like in general on Minikube. This can be overcome by changing the resolv.conf on Minikube.
```
```
$ minikube ssh
$ echo "nameserver 8.8.8.8" > /etc/resolv.conf
```
```
https://gist.github.com/superseb/f6894ddbf23af8e804ed3fe44dd48457
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

## Auto Start Minikube with Systemd
```
nano /usr/lib/systemd/system/minikube.service
```
```
[Unit]
Description=minikube
After=network-online.target firewalld.service containerd.service docker.service
Wants=network-online.target docker.service
Requires=docker.socket containerd.service docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/local/bin/minikube start 
ExecStop=/usr/local/bin/minikube stop
User=minikube

[Install]
WantedBy=multi-user.target
```
```
systemctl daemon-reload 
systemctl enable minikube
systemctl start minikube
```

## Expose to Private Network
```
https://gist.github.com/gilangvperdana/2912ced3f543f7dc7f909eebd103684e
```
