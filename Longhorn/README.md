# Longhorn
Cloud-Native distributed storage built on and for Kubernetes

## Installation
```
helm repo add longhorn https://charts.longhorn.io
helm repo update
kubectl create namespace longhorn-system
helm install longhorn longhorn/longhorn --namespace longhorn-system
kubectl -n longhorn-system get pod
```

## Snapshot
If you want to use snapshot feature, somehow we must install CRD external provisioner for `csi-snapshotter` pod
```
git clone https://github.com/kubernetes-csi/external-snapshotter
kubectl apply -f client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml,client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml,client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
kubectl rollout restart deployment/csi-snapshotter -n longhorn-system
```

## Backup to Minio/S3
- Create Secret
  - You can use `cat minio-ssl.pem ca.pem | base64 | tr -d "\n"` to generate base64 tls cert.
    - Warn : As the command shows, SSL certificates in the validation chain must be concatenated and \n characters from the base64 encoded SSL pem must be removed.
```
apiVersion: v1
kind: Secret
metadata:
  name: minio-secret
  namespace: longhorn-system
type: Opaque
data:
  AWS_ACCESS_KEY_ID: # BASE64 minio-access-key
  AWS_SECRET_ACCESS_KEY: # BASE64 minio-secret-key
  AWS_ENDPOINTS: # BASE64 https://min.io:9000
  AWS_CERT: #BASE64 FULLCHAIN.PEM
  AWS_CERT_KEY: #BASE64 PRIVKEY.PEM
```
- Configure on Longhorn UI
Setting -> General.
  - Backup Target -> `s3://BUCKET_NAME@REGION_NAME/FOLDER_NAME`
  - Backup Target Credential Secret -> `minio-secret`

- Then try to Create a New Backup <br>
   Volume -> Select your PV -> Create a New Backup > then see on Backup tabs (if already there, backup has been succesfully to S3 bucket).

### Activate RWX on Longhorn
- Install nfs common on all nodes
```
sudo apt-get update
sudo apt-get install nfs-common
```

- Create PVC & Deployment for test
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      volumes:
        - name: html-volume
          persistentVolumeClaim:
            claimName: my-pvc
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
          volumeMounts:
            - name: html-volume
              mountPath: /usr/share/nginx/html
```

- See on your nodes
```
df -hT

## Find nfs mounting
```

## Mount block device
- You can see on `/dev/longhorn/` then mount it to your directory with `mount /dev/longhorn/pvc-NAMEOFPVC /root/yourfolder/`

## Reference
- https://longhorn.io/
- https://github.com/longhorn/longhorn
- https://github.com/kubernetes-csi/external-snapshotter
