## K8s BARE METAL INSTALLATION:

```
Virtual Box version.
```

## Environment :
```
A. Minimum system requirements :
2 Virtual Machine.
4 GB Ram .
2 VCPU.

B. Component :
Ubuntu Server 21.04 LTS.
Putty.
```

## Installation :
```
EDIT HOSTNAME
$ hostnamectl set-hostname master // do on master node
$ hostnamectl set-hostname worker0 // do on worker0 node
$ hostnamectl set-hostname worker1 // do on worker1 node 

Hosts file edit, define all ip node:
$ nano /etc/hosts

$ apt update
$ apt-get full-upgrade
$ apt install -y docker.io
$ systemctl status docker.service

$ sudo mkdir /etc/docker
$ cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
$ sudo systemctl enable docker
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker

CONTAINERD Version :
$ sudo apt-get install containerd -y
$ sudo mkdir -p /etc/containerd
$ sudo su -
$ containerd config default > /etc/containerd/config.toml

LALU UBAH PADA KUBEADM_FLAGS:
$ nano /var/lib/kubelet/kubeadm-flags.env
--container-runtime=remote --container-runtime-endpoint=/run/containerd/containerd.sock

$ nano /etc/fstab
Turn off the swap memory :
$ swapoff -a
$ nano /etc/sysctl.conf
#net.ipv4.ip_forward=1
$ sysctl -p

$ apt install -y apt-transport-https curl
$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
$ apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
$ apt update
$ apt install -y kubelet kubeadm kubectl

ON MASTER:
$ kubeadm config images pull
$ sudo kubeadm init

$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
$ export KUBECONFIG=/etc/kubernetes/admin.conf
$ kubeadm token create --print-join-command (paste on worker node to join cluster)

JOIN WORKER NODE:
PASTE TOKEN from Master.

ON MASTER:
$ kubectl get nodes
$ kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

CEK IP KUBERNETES:
$ kubectl cluster-info

$ kubectl get nodes -o wide
Happy Orchestrating!
```

## Full Documentation :
```
https://gilangvperdana.medium.com/installation-kubernetes-cluster-baremetal-4d70e733ea15
```