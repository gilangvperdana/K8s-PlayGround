# Harbor
```
Harbor is an open source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted. Harbor, a CNCF Graduated project, delivers compliance, performance, and interoperability to help you consistently and securely manage artifacts across cloud native compute platforms like Kubernetes and Docker.
```

## Installation
```
helm repo add harbor https://helm.goharbor.io

helm install harbor harbor/harbor\
--create-namespace\
--namespace harbor\
--set clair.enabled=false\
--set trivy.enabled=true\
--set persistence.enabled=false\
--set harborAdminPassword=admin
```

- Parameter
```
--set clair.enabled=false\
--set trivy.enabled=true
--set externalURL=https://harbor.bignetlab.com\
--set persistence.enabled=false \
```

## Connect to Local Docker Environment
- Containerd
```
mkdir -p /etc/containerd/core.harbor.domain
/etc/docker/certs.d/harbor.domain.com/ca.crt
Insert our `ca.crt` `harbor-ingress` on Kubesecret to `ca.crt`

nano /etc/containerd/config.toml
---
          endpoint = ["https://registry.harbor.com"]
    [plugins."io.containerd.grpc.v1.cri".registry.configs]
      [plugins."io.containerd.grpc.v1.cri".registry.configs."registry.harbor.com".tls]
        ca_file = "/etc/containerd/registry.harbor.com/ca.crt"
      [plugins."io.containerd.grpc.v1.cri".registry.configs."registry.harbor.com".auth]
        username = "YOURUSERNAME"
        password = "YOURPASSWORD"
---

Ref : https://copyfuture.com/blogs-details/202204160404132173
```

- Docker
```
mkdir -p /etc/docker/certs.d/harbor.domain.com
touch /etc/docker/certs.d/harbor.domain.com/ca.crt
Insert our `ca.crt` `harbor-ingress` on Kubesecret to `ca.crt`
systemctl restart docker
```

## Store Private Registry Credentials on Kubernetes
```
docker login harbor.domain.com
kubectl create secret generic harbor-registry-secret --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson -n YOUR_NAMESPACE
```

- Type 2
```
kubectl create secret docker-registry harbor-registry-secret \
  --docker-server=<HARBOR_URL> \
  --docker-username=<HARBOR_ADMIN> \
  --docker-password=<HARBOR_PASSWORD> \
  --namespace=<NAMESPACES>
```

- Add this on your manifest
```
spec :
  imagePullSecrets:
          - name:harbor-registry-secret
```

## Source
```
https://github.com/goharbor/harbor
https://goharbor.io/
```
