## K3d 

```
k3d is a lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker.
```

## Install Docker First

```
$ sudo apt-get update
$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
$ sudo groupadd docker
$ sudo usermod -aG docker $USER
$ newgrp docker 
$ sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
$ sudo chmod g+rwx "$HOME/.docker" -R
$ sudo systemctl enable docker.service
$ sudo systemctl enable containerd.service
```


## Installation

```
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
k3d cluster create testcls1 --agents 3 --servers 1

Multi Node Without traefik & serviceLB :
k3d cluster create testcls1 --agents 3 --servers 1 --k3s-arg "--disable=traefik@server:0"

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