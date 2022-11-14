## NFS Subdir External Provisioner
Make PV with NFS Solution on Kubernetes

## Execution
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-cluster-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=172.16.1.10 \
    --set nfs.path=/mnt/nfs_share/kube \
    --set storageClass.name=nfs-cluster-client \
    --set storageClass.provisionerName=cluster.local/nfs-cluster-provisioner
```

- Note, 172.16.1.10 are your NFS address

## Reference
- https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner