# RBAC on K8s with SA (Service Account)
- Will be create with user with name `gl`
- `gl` can `get,list,watch,create,update` on all namespace
- `gl` can't delete pod on all namespace

### Create Service Accounts
```
kubectl create serviceaccount gl -n dev
```

### Create Cluster Role
```
kubectl create clusterrole gl --verb=get,list,watch,create,update --resource=pods,pods/status,namespaces,deployments
```

### Create Cluster Role Binding
```
kubectl create clusterrolebinding gl-binding --clusterrole=gl --serviceaccount=dev:gl
```

### Attach Kubeconfig to a new User
```
kubectl view-serviceaccount-kubeconfig gl -n dev > ~/.kube/glconfig
export KUBECONFIG=~/.kube/glconfig
```

# RBAC on K8s with User Role Binding
- User `gl` just can operate on `application` namespace.

### Create Namespace
```
apiVersion: v1
kind: Namespace
metadata:
  name: application
  labels:
    name: gl
```

### Create Role
```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: application
  name: gl
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

### Role Binding Role and Namespace
```
kubectl create rolebinding alice --role gl --user gl -n application
```

### Create Cert
```
openssl genrsa -out gl.key 2048
openssl req -new -key gl.key -out gl.csr -subj "/CN=gl/O=user"

## Copy ca kubernetes to folder
cp /etc/kubernetes/pki/ca.crt .
cp /etc/kubernetes/pki/ca.key .

openssl x509 -req -in gl.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out gl.crt -days 10000
```

### Bind Cert to KubeConfig
```
kubectl config set-credentials gl --client-certificate=./gl.crt  --client-key=gl.key
kubectl config set-context gl-context --cluster=cluster.local --namespace=application --user=gl

## Try
kubectl get pod -n application
```

##### Convert file certificate to certificate data
```
cat "certificate file" | base64 >> CERT-TEMP
awk 'NF {sub(/\r/, ""); printf "%s",$0;}' ./CERT-TEMP > CERT-FINAL
```

## Reference
- https://anaisurl.com/kubernetes-rbac/