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
kubectl restart rollout deployment/csi-snapshotter -n longhorn-system
```

## Backup to Minio/S3
- Create Secret
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

## Reference
- https://longhorn.io/
- https://github.com/longhorn/longhorn
- https://github.com/kubernetes-csi/external-snapshotter
