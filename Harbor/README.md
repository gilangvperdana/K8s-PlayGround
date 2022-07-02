# Harbor
```
Harbor is an open source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted. Harbor, a CNCF Graduated project, delivers compliance, performance, and interoperability to help you consistently and securely manage artifacts across cloud native compute platforms like Kubernetes and Docker.
```

## Installation
```
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

## Source
```
https://github.com/goharbor/harbor
https://goharbor.io/
```