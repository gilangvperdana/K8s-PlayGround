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
# To configure endpoint Connection address 
[plugins."io.containerd.grpc.v1.cri".registry.mirrors]
[plugins."io.containerd.grpc.v1.cri".registry.mirrors."core.harbor.domain"]
endpoint = ["https://core.harbor.domain"]
# To configure ca File path, user name and password 
[plugins."io.containerd.grpc.v1.cri".registry.configs]
[plugins."io.containerd.grpc.v1.cri".registry.configs."core.harbor.domain".tls]
ca_file = "/etc/containerd/core.harbor.domain/ca.crt"
[plugins."io.containerd.grpc.v1.cri".registry.configs."core.harbor.domain".auth]
username = "admin"
password = "Harbor12345"
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
