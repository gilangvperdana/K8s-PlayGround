## CheatSheet

```
Indonesian-English CheatSheet
```

## Syntax
```
Melihat NODE :
kubectl get nodes
kubectl get nodes --show-labels
kubectl get pods --all-namespace
kubectl describe node NAMANODES

PRINT ULANG TOKEN JOIN AWAL:
setelah node dan master terinstalasi kubernetes, lakukan ini pada master:
kubeadm init
kubeadm token create --print-join-command (paste sytanx token pada node yang akan dikirimkan)

DEPLOY DASHBOARD:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
kubectl proxy

COBA DEPLOY IMAGE TANPA yaml:
kubectl create deployment nginx-web --image=gilangvperdana/apps:rlinear

Membuat Deployment:
kubectl create deployment NAMADEPLOYMENT --image=NAMAIMAGE

kubectl get deploy
kubectl delete deploy NAMADEPLOY

Membuat replica dari Deployment:
kubectl scale --replicas=4 deployment/NAMADEPLOYMENT

Membuat NameSpace:
kubectl create NAMANAMESPACE

Cara masuk kedalam POD:
kubectl exec -it PODNAME bash

Melihat POD:
kubectl get pods
kubectl get pods -o wide
kubectl describe pod NAMAPOD
kubectl delete pod NAMAPOD

DELETE SERVICE/POD/DEPLOYMENT DARI YAML:
kubectl delete -f NAMAFILEYANGUDAHDICREATE.yaml

Membuat POD (Service) :
kubectl run NAMAPOD --image=NAMAIMAGE --port=80

MENGHAPUS REPLICA SET:
kubectl get replicaset
kubectl delete replicaset NAMAREPLICASET

kubectl get service
kubectl delete svc NAMASERVICE
kubectl describe svc NAMASERVICE

GANTI CLUSTER KUBECTL :
kubectl config use-context <nama_cluster>

DEPLOY APLIKASI DARI KUBERNETES:
Membuat deployment dari Config YAML:
buat file .yaml dengan konfigurasi umum deployment kubernetes.
kubectl create -f namayamlfile.yaml

Membuat service untuk di exposed dari Config YAML:
kubectl create -f namayamlfile.yaml

Define Storage Class PVC :
---
spec:
  storageClassName: standard
---

Ekspos tanpa YAML:
kubectl expose pod NAMAPOD --name=NAMASERVICE --port=PORTJALAN
kubectl expose pod NAMAPOD --name=NAMASERVICE --port=PORTJALAN --type=TIPEPORT (NodePort,ClusterPort,etc).

Manual Scaling deployment kubernetes:
kubectl scale --replicas=5 deployment/NAMADEPLOYMENT

Update Deployment dari Image yang Baru :
kubectl rollout restart deployment deployment_name

CONTAINERD KUBERNETES PRUNE IMAGE NOT USED :
crictl rmi --prune

Autoscalling dengan yaml file/ HPA (HorizontalPodAutoScaler):
kubectl create -f fileHPA.yaml
kubectl get hpa
kubectl describe hpa
kubectl delete hpa NAMAHPA

CEK PODS:
kubectl get pods -n kube-system -l k8s-app=metrics-server
kubectl get pods --namespace kube-system
https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

INSTALASI KOMPOSE UNTUK MENERJEMAHKAN DOCKER COMPOSE KEPADA KUBECTL:
curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose

kompose convert
kubectl apply -f file1.yaml,file2,yaml

kompose --file ./examples/docker-guestbook.yml up

COPY POD TO LOCAL:
kubectl cp name-of-your-pod:/path/to/your_folder /path/on_your_host/to/your_folder

CEK RESOURCE NODE/POD:
kubectl top pod
kubectl top node

CONFIG FILE K8s:
sudo cat /root/.kube/config
kubectl config view --minify --raw

LENS FOR UBUNTU DESKTOP:
sudo snap install kontena-lens --classic

LETAK FILE HOSTS:
Windows 10 - "C:\Windows\System32\drivers\etc\hosts"
Linux - "/etc/hosts"

MENAMBAHKAN LABEL PADA NODE:
kubectl label nodes <node-name> <label-key>=<label-value>

CONTAINERD exec Container :
kubectl get pod <podname> -o jsonpath="{.status.containerStatuses[].containerID}" | sed 's,.*//,,'
kubectl get pod <podname> -o wide
runc --root /run/containerd/runc/k8s.io/ exec -t -u 0 <containerID> sh

Problem :
The connection to the server 10.148.0.5:6443 was refused - did you specify the right host or port?
systemctl restart kubelet

MEMBERIKAN ROLE:
kubectl label nodes NAMANODE node-role.kubernetes.io/worker=worker
```

## Downgrade :
```
$ sudo apt-get install -qy kubelet=1.21.0-00 kubectl=1.21.0-00 kubeadm=1.21.0-00 --allow-downgrades --allow-change-held-packages
Change 1.21.0-00 according to the version you want.
```

## Healtz Error :
```
EKSEKUSI DI  SEMUA NODE:
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

SETELAH ITU INIT ULANG DI MASTER:
$ sudo kubeadm reset && sudo kubeadm init --pod-network-cidr=10.244.XX.0/16
```

## Unhealthy ?
```
$ kubectl get cs
See your health is unhealthy ? do it:

Clear the line (spec->containers->command) containing this phrase: - --port=0
$ sudo nano /etc/kubernetes/manifests/kube-scheduler.yaml
$ sudo nano /etc/kubernetes/manifests/kube-controller-manager.yaml
$ sudo systemctl restart kubelet.service
```
