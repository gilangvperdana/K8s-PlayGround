# General
Kubernetes Dashboard will easily your life

## Installation
- Default Installation
```
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
```

- Customize deploy (with Loadbalancer for Kong Proxy)
```
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard -f values.yaml
```

## Access
```
kubectl get svc -n kubernetes-dashboard
```

## Get Token for Admin
```
kubectl create sa cluster-admin-sa -n default
kubectl create clusterrolebinding cluster-admin-sa --serviceaccount=default:cluster-admin-sa --clusterrole=cluster-admin

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
 name: cluster-admin-sa-secret
 namespace: default
 annotations:
   kubernetes.io/service-account.name: cluster-admin-sa
type: kubernetes.io/service-account-token
EOF

kubectl get secret/cluster-admin-sa-secret -n default -o jsonpath='{.data.token}' | base64 -d
```

## Get Token for Viewer
```
kubectl create sa viewer-sa -n default
kubectl create clusterrolebinding viewer-sa-binding --serviceaccount=default:viewer-sa --clusterrole=view
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: viewer-sa-secret
  namespace: default
  annotations:
    kubernetes.io/service-account.name: viewer-sa
type: kubernetes.io/service-account-token
EOF
kubectl get secret/viewer-sa-secret -n default -o jsonpath='{.data.token}' | base64 -d
```

## Reference
- https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
- https://github.com/kubernetes/dashboard
