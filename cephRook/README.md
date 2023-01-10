## Ceph Rook Backend Storage
Provisioning Ceph Rook for Kubernetes Backend Storage

## Assume
- This workaround has been tested on Kubernetes v1.25.5 AIO

## Provisioning 
```
## Deploy operator & crd
git clone https://github.com/rook/rook.git
cd rook/deploy/examples/
kubectl create -f crds.yaml -f common.yaml -f operator.yaml

## Modify cluster.yaml
See on this repo for example of cluster.yaml

## Deploy
kubectl create -f cluster.yaml
```

## On AIO K8s Ceph Rook Cluster
- on `cluster.yaml` is example for AIO K8s Cluster
```
kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash
ceph osd getcrushmap -o /etc/ceph/crushmap
crushtool -d /etc/ceph/crushmap -o /etc/ceph/crushmap.txt
sed -i 's/step chooseleaf firstn 0 type host/step chooseleaf firstn 0 type osd/' /etc/ceph/crushmap.txt
grep 'step chooseleaf' /etc/ceph/crushmap.txt
crushtool -c /etc/ceph/crushmap.txt -o /etc/ceph/crushmap-new
ceph osd setcrushmap -i /etc/ceph/crushmap-new
ceph -s
```

## Reference
- https://faun.pub/deploy-rook-ceph-on-kubernetes-3a2252f3732e
- https://blog.csdn.net/weixin_42126962/article/details/117785220?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp