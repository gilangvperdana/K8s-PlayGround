# Self Container Registry on K8s
```
Provisioning Container Image Registry on Kubernetes Cluster
```

## Installation
```
git clone https://github.com/gilangvperdana/K8s-PlayGround
cd K8s-PlayGround/
kubectl create ns kube-registry
kubectl apply -f reg.yaml
```

## Access
```
kubectl get all -n kube-registry
and Registry will run on 30100 with NodePort.
```
## Push & Pull
```
This is just Docker push & pull documentation, you can use test.yaml file to execute or try your private registry project.
```

### Push
```
docker pull gilangvperdana/research:nginxv1.0.0
docker tag gilangvperdana/research:nginxv1.0.0 localhost:30100/nginx:v1.0.0
docker push localhost:30100/nginx:v1.0.0
```

### Pull
```
docker pull localhost:30100/nginx

OR you can try on you K8s Cluser, with :
kubectl apply -f test.yaml
```

## Source
```
https://medium.com/@lumontec/running-container-registries-inside-k8s-6564aed42b3a
```